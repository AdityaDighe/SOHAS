<%@ page contentType="text/html;charset=UTF-8" language="java"%>

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

h2 {
	margin-bottom: 20px;
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
}

th, td {
	padding: 12px;
	border: 1px solid #ddd;
	text-align: center;
}

th {
	background: #f8f9fa;
}

.btn {
	background: #28a745;
	color: #fff;
	border: none;
	padding: 8px 14px;
	border-radius: 6px;
	cursor: pointer;
}

.btn:hover {
	background: #218838;
}

input, select {
	padding: 6px;
	border-radius: 4px;
	border: 1px solid #ccc;
}

.form-section {
	text-align: center;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<div class="wrap">
		<h2>Book Appointment</h2>

		<!-- Step 1: Select Date and Time -->
		<div class="form-section">
			<form action="${pageContext.request.contextPath}/appointments/search"
				method="get">
				<label>Select Date:</label> <input type="date"
					name="appointmentDate" value="${selectedDate}" required
					min="${minDate}" /> <label>Select Time:</label> <select
					name="appointmentTime" required>
					<option value="">-- Select Time --</option>
					<c:forEach var="slot" items="${availableSlots}">
						<option value="${slot}" ${slot == selectedTime ? 'selected' : ''}>${slot}</option>
					</c:forEach>
				</select> <label>Select City:</label> <select name="city" required>
					<option value="">-- Select City --</option>
					<c:forEach var="cityOption" items="${cities}">
						<option value="${cityOption}"
							${cityOption == selectedCity ? 'selected' : ''}>${cityOption}</option>
					</c:forEach>
				</select>




				<button type="submit" class="btn">Find Doctors</button>
			</form>
		</div>

		<!-- Step 2: Show Available Doctors Only AFTER Search -->
		<c:if test="${not empty selectedDate && not empty selectedTime}">
			<c:if test="${not empty doctors}">
				<h3>Available Doctors</h3>
				<table>
					<tr>
						<th>Doctor Name</th>
						<th>Hospital Name</th>
						<th>Speciality</th>
						<th>City</th>
						<th>Action</th>
					</tr>
					<c:forEach var="doc" items="${doctors}">
						<tr>
							<form
								action="${pageContext.request.contextPath}/appointments/book"
								method="post">
								<td>Dr. ${doc.doctorName}</td>
								<td>${doc.hospitalName}</td>
								<td>${doc.speciality}</td>
								<td>${doc.city}</td>

								<!-- Hidden Inputs for Booking -->
								<input type="hidden" name="doctorId" value="${doc.doctorId}" />
								<input type="hidden" name="appointmentDate"
									value="${selectedDate}" /> <input type="hidden"
									name="appointmentTime" value="${selectedTime}" />

								<td><button type="submit" class="btn">Book</button></td>
							</form>
						</tr>
					</c:forEach>
				</table>
			</c:if>

			<c:if test="${empty doctors}">
				<p>No doctors available for the selected time.</p>
			</c:if>
		</c:if>
	</div>
</body>
</html>
