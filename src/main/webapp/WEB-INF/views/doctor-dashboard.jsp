<html>
<head>
    <title>SOHAS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

    <style>
body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
	color: #fff;
}

/* MAIN CONTAINER */
.container {
	max-width: 1000px;
	margin: 50px auto;
	padding: 30px;
	border-radius: 20px;
	background: rgba(255, 255, 255, 0.15);
	backdrop-filter: blur(14px);
	box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
}

h2 {
	text-align: center;
	font-size: 28px;
	margin-bottom: 25px;
	letter-spacing: 1px;
	text-shadow: 0 0 8px rgba(0, 210, 255, 0.7);
}

/* TABLE */
table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 14px 18px;
	text-align: center;
}

th {
	font-size: 15px;
	font-weight: bold;
	letter-spacing: 1px;
	color: #fff;
	text-shadow: 0 0 8px rgba(0, 210, 255, 0.8);
	border-bottom: 2px solid rgba(255, 255, 255, 0.2);
}

tr {
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
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
	box-shadow: 0 0 10px rgba(255, 65, 108, 0.8);
}

.status.completed {
	background: linear-gradient(135deg, #56ab2f, #a8e063);
	color: #000;
	box-shadow: 0 0 10px rgba(86, 171, 47, 0.8);
}

.status.booked {
	background: linear-gradient(135deg, #f7971e, #ffd200);
	color: #000;
	box-shadow: 0 0 10px rgba(255, 220, 50, 0.9);
}
/* BUTTONS */
.btn-status {
	padding: 6px 14px;
	border: none;
	border-radius: 20px;
	font-size: 13px;
	cursor: pointer;
	margin: 0 5px;
	transition: transform 0.2s, box-shadow 0.2s;
	min-width: 90px;
}

.btn-status.complete {
	background: linear-gradient(135deg, #56ab2f, #a8e063);
	color: #000;
	box-shadow: 0 0 12px rgba(86, 171, 47, 0.8);
}

.btn-status.cancel {
	background: linear-gradient(135deg, #ff0844, #ff416c);
	color: #fff;
	box-shadow: 0 0 12px rgba(255, 65, 108, 0.8);
}

.btn-status.disabled {
	background: linear-gradient(135deg, #555, #888);
	color: #ddd !important;
	box-shadow: 0 0 12px rgba(180, 180, 180, 0.8);
	cursor: not-allowed;
}

.btn-status:hover:not(.disabled) {
	transform: scale(1.1);
	box-shadow: 0 0 18px rgba(255, 255, 255, 0.9);
}

td.actions {
	display: flex;
	justify-content: center;
	gap: 12px;
}

.navbar  a {
	text-decoration: none !important;
	color: inherit;
}

.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	display: flex;
	justify-content: center;
	align-items: flex-start; /* Pushes modal to top */
	padding-top: 40px; /* Space from top */
	z-index: 9998;
}

/* Modal Box */
.modal {
	background: rgba(255, 255, 255, 0.15);
	backdrop-filter: blur(12px);
	border-radius: 12px;
	padding: 20px 25px;
	width: 350px;
	text-align: center;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
	color: #fff;
	animation: slideDown 0.3s ease;
}

.modal-buttons {
	margin-top: 15px;
	display: flex;
	justify-content: space-around;
}

.modal-btn {
	padding: 8px 16px;
	border: none;
	border-radius: 8px;
	cursor: pointer;
	font-weight: bold;
	transition: 0.2s;
}

#confirmYes {
	background: linear-gradient(135deg, #56ab2f, #a8e063);
	color: #000;
}

#confirmNo {
	background: linear-gradient(135deg, #ff0844, #ff416c);
	color: #fff;
}

.modal-btn:hover {
	transform: scale(1.05);
}

/* Slide animation */
@
keyframes slideDown {from { transform:translateY(-30px);
	opacity: 0;
}

to {
	transform: translateY(0);
	opacity: 1;
}

}

/* Toast Notification */
#toast {
	display: none;
	position: fixed;
	bottom: 30px;
	left: 50%;
	transform: translateX(-50%); /* Center horizontally */
	padding: 12px 20px;
	background: #ffc107;
	color: #000;
	font-weight: bold;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
	z-index: 9999;
	text-align: center;
}

.status-form {
	margin-bottom: 25px;
	text-align: center;
}

.status-form label {
	font-weight: bold;
	margin-right: 10px;
}

.status-form select {
	padding: 8px 12px;
	border-radius: 6px;
	border: none;
	font-size: 14px;
	outline: none;
	background: #fff;
	color: #000;
}
</style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="container">
    <h2>My Appointments</h2>
    
    <div class="status-form">
            <label for="status">Select Status:</label>
            <select id="status" name="status" required>
                <option value="">-- Select Status --</option>
                <option value="BOOKED">BOOKED</option>
                <option value="COMPLETED">COMPLETED</option>
                <option value="CANCELLED">CANCELLED</option>
            </select>
    </div>

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
 	
    function getCookie(name) {
        let match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
        return match ? match[2] : null;
    }
	
	let tokenFromCookie1 = getCookie("jwtToken");
    $(document).ready(function () {
    	let appointmentToUpdate = null;
        let actionToPerform = null;
        
        loadAppointments();
     
        function loadAppointments() {
            let id = "${id}";
            $.ajax({
                url: baseUrl + "/doctors/appointment/" + id,
                method: "GET",
                headers: {
                    "Authorization": "Bearer " + tokenFromCookie
                },
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
						
                        let disabled = "";
                        let cancelBtnText = "Cancel";
 
                        let dateObj = new Date(app.date);
                        dateObj.setDate(dateObj.getDate() + 1); // timezone adjustment
 
                        let fixedDate = dateObj.getFullYear() + "-" +
                            String(dateObj.getMonth() + 1).padStart(2, "0") + "-" +
                            String(dateObj.getDate()).padStart(2, "0");
 
                        let appointmentDateTime = new Date(fixedDate + "T" + app.time);
                        let now = new Date();
                        
                        // Check if the appointment has expired or is already cancelled
                        if (appointmentDateTime < now && app.status !== "CANCELLED") {
                            disabled = "disabled";
                            cancelBtnText = "Expired";
                        }
                        
                        if (app.status === "CANCELLED") {
                            disabled = "disabled";
                            cancelBtnText = "Cancelled";
                        }
 
                        let completeBtn = "<button class='btn-status complete " + (isFinished ? "disabled' disabled" : "'") +
                            " data-id='" + app.appointmentId + "'>Complete</button>";
 
                        let cancelBtn = "<button class='btn-status cancel " + (isFinished ? "disabled' disabled" : "'") +
                            " data-id='" + app.appointmentId + "'>Cancel</button>";
 
                        tbody.append(
                            "<tr>" +
                            "<td>" + app.patientName + "</td>" +
                            "<td>" + fixedDate + "</td>" +
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
                	showToast("Failed to load appointments", "error");
                    //alert("Failed to load appointments.");
                }
            });
        }
        
     // Toast Function
        function showToast(message, type = "info") {
            const toast = $("#toast");
            toast.text(message);
            toast.css({
                backgroundColor: type === "error" ? "#dc3545" :
                                 type === "success" ? "#28a745" :
                                 "#ffc107",
                color: "#fff"
            });
            toast.fadeIn(200).delay(3000).fadeOut(400);
        }
 
        // Confirmation Modal Logic
        function showConfirmation(message, callback) {
            $(".modal-message").text(message);
            $("#confirmModal").fadeIn(200);
 
            $("#confirmYes").off("click").on("click", function () {
                $("#confirmModal").fadeOut(200);
                callback(true);
            });
 
            $("#confirmNo").off("click").on("click", function () {
                $("#confirmModal").fadeOut(200);
                callback(false);
            });
        }
 
 // the logic for complete button, allowing complete only after the time slot
        $(document).on("click", ".btn-status.complete:not(.disabled)", function () {
            let id = $(this).data("id");
            let row = $(this).closest("tr");

            let dateStr = row.find("td:eq(1)").text(); // yyyy-MM-dd
            let timeStr = row.find("td:eq(2)").text(); // HH:mm:ss
            let appointmentDateTime = new Date(dateStr + "T" + timeStr);
            let now = new Date();

            if (now >= appointmentDateTime) {
                
                showConfirmation("Mark this appointment as completed?", function (confirmed) {
                    if (confirmed) {
                        $.ajax({
                            url: baseUrl + "/appointment/" + id,
                            method: "PUT",
                            contentType: "application/json",
                            data: JSON.stringify({ status: "COMPLETED" }),
                            headers: {
                                "Authorization": "Bearer " + tokenFromCookie
                            },
                            success: function () {
                                showToast("Appointment marked as completed", "success");
                                loadAppointments();
                            },
                            error: function (xhr) {
                                showToast("Error: " + xhr.responseText, "error");
                            }
                        });
                    }
                });
            } else {
                // ❌ Before timeslot → show popup
                showErrorPopup("Cant complete before timeslot");
            }
        });
 
 
        function showErrorPopup(message) {
            $(".modal-message").text(message);
            $("#confirmYes").hide();   // hide Yes button
            $("#confirmNo").text("OK"); // rename No OK
            $("#confirmModal").fadeIn(200);

            $("#confirmNo").off("click").on("click", function () {
                $("#confirmModal").fadeOut(200);
                // Reset modal back for next use
                $("#confirmYes").show();
                $("#confirmNo").text("No");
            });
        }

 
        $(document).on("click", ".btn-status.cancel:not(.disabled)", function () {
            let id = $(this).data("id");
            
            let row = $(this).closest("tr");
 
            let dateStr = row.find("td:eq(1)").text(); // yyyy-MM-dd
            let timeStr = row.find("td:eq(2)").text(); // HH:mm:ss
            let appointmentDateTime = new Date(dateStr + "T" + timeStr);
            let now = new Date();
 
            let diffInMs = appointmentDateTime - now;
            let diffInHours = diffInMs / (1000 * 60 * 60);
            
            if (diffInHours >= 2) {
                showConfirmation("Are you sure you want to cancel this appointment?", function (confirmed) {
                    if (confirmed) {
			            $.ajax({
			                url: baseUrl + "/appointment/" + id,
			                method: "PUT",
			                contentType: "application/json",
			                data: JSON.stringify({status: "CANCELLED"}),
			                headers: {
			                    "Authorization": "Bearer " + tokenFromCookie
			                },
			                success: function () {
			                	showToast("Appointment cancelled successfully", "success");
			                	//alert("Appointment cancelled successfully");
			                    loadAppointments();
			                },
			                error: function (xhr) {
			                	showToast("Error: " + xhr.responseText, "error");
			                	//alert("Error: " + xhr.responseText);
			                }
			            });
                    }
        		});
            } else {
                showToast("Cannot cancel less than 2 hours before appointment.", "error");
            }
        });
        
        function filterAppointments(status) {
            $("#appointmentTable tbody tr").each(function () {
                  const rowStatus = $(this).find(".status").text();
                if (status === "" || status === rowStatus) {
                      $(this).show();
                  } else {
                      $(this).hide();
                  }
              });
          }
   
          $("#status").on("change", function () {
              const selectedStatus = $(this).val();
              filterAppointments(selectedStatus);
          });
    });
</script>
 
<!-- Confirmation Modal -->
<div id="confirmModal" class="modal-overlay" style="display: none;">
    <div class="modal">
        <p class="modal-message">Are you sure?</p>
        <div class="modal-buttons">
            <button id="confirmYes" class="modal-btn">Yes</button>
            <button id="confirmNo" class="modal-btn">No</button>
        </div>
    </div>
</div>
 
<!-- Toast Notification -->
<div id="toast" style="display:none; position:fixed; bottom:30px; right:30px; padding:12px 20px; background:#ffc107; color:#000; font-weight:bold; border-radius:8px; box-shadow:0 2px 8px rgba(0,0,0,0.3); z-index:9999;"></div>
</body>
</html>
