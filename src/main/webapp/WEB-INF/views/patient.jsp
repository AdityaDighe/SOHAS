<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>SOHAS • Patient Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f7fb; margin:0; }
        .wrap { max-width:800px; margin:40px auto; background:#fff; padding:28px; border-radius:10px; box-shadow:0 10px 25px rgba(0,0,0,.08); }
        h2 { margin-bottom:20px; text-align:center; }
        label { font-weight: bold; }
        select, button { padding:10px; margin-top:10px; border-radius:6px; border:1px solid #ddd; }
        .btn { background:#28a745; color:#fff; border:none; cursor:pointer; }
        .btn:hover { background:#218838; }
        .cancel { background:#dc3545; color:#fff; border:none; padding:6px 10px; cursor:pointer; border-radius:4px; }
        .cancel:hover { background:#b52a37; }
        table { width:100%; border-collapse: collapse; margin-top:20px; }
        th, td { padding:10px; border:1px solid #ddd; text-align:center; }
        th { background:#f8f9fa; }
    </style>
</head>
<body>
<div class="wrap">
    <h2>Welcome, ${patient.patientName}!</h2>

    <!-- Book Appointment Section -->
    <form action="${pageContext.request.contextPath}/appointments/book" method="get">
        <label for="doctor">Select Doctor:</label>
        <select name="doctorId" id="doctor" required>
            <option value="">-- Select Doctor --</option>
            <c:forEach var="doctor" items="${doctors}">
                <option value="${doctor.doctorId}">
                    Dr. ${doctor.doctorName} - ${doctor.speciality} (${doctor.hospitalName})
                </option>
            </c:forEach>
        </select>
        <button type="submit" class="btn">Book Now</button>
    </form>

    <!-- Booked Appointments Section -->
    <h3>Your Appointments</h3>
    <c:if test="${empty appointments}">
        <p>No appointments booked yet.</p>
    </c:if>
    <c:if test="${not empty appointments}">
        <table>
            <tr>
                <th>Doctor</th>
                <th>Speciality</th>
                <th>Date</th>
                <th>Time</th>
                <th>Action</th>
            </tr>
            <c:forEach var="appt" items="${appointments}">
                <tr>
                    <td>Dr. ${appt.doctorName}</td>
                    <td>${appt.speciality}</td>
                    <td>${appt.date}</td>
                    <td>${appt.time}</td>
                    <td>
                        <form action="${pageContext.request.contextPath}/appointments/cancel" method="post" style="margin:0;">
                            <input type="hidden" name="appointmentId" value="${appt.appointmentId}" />
                            <button type="submit" class="cancel">Cancel</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
</div>
</body>
</html>
