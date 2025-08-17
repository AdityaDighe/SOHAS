<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS • Patient Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f7fb; margin: 0; background: linear-gradient(180deg, #e6f0ff 0%, #ffffff 100%); }

        .wrap {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            padding: 28px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
        }

        h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        label {
            font-weight: bold;
        }

        select, button {
            padding: 10px;
            margin-top: 10px;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        .btn {
            background: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .btn:hover {
            background: #218838;
        }

        .cancel {
            background: #dc3545;
            color: #fff;
            border: none;
            padding: 6px 10px;
            cursor: pointer;
            border-radius: 4px;
        }

        .cancel:hover {
            background: #b52a37;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #f8f9fa;
        }

        .book-section {
            margin: 20px 0;
            text-align: center;
        }

        .book-section p {
            font-size: 16px;
            margin-bottom: 10px;
        }

        .book-btn {
            background: #007bff;
            color: #fff;
            border: none;
            padding: 10px 16px;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
        }

        .book-btn:hover {
            background: #0069d9;
        }

        button:disabled {
            display: none;
        }

        button.cancel {
            border-radius: 20px;
        }

        td button {
            display: block;
            margin: 0 auto;
        }

        button:hover {
            transform: scale(1.20);
            transition: transform 0.2s ease;
        }

        .status-badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: bold;
            display: inline-block;
            text-transform: uppercase;
        }

        .status-COMPLETED {
            background-color: #28a745;
            color: white;
        }

        .status-BOOKED {
            background-color: #28a745;
            color: white;
        }

        .status-CANCELLED {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="wrap">
    <h2>Welcome, ${username}!</h2>

    <!-- Book Doctor Section -->
    <div class="book-section">
        <p>Looking for a doctor? Book here now</p>
        <a href="http://localhost:8080/SOHAS/patientDashboard/appointment" class="book-btn">Book</a>
    </div>

    <!-- Booked Appointments Section -->
    <h3>Your Appointments</h3>

    <table id="myAppointments">
        <thead>
        <tr>
            <th>Doctor</th>
            <th>Speciality</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<script>
$(document).ready(function() {
    var patientId = "${id}";

    loadAppointments();

    function loadAppointments() {
        $.ajax({
            url: "/SOHAS/patients/appointment/" + patientId,
            method: "GET",
            contentType: "application/json",
            success: function(appointments) {
                var tbody = $("#myAppointments tbody");
                tbody.empty();

                if (appointments.length === 0) {
                    tbody.append("<tr><td colspan='6'>No appointments booked yet.</td></tr>");
                    return;
                }

                appointments.forEach(function(app) {
                    let disabled = app.status === "CANCELLED" ? "disabled" : "";
                    let btnText = app.status === "CANCELLED" ? "Cancelled" : "Cancel";

                    tbody.append(
                        "<tr>" +
                            "<td>Dr. " + app.doctor.doctorName + "</td>" +
                            "<td>" + app.doctor.speciality + "</td>" +
                            "<td>" + app.date + "</td>" +
                            "<td>" + app.time + "</td>" +
                            "<td><span class='status-badge status-" + app.status + "'>" + app.status + "</span></td>" +
                            "<td><button class='cancel' data-id='" + app.appointmentId + "' " + disabled + ">" + btnText + "</button></td>" +
                        "</tr>"
                    );
                });
            },
            error: function(xhr) {
                console.error("Error fetching appointments:", xhr.responseText);
                $("#myAppointments tbody").append("<tr><td colspan='6'>Error loading appointments</td></tr>");
            }
        });
    }

    $(document).on("click", ".cancel", function() {
        let id = $(this).data("id");
        $.ajax({
            url: "/SOHAS/appointment/" + id,
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify({status: "CANCELLED"}),
            success: function() {
                alert("Appointment cancelled successfully");
                loadAppointments();
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
