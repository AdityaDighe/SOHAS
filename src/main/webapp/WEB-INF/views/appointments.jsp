<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>SOHAS • Book Appointment</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f7fb; margin:0; }
        .wrap { max-width:500px; margin:60px auto; background:#fff; padding:28px; border-radius:10px; box-shadow:0 10px 25px rgba(0,0,0,.08); }
        h2 { margin:0 0 18px; text-align:center; }
        label { display:block; margin:12px 0 6px; font-size:14px; color:#333; }
        select, input { width:100%; padding:10px 12px; border:1px solid #ddd; border-radius:6px; font-size:14px; }
        .btn { background:#28a745; color:#fff; border:0; padding:10px 16px; border-radius:6px; cursor:pointer; width:100%; margin-top:18px; }
        .btn:hover { background:#218838; }
        .alert { background:#ffe5e5; color:#b00020; padding:10px 12px; border-radius:6px; margin-bottom:12px; border:1px solid #ffcaca; }
    </style>
</head>
<body>
<div class="wrap">
    <h2>Book Appointment</h2>

   

    <form action="${pageContext.request.contextPath}/appointments/book" method="post" autocomplete="off">

        <!-- Select Doctor -->
        <label>Selected Doctor</label>
       

        <!-- Select Date -->
        <label>Appointment Date</label>
        <input type="date" name="appointmentDate" required min="${minDate}" />

        <!-- Select Time -->
        <label>Available Time Slots</label>
        <select name="appointmentTime" required>
            <option value="">-- Select Time --</option>
            <c:forEach var="slot" items="${availableSlots}">
                <option value="${slot}">${slot}</option>
            </c:forEach>
        </select>

        <!-- Submit -->
        <button class="btn" type="submit">Book Appointment</button>
    </form>
</div>
</body>
</html>
