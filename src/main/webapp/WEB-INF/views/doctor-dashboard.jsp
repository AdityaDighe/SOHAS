<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS • Doctor Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(180deg, #e6f0ff 0%, #ffffff 100%);
            margin: 0;
        }
        
        h2 {
            margin-bottom: 20px;
            text-align: center;
        }

        .main-content {
            max-width: 800px;
            margin: 40px auto;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #f0f0f0;
        }

        button.btn-status {
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        button.cancel {
            background: #f44336;
            color: white;
        }

        button.complete {
            background: #4CAF50;
            color: white;
        }

        .btn-group {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        button:hover {
            transform: scale(1.20);
            transition: transform 0.2s ease;
        }

        button:disabled {
            display: none;
        }

        button.cancel, button.complete {
            border-radius: 20px;
        }

        .status-badge {
            padding: 4px 10px;
            border-radius: 4px;
            font-size: 0.85em;
            font-weight: bold;
            display: inline-block;
            text-transform: uppercase;
        }

        .status-BOOKED {
            background-color: #ffc107;
            color: #212529;
        }

        .status-COMPLETED {
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

<div class="main-content">
    <h2>My Appointments</h2>
    
    <div id="noAppointmentsMessage" style="display:none; text-align:center; margin-top: 30px; font-size: 18px; color: #555;">
    	You have no appointments yet.
	</div>
    <table id="appointmentTable" style="display:none;">
        <thead>
        <tr>
            <th>Patient Name</th>
            <th>Date</th>
            <th>Time Slot</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    const baseUrl = "${pageContext.request.contextPath}";

    $(document).ready(function () {
        loadAppointments();

        function loadAppointments() {
            let id = "${id}";
            $.ajax({
                url: baseUrl + "/doctors/appointment/" + id,
                method: "GET",
                success: function (appointments) {
                    let tbody = $("#appointmentTable tbody");
                    tbody.empty();
                    
                    if (appointments.length === 0) {
                        $("#appointmentTable").hide();
                        $("#noAppointmentsMessage").show();
                        return;
                    }
                    
                    appointments.forEach(function (app) {
                        let disabled = ((app.status === "CANCELLED") || (app.status === "COMPLETED")) ? "disabled" : "";
                        let btnText = app.status === "CANCELLED" ? "Cancelled" : "Cancel";
                        tbody.append(
                            "<tr>" +
                            "<td>" + app.patient.patientName + "</td>" +
                            "<td>" + app.date + "</td>" +
                            "<td>" + app.time + "</td>" +
                            "<td><span class='status-badge status-" + app.status + "'>" + app.status + "</span></td>" +
                            "<td>" +
                            "<div class='btn-group'>" +
                            "<button class='status-finish btn-status complete' data-id='" + app.appointmentId + "' " + disabled + ">Complete</button>" +
                            " " +
                            "<button class='status-cancel btn-status cancel' data-id='" + app.appointmentId + "' " + disabled + ">" + btnText + "</button>" +
                            "</div>" +
                            "</td>" +
                            "</tr>"
                        );
                    });
                    $("#noAppointmentsMessage").hide();
                    $("#appointmentTable").show();
                },
                error: function () {
                    alert("Failed to load appointments.");
                }
            });
        }

        $(document).on("click", ".complete", function () {
            let id = $(this).data("id");
            $.ajax({
                url: baseUrl + "/appointment/" + id,
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({status: "COMPLETED"}),
                success: function () {
                    alert("Appointment completed successfully");
                    loadAppointments(); // reload updated list
                },
                error: function (xhr) {
                    alert("Error: " + xhr.responseText);
                    console.log(xhr);
                }
            });
        });

        $(document).on("click", ".cancel", function () {
            let id = $(this).data("id");
            $.ajax({
                url: baseUrl + "/appointment/" + id,
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({status: "CANCELLED"}),
                success: function () {
                    alert("Appointment cancelled successfully");
                    loadAppointments(); // reload updated list
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
