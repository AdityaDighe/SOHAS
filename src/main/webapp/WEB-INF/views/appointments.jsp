<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #fff;
        }

        .wrap {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 20px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(14px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.4);
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 30px;
            letter-spacing: 1px;
            text-shadow: 0 0 8px rgba(0,210,255,0.7);
        }

        /* FORM INLINE */
        .form-inline {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            justify-content: center;
            align-items: flex-end;
            margin-bottom: 30px;
        }

        .form-inline .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-inline label {
            margin-bottom: 4px;
            font-weight: 600;
            color: #fff;
        }

        .form-inline input,
        .form-inline select {
            width: 180px;
            padding: 8px 10px;
            border-radius: 6px;
            border: 1px solid #ddd;
            font-size: 14px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-inline input:focus,
        .form-inline select:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 5px rgba(13,110,253,0.3);
            outline: none;
        }

        .form-inline button {
            padding: 10px 18px;
            font-size: 15px;
            border: none;
            border-radius: 20px;
            background: linear-gradient(135deg, #3a7bd5, #00d2ff);
            color: white;
            cursor: pointer;
            font-weight: 600;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .form-inline button:hover {
            transform: scale(1.08);
            box-shadow: 0 0 18px rgba(0,210,255,0.6);
        }

        /* DOCTORS TABLE */
		table {
		    width: 100%;
		    border-collapse: collapse;
		    table-layout: fixed;   /*makes columns align evenly */
		    margin-top: 20px;
		}
		
		th, td {
		    padding: 14px 18px;
		    text-align: center;
		    vertical-align: middle;
		    word-wrap: break-word; /*prevents text overflow */
		}
		
		th {
		    font-size: 15px;
		    font-weight: bold;
		    letter-spacing: 1px;
		    color: #fff;
		    text-shadow: 0 0 8px rgba(0,210,255,0.8);
		    border-bottom: 2px solid rgba(255,255,255,0.2);
		}
		
		tr {
		    border-bottom: 1px solid rgba(255,255,255,0.1);
		    transition: transform 0.2s ease, box-shadow 0.2s ease;
		}
		
		tr:hover {
		    transform: scale(1.02);
		    box-shadow: 0 0 18px rgba(0,210,255,0.5);
		}

        button.book {
            background: linear-gradient(135deg, #f7971e, #ffd200);
            color: #000;
            border: none;
            padding: 6px 14px;
            border-radius: 20px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
        }

        button.book:hover {
            transform: scale(1.08);
            box-shadow: 0 0 18px rgba(255,220,50,0.8);
        }

        #noDoctorsMessage {
            text-align: center;
            padding: 20px;
            font-size: 18px;
            color: #ff4c60;
            display: none;
        }
        .navbar  a {
		    text-decoration: none !important;
		    color: inherit;
		}
        
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="wrap">
    <h2>Book Appointment</h2>
    <input type="hidden" id="patientId" name="patientId" value="${id}">

    <!-- Form -->
    <form id="searchForm" class="form-inline">
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

        <div class="form-group" style="align-self: flex-end;">
            <button type="submit">Find Doctors</button>
        </div>
    </form>

    <!-- Doctors Table -->
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

   <div id="noDoctorsMessage" style="display:none; text-align:center; padding: 20px; font-size: 18px; color: #dc3545;">
        
    </div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const dateInput = document.getElementById("appointmentDate");
        const timeSelect = document.getElementById("appointmentTime");

        const tomorrow = new Date();
        tomorrow.setDate(tomorrow.getDate() + 1);
        const minDate = tomorrow.toISOString().split('T')[0];
        dateInput.setAttribute("min", minDate);

        const allOptions = [...timeSelect.options].slice(1);
        allOptions.forEach(function(opt) { opt.disabled = true; });

        dateInput.addEventListener("change", function() {
            allOptions.forEach(function(opt) { opt.disabled = false; });
        });
    });

    function getCookie(name) {
        let match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
        return match ? match[2] : null;
    }
	
	let tokenFromCookie1 = getCookie("jwtToken");
 
    $(document).ready(function () {
    	 $("#doctorsTable").hide();
    	$("#searchForm").on("submit", function(event) {
            event.preventDefault();

            var date = $("#appointmentDate").val();
            var time = $("#appointmentTime").val();
            var city = $("#city").val();

            $.ajax({
                url: "/SOHAS/patients/doctors",
                type: "GET",
                dataType: "json",
                data: { date: date, time: time, location: city },
                headers: {
	                "Authorization": "Bearer " + tokenFromCookie1
	            },
                success: function(doctors) {
                	console.log(doctors)
                    var tbody = $("#doctorsTable tbody");
                    tbody.empty();
					
                    if (doctors.data.length === 0) {
                        $("#doctorsTable").hide();
                        $("#noDoctorsMessage").show();
                    } else {
                        for (var i = 0; i < doctors.data.length; i++) {
                            var doc = doctors.data[i];
                            tbody.append(
                                "<tr>" +
                                "<td>Dr. " + doc.doctorName + "</td>" +
                                "<td>" + doc.hospitalName + "</td>" +
                                "<td>" + doc.speciality + "</td>" +
                                "<td>" + doc.city + "</td>" +
                                "<td><button class='book' data-id='" + doc.doctorId + "'>Book</button></td>" +
                                "</tr>"
                            );
                        }
                        $("#noDoctorsMessage").hide();
                        $("#doctorsTable").show();
                    }
                },
                error: function(xhr) {
                	$("#noDoctorsMessage").empty();  
                    $("#noDoctorsMessage").show();
                    $("#doctorsTable").hide();
               	 	try {
                        var errResponse = JSON.parse(xhr.responseText);
                        $("#noDoctorsMessage").append("<h5 style='color:red;'>" + errResponse.message + "</h5>");
                    } catch (e) {
                        $("#noDoctorsMessage").append("<h5 style='color:red;'>Unexpected error occurred</h5>");
                    }
                }
            });
        });

        $(document).on("click", ".book", function() {
            var id = $(this).data("id");
            var patientId = "${id}";
            var date = $("#appointmentDate").val();
            var time = $("#appointmentTime").val();

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
                headers: {
	                "Authorization": "Bearer " + tokenFromCookie
	            },
                success: function() {
                    alert("Appointment booked successfully");
                    window.location.href = "${pageContext.request.contextPath}/patientDashboard";
                },
                error: function(xhr) {
                    alert("Error: " + xhr.responseText);
                    console.log(xhr);
                }
            });
        });
    });
</script>
</body>
</html>
