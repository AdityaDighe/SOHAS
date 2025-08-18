
<html>
<head>
    <title>SOHAS • Doctor Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460);
            color: #fff;
        }

        /* HEADER */
        .header {
            width: 100%;
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(12px);
            box-shadow: 0 4px 25px rgba(0,0,0,0.3);
            padding: 15px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .header .brand { font-size: 22px; font-weight: bold; }
        .header .brand span { color: #3399ff; }

        .header .nav a {
            padding: 8px 14px;
            border-radius: 20px;
            background: linear-gradient(135deg, #3a7bd5, #00d2ff);
            color: #fff; text-decoration: none; font-size: 14px; font-weight: 500;
            margin-left: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.3);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .header .nav a:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.8);
        }

        /* MAIN CONTAINER */
        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 20px;
            background: rgba(255,255,255,0.08);
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

        /* TABLE */
        table { width: 100%; border-collapse: collapse; }
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

        /* STATUS */
        .status {
        padding: 6px 14px;
        border-radius: 20px;
        font-size: 13px;
        font-weight: bold;
        display: inline-block;
	    }
	    .status.cancelled {
	        background: linear-gradient(135deg, #ff0844, #ff416c);
	        color: #fff;
	        box-shadow: 0 0 10px rgba(255,65,108,0.8);
	    }
	    .status.completed {
	        background: linear-gradient(135deg, #56ab2f, #a8e063);
	        color: #000;
	        box-shadow: 0 0 10px rgba(86,171,47,0.8);
	    }
	    .status.booked {
	        background: linear-gradient(135deg, #f7971e, #ffd200);
	        color: #000;
	        box-shadow: 0 0 10px rgba(255,220,50,0.9);
	    }
        /* BUTTONS */
        .btn-status {
            padding: 6px 14px; border: none; border-radius: 20px;
            font-size: 13px; cursor: pointer; margin: 0 5px;
            transition: transform 0.2s, box-shadow 0.2s; min-width: 90px;
        }
        .btn-status.complete {
            background: linear-gradient(135deg, #56ab2f, #a8e063);
            color: #000; box-shadow: 0 0 12px rgba(86,171,47,0.8);
        }
        .btn-status.cancel {
            background: linear-gradient(135deg, #ff0844, #ff416c);
            color: #fff; box-shadow: 0 0 12px rgba(255,65,108,0.8);
        }
        .btn-status.disabled {
            background: linear-gradient(135deg, #555, #888);
            color: #ddd !important;
            box-shadow: 0 0 12px rgba(180,180,180,0.8);
            cursor: not-allowed;
        }
        .btn-status:hover:not(.disabled) {
            transform: scale(1.1);
            box-shadow: 0 0 18px rgba(255,255,255,0.9);
        }

        td.actions { display: flex; justify-content: center; gap: 12px; }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container">
    <h2>My Appointments</h2>

    <div id="noAppointmentsMessage" style="display:none; text-align:center; padding:15px; font-size:16px;">
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
                        let isFinished = (app.status === "CANCELLED" || app.status === "COMPLETED");

                        let completeBtn = "<button class='btn-status complete " + (isFinished ? "disabled' disabled" : "'") +
                            " data-id='" + app.appointmentId + "'>Complete</button>";

                        let cancelBtn = "<button class='btn-status cancel " + (isFinished ? "disabled' disabled" : "'") +
                            " data-id='" + app.appointmentId + "'>Cancel</button>";

                        tbody.append(
                            "<tr>" +
                            "<td>" + app.patient.patientName + "</td>" +
                            "<td>" + app.date + "</td>" +
                            "<td>" + app.time + "</td>" +
                            "<td><span class='status " + app.status.toLowerCase() + "'>" + app.status + "</span></td>" +
                            "<td class='actions'>" + completeBtn + cancelBtn + "</td>" +
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

        $(document).on("click", ".btn-status.complete:not(.disabled)", function () {
            let id = $(this).data("id");
            $.ajax({
                url: baseUrl + "/appointment/" + id,
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({status: "COMPLETED"}),
                success: function () {
                    alert("Appointment completed successfully");
                    loadAppointments();
                },
                error: function (xhr) {
                    alert("Error: " + xhr.responseText);
                }
            });
        });

        $(document).on("click", ".btn-status.cancel:not(.disabled)", function () {
            let id = $(this).data("id");
            $.ajax({
                url: baseUrl + "/appointment/" + id,
                method: "PUT",
                contentType: "application/json",
                data: JSON.stringify({status: "CANCELLED"}),
                success: function () {
                    alert("Appointment cancelled successfully");
                    loadAppointments();
                },
                error: function (xhr) {
                    alert("Error: " + xhr.responseText);
                }
            });
        });
    });
</script>
</body>
</html>
