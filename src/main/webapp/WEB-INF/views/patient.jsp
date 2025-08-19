<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS • Patient Dashboard</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #fff;
        }

        /* MAIN CONTAINER */
        .wrap {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(14px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.4);
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 25px;
            letter-spacing: 1px;
            text-shadow: 0 0 8px rgba(0,210,255,0.7);
        }

        .header-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .welcome-text {
            font-size: 1.2rem;
            font-weight: 600;
            text-shadow: 0 0 6px rgba(255,255,255,0.4);
        }

        /* BOOK BUTTON */
        .book-btn {
            background: linear-gradient(135deg, #007bff, #00d4ff);
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            transition: 0.2s ease;
            box-shadow: 0 0 12px rgba(0,212,255,0.6);
        }
        .book-btn:hover {
            transform: scale(1.08);
            box-shadow: 0 0 20px rgba(0,212,255,0.9);
        }

        /* TABLE */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 14px 18px; text-align: center; }
        th {
            font-size: 15px; font-weight: bold; letter-spacing: 1px; color: #fff;
            text-shadow: 0 0 8px rgba(0,210,255,0.8);
            border-bottom: 2px solid rgba(255,255,255,0.2);
        }
        tr {
            border-bottom: 1px solid rgba(255,255,255,0.1);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        tr:hover {
            transform: scale(1.02);
            box-shadow: 0 0 18px rgba(0, 210, 255, 0.5);
        }

        /* STATUS BADGES */
        .status-badge {
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
            display: inline-block;
        }
        .status-BOOKED {
            background: linear-gradient(135deg, #f7971e, #ffd200);
            color: #000;
            box-shadow: 0 0 10px rgba(255,220,50,0.9);
        }
        .status-COMPLETED {
            background: linear-gradient(135deg, #56ab2f, #a8e063);
            color: #000;
            box-shadow: 0 0 10px rgba(86,171,47,0.8);
        }
        .status-CANCELLED {
            background: linear-gradient(135deg, #ff0844, #ff416c);
            color: #fff;
            box-shadow: 0 0 10px rgba(255,65,108,0.8);
        }

        /* CANCEL BUTTON */
        .cancel {
            padding: 6px 14px; border: none; border-radius: 20px;
            font-size: 13px; cursor: pointer; margin: 0 5px;
            transition: transform 0.2s, box-shadow 0.2s; min-width: 90px;
            background: linear-gradient(135deg, #ff0844, #ff416c);
            color: #fff;
            box-shadow: 0 0 12px rgba(255,65,108,0.8);
        }
        .cancel:hover:not(:disabled) {
            transform: scale(1.1);
            box-shadow: 0 0 18px rgba(255,255,255,0.9);
        }
        .cancel:disabled {
            background: linear-gradient(135deg, #555, #888);
            color: #ddd;
            box-shadow: 0 0 12px rgba(180,180,180,0.8);
            cursor: not-allowed;
        }

        /* EMPTY MESSAGE */
        #noAppointmentsMessage {
            display:none;
            text-align:center;
            margin-top: 20px;
            font-size: 16px;
            color: #ddd;
        }

        /* NAVBAR FIX */
        .navbar a {
            text-decoration: none !important;
            color: inherit;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="wrap">
    <!-- Header -->
    <div class="header-row">
        <div class="welcome-text">Looking for a doctor? Book an appointment now</div>
        <a href="http://localhost:8080/SOHAS/patientDashboard/appointment" class="book-btn">Book</a>
    </div>

    <!-- Appointments -->
    <h2>Your Appointments</h2>

    <div id="noAppointmentsMessage">
        No appointments booked yet.
    </div>

    <table id="myAppointments" style="display:none;">
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
        <tbody></tbody>
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
                    $("#myAppointments").hide();
                    $("#noAppointmentsMessage").show();
                    return;
                }

                appointments.forEach(function(app) {
                    let dateObj = new Date(app.date);
                    dateObj.setDate(dateObj.getDate() + 1); // timezone fix
                    let fixedDate = dateObj.getFullYear() + "-" +
                        String(dateObj.getMonth() + 1).padStart(2, "0") + "-" +
                        String(dateObj.getDate()).padStart(2, "0");

                    let disabled = app.status === "CANCELLED" ? "disabled" : "";
                    let btnText = app.status === "CANCELLED" ? "Cancelled" : "Cancel";

                    tbody.append(
                        "<tr>" +
                            "<td>Dr. " + app.doctor.doctorName + "</td>" +
                            "<td>" + app.doctor.speciality + "</td>" +
                            "<td>" + fixedDate + "</td>" +
                            "<td>" + app.time + "</td>" +
                            "<td><span class='status-badge status-" + app.status + "'>" + app.status + "</span></td>" +
                            "<td><button class='cancel' data-id='" + app.appointmentId + "' " + disabled + ">" + btnText + "</button></td>" +
                        "</tr>"
                    );
                });

                $("#noAppointmentsMessage").hide();
                $("#myAppointments").show();
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
