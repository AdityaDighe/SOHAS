<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>SOHAS • Book Appointment</title>
<style>
body {
    font-family: Arial, sans-serif;
    background: #f5f7fb;
    margin: 0;
}
.wrap {
    max-width: 800px;
    margin: 40px auto;
    background: #fff;
    padding: 28px;
    border-radius: 10px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
}
h2 { text-align: center; margin-bottom: 20px; }
table { width: 100%; border-collapse: collapse; margin-top: 20px; }
th, td { padding: 12px; border: 1px solid #ddd; text-align: center; }
th { background: #f8f9fa; }
.btn {
    background: #28a745;
    color: #fff;
    border: none;
    padding: 8px 14px;
    border-radius: 6px;
    cursor: pointer;
}
.btn:hover { background: #218838; }
input, select {
    padding: 6px;
    border-radius: 4px;
    border: 1px solid #ccc;
}
.form-section { text-align: center; margin-bottom: 20px; }
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<div class="wrap">
    <h2>Book Appointment</h2>

    <!-- Form Section -->
    <div class="form-section">
        <form id="searchForm">
            <label>Select Date:</label>
            <input type="text" id="appointmentDate" name="appointmentDate" placeholder="YYYY-MM-DD" required 
                   pattern="\d{4}-\d{2}-\d{2}" title="Enter date in format YYYY-MM-DD">

            <label>Select Time:</label>
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

            <label>Select City:</label>
            <select id="city" name="city" required>
                <option value="">-- Select City --</option>
                <option value="Mumbai">Mumbai</option>
                <option value="Chennai">Chennai</option>
                <option value="Pune">Pune</option>
                <option value="Bhopal">Bhopal</option>
            </select>

            <button type="submit" class="btn">Find Doctors</button>
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
            <tbody>
            </tbody>
        </table>
    </div>
</div>

<script>
// Validate date format
document.getElementById("appointmentDate").addEventListener("input", function () {
    let regex = /^\d{4}-\d{2}-\d{2}$/;
    this.setCustomValidity(regex.test(this.value) ? "" : "Please enter the date in YYYY-MM-DD format");
});

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
            success: function (doctors) {

                let tbody = $("#doctorsTable tbody")
                tbody.empty();

                doctors.forEach(doc => {
                    console.log("Loop doc:", doc.doctorName); // check value here
                    tbody.append(
                        "<tr>"+
                            "<td>Dr."+doc.doctorName + "</td>"+
                            "<td>"+doc.hospitalName+"</td>"+
                            "<td>"+doc.speciality+"</td>"+
                            "<td>"+doc.city+"</td>"+
                            "<td>"+
	                            "<form action='/SOHAS/appointment' method='post'>"+
	                                "<input type='hidden' name='doctorId' value="+doc.doctorId+"/>"+
	                                "<input type='hidden' name='appointmentDate' value="+date+" />"+
	                                "<input type='hidden' name='appointmentTime' value="+time+" />"+
	                                "<button type='submit' class='btn'>Book</button>"+
	                            "</form>"+
	                        "</td>"+
                        "</tr>"
                        )
                });
                $("#doctorsSection").show();
            },

            error: function (xhr) {
                console.error(xhr);
                alert("Error fetching doctors. Please try again.");
            }
        });
    });
});
</script>
</body>
</html>