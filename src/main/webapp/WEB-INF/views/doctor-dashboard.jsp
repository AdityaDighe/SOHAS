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
        button.btn-status { padding:5px 10px; border:none; border-radius:5px; cursor:pointer; }
        button.cancel { background:#f44336; color:white; }
        button.complete { background:#4CAF50; color:white; }
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
            <th>Actions</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    const baseUrl = "${pageContext.request.contextPath}";

    $(document).ready(function(){
        loadAppointments();

        function loadAppointments() {
            $.ajax({
                url: baseUrl + "/appointment",
                method: "GET",
                success: function(appointments) {
                    let tbody = $("#appointmentTable tbody");
                    tbody.empty();
                    appointments.forEach(function(app) {
                    	tbody.append(
                                "<tr>" +
                                    "<td>"+app.patient.patientName+"</td>" +
                                    "<td>"+app.date+"</td>" +
                                    "<td>"+app.time+"</td>" +
                                    "<td>"+app.status+"</td>" +
                                    "<td>" +
                                    "<button class='status-finish btn-status complete' data-id='" + app.appointmentId + "'>Complete</button>" +
                                    " " +
                                    "<button class='status-cancel btn-status cancel' data-id='" + app.appointmentId + "'>Cancel</button>" +
                                    "</td>" +
                                "</tr>"
                         );
                    });
                },
                error: function() {
                    alert("Failed to load appointments.");
                }
            });
        }

        
        $(document).on("click", ".complete", function() {
            let id = $(this).data("id");
            console.log(id);
            $.ajax({
                url: baseUrl + "/appointment/"+id,
                method: "PUT",
                contentType : "application/json",
                data : JSON.stringify({status : "COMPLETED"}),
                success: function() {
                    alert("Appointment completed successfully");
                    loadAppointments(); // reload updated list
                },
                error: function(xhr) {
                    alert("Error: " + xhr.responseText);
                    console.log(xhr);
                }
            });
        });

        $(document).on("click", ".cancel", function() {
            let id = $(this).data("id");
            $.ajax({
                url: baseUrl + "/appointment/"+id,
                method: "PUT",
                contentType : "application/json",
                data : JSON.stringify({status : "CANCELLED"}),
                success: function() {
                    alert("Appointment cancelled successfully");
                    loadAppointments(); // reload updated list
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

