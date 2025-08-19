<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS • Book Appointment</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(180deg, #e6f0ff 0%, #ffffff 100%);
            margin: 0;
        }

        .wrap {
            max-width: 1000px;
            margin: 40px auto;
            background: #fff;
            padding: 28px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #f8f9fa;
        }

        .btn {
            background: #28a745;
            color: #fff;
            border: none;
            padding: 8px 14px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn:hover {
            background: #218838;
        }

        button:hover {
            transform: scale(1.10);
            transition: transform 0.2s ease;
        }

        input, select {
            padding: 6px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .form-section {
            text-align: center;
            margin-bottom: 20px;
            padding: 20px 0;
        }

        .form-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 32px 40px;
            justify-content: center;
            align-items: flex-end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            min-width: 200px;
        }

        .form-group label {
            margin-bottom: 6px;
            font-weight: bold;
            font-size: 14px;
        }

        input[type="date"], select {
            width: 100%;
            padding: 10px;
            font-size: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        .btn {
            width: 100%;
            padding: 10px 16px;
            font-size: 15px;
        }
        
        /* Style only book buttons */
		button.book {
		    background: #28a745;
		    color: white;
		    border: none;
		    padding: 8px 14px;
		    border-radius: 6px;
		    font-size: 14px;
		    font-weight: 600;
		    cursor: pointer;
		    transition: background 0.3s ease, transform 0.2s ease;
		}

		button.book:hover {
		    background: #218838;
		    transform: scale(1.08);
		}
        
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="wrap">
    <h2>Book Appointment</h2>
    <input type="hidden" id="patientId" name="patientId" value="${id}">

    <!-- Form Section -->
    <div class="form-section">
        <form id="searchForm" class="form-grid">
            <div class="form-group">
                <label for="appointmentDate">Select Date:</label>
                <input type="date" id="appointmentDate" name="appointmentDate" required min="">
            </div>

            <div class="form-group">
                <label for="appointmentTime">Select Time:</label>
                <select id="appointmentTime" name="appointmentTime" required>
                    <option value="">-- Select Time --</option>
                    <option value="09:00:00">09:00:00</option>
                    <option value="10:00:00">10:00:00</option>
                    <option value="11:00:00">11:00:00</option>
                    <option value="12:00:00">12:00:00</option>
                    <option value="13:00:00">13:00:00</option>
                    <option value="14:00:00">14:00:00</option>
                    <option value="15:00:00">15:00:00</option>
                    <option value="16:00:00">16:00:00</option>
                    <option value="17:00:00">17:00:00</option>
                    <option value="18:00:00">18:00:00</option>
                </select>
            </div>

            <div class="form-group">
                <label for="city">Select City:</label>
                <select id="city" name="city" required>
                    <option value="">-- Select City --</option>
                    <option value="Mumbai">Mumbai</option>
                    <option value="Chennai">Chennai</option>
                    <option value="Pune">Pune</option>
                    <option value="Bhopal">Bhopal</option>
                </select>
            </div>

            <div class="form-group">
                <button type="submit" class="btn">Find Doctors</button>
            </div>
        </form>
    </div>

    <!-- Doctors Table -->
    <div id="doctorsSection" style="display:none;">
        <h3>Available Doctors</h3>
        <table id="doctorsTable">
            <thead>
            <tr>
                <th>Doctor Name</th>
                <th>Hospital Name</th>
                <th>Speciality</th>
                <th>City</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <!-- No Doctors Message -->
    <div id="noDoctorsMessage" style="display:none; text-align:center; padding: 20px; font-size: 18px; color: #dc3545;">
        
    </div> 
</div>

<script>
// Set min date to tomorrow
document.addEventListener("DOMContentLoaded", function () {
    const dateInput = document.getElementById("appointmentDate");
    const timeSelect = document.getElementById("appointmentTime");

    // Set min date to tomorrow
    const tomorrow = new Date();
    tomorrow.setDate(tomorrow.getDate() + 1);
    const minDate = tomorrow.toISOString().split('T')[0];
    dateInput.setAttribute("min", minDate);

    // Optional: Disable all time options until a date is selected
    const allOptions = [...timeSelect.options].slice(1);
    allOptions.forEach(opt => opt.disabled = true);

    // Enable all time options once a valid date is selected
    dateInput.addEventListener("change", function () {
        allOptions.forEach(opt => opt.disabled = false);
    });
});


// Form submission and booking logic
$(document).ready(function () {
    $("#searchForm").on("submit", function (event) {
        event.preventDefault();

        let date = $("#appointmentDate").val();
        let time = $("#appointmentTime").val();
        let city = $("#city").val();

        $.ajax({
            url: "/SOHAS/patients/doctors",
            type: "GET",
            dataType: "json",
            data: { date: date, time: time, location: city },
            success: function (response) {
            	let doctors = response.data;
            	let tbody = $("#doctorsTable tbody");
                tbody.empty();

                doctors.forEach(doc => {
                    tbody.append(
                        "<tr>" +
                        "<td>Dr. " + doc.doctorName + "</td>" +
                        "<td>" + doc.hospitalName + "</td>" +
                        "<td>" + doc.speciality + "</td>" +
                        "<td>" + doc.city + "</td>" +
                        "<td><button class='book' data-id='" + doc.doctorId + "'>Book</button></td>" +
                        "</tr>"
                    );
                });

                $("#noDoctorsMessage").hide();
                $("#doctorsSection").show();
            },
            error: function (xhr) {
            	$("#noDoctorsMessage").empty();  
                $("#noDoctorsMessage").show();
                $("#doctorsSection").hide();
           	 	try {
                    var errResponse = JSON.parse(xhr.responseText);
                    $("#noDoctorsMessage").append("<h5 style='color:red;'>" + errResponse.message + "</h5>");
                } catch (e) {
                    $("#noDoctorsMessage").append("<h5 style='color:red;'>Unexpected error occurred</h5>");
                }
            }

        });
    });

    // Book button click
    $(document).on("click", ".book", function () {
        let id = $(this).data("id");
        let patientId = "${id}";
        let date = $("#appointmentDate").val();
        let time = $("#appointmentTime").val();

        $.ajax({
            url: "/SOHAS/appointment",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                date: date,
                time: time,
                patient: { patientId: patientId },
                doctor: { doctorId: id }
            }),
            success: function () {
                alert("Appointment booked successfully");
                window.location.href = "${pageContext.request.contextPath}/patientDashboard";
            },
            error: function (xhr) {
                alert("Error: " + xhr.responseText);
                console.log(xhr);
            }
        });
    });
});
</script>

</body>
</html>
