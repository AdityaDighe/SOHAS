<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS • Doctor Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f7fb; margin:0; }
        .wrap { max-width:800px; margin:40px auto; background:#fff; padding:20px; border-radius:10px; box-shadow:0 10px 25px rgba(0,0,0,.08); }
        table { width:100%; border-collapse:collapse; margin-top:20px; }
        th, td { border:1px solid #ddd; padding:10px; text-align:left; }
        th { background:#f0f0f0; }

        /* Dropdown Styling */
        select.status-dropdown {
            padding:6px 10px;
            border-radius:6px;
            border:1px solid #ccc;
            background:#fff;
            font-size:14px;
            cursor:pointer;
            transition:all 0.2s ease;
        }
        select.status-dropdown:hover {
            border-color:#0d6efd;
            box-shadow:0 0 5px rgba(13,110,253,0.3);
        }
    </style>
</head>
<body>
<div class="wrap">
    <h2>My Appointments</h2>
    <table id="appointmentTable">
        <thead>
            <tr>
                <th>Patient Name</th>
                <th>Date</th>
                <th>Time Slot</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    $.ajax({
        url: "/SOHAS/doctorDashboard", // Fetch appointments
        method: "GET",
        success: function(appointments){
            let tbody = $("#appointmentTable tbody");
            tbody.empty();
            appointments.forEach(function(app){
                tbody.append(
                    "<tr>" +
                        "<td>"+app.patientName+"</td>" +
                        "<td>"+app.date+"</td>" +
                        "<td>"+app.timeSlot+"</td>" +
                        "<td>" +
                            "<select class='status-dropdown' data-id='"+app.id+"'>" +
                                "<option value='BOOKED' "+(app.status==='BOOKED'?'selected':'')+">Booked</option>" +
                                "<option value='COMPLETED' "+(app.status==='COMPLETED'?'selected':'')+">Completed</option>" +
                                "<option value='CANCELLED' "+(app.status==='CANCELLED'?'selected':'')+">Cancelled</option>" +
                            "</select>" +
                        "</td>" +
                    "</tr>"
                );
            });
        }
    });

    // For now: alert when status changes (backend hookup later)
    $(document).on("change", ".status-dropdown", function(){
        let appointmentId = $(this).data("id");
        let newStatus = $(this).val();
        alert("Appointment ID: " + appointmentId + " → New Status: " + newStatus);
    });
});
</script>
</body>
</html>
