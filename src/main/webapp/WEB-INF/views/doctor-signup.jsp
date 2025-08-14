<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>SOHAS • Doctor Login</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f7fb; margin:0; }
        .wrap { max-width:420px; margin:60px auto; background:#fff; padding:28px; border-radius:10px; box-shadow:0 10px 25px rgba(0,0,0,.08); }
        h2 { margin:0 0 18px; text-align:center; }
        label { display:block; margin:12px 0 6px; font-size:14px; color:#333; }
        input { width:100%; padding:10px 12px; border:1px solid #ddd; border-radius:6px; font-size:14px; }
        .row { display:flex; justify-content:center; align-items:center; margin-top:16px; }
        .btn { background:#0d6efd; color:#fff; border:0; padding:10px 16px; border-radius:6px; cursor:pointer; }
        .btn:hover { background:#0b5ed7; }
        .link { font-size:14px; color:#0d6efd; text-decoration:none; }
        .link:hover { text-decoration:underline; }
        .alert { background:#ffe5e5; color:#b00020; padding:10px 12px; border-radius:6px; margin-bottom:12px; border:1px solid #ffcaca; }
        .muted { color:#666; font-size:13px; text-align:center; margin-top:12px; }
    </style>
</head>
<body>
<div class="wrap">
    <h2>Doctor signup</h2>



  <form autocomplete="off">

        <label>Full Name</label>
        <input type="text" name="doctorName" id="name" required />

        <label>Speciality</label>
        <input type="text" name="speciality" id="speciality" required />

        <label>Phone Number</label>
        <input type="text" name="phoneNumber" id="number" required />

        <label>City</label>
        <input type="text" name="city" id="city" required />

        <label>Hospital Name</label>
        <input type="text" name="hospitalName" id="hospital" required />
        
        <label>Start Time</label>
		<input type="time" name="startTime" id="startTime" required />

		<label>End Time</label>
		<input type="time" name="endTime" id="endTime" required />

        <label>Email</label>
        <input type="email" name="email" id="email" required />

        <label>Password</label>
        <input type="password" name="password" id="password" required />

        <!-- If you enable Spring Security CSRF -->
        <c:if test="${not empty _csrf}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </c:if>

        <div class="row">
            <button class="btn" type="submit" id="doctorSignUp">Sign Up</button>
        </div>
    </form>
       

  
    </form>
</div>

<script>
$("#doctorSignUp").click(function(event) {
	event.preventDefault();
	
    $.ajax({
        url: "/SOHAS/doctors",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	doctorName: $("#name").val(),
            speciality: $("#speciality").val(),
            phoneNumber: $("#number").val(),
            city: $("#city").val(),
            hospitalName: $("#hospital").val(),
            email: $("#email").val(),
            password: $("#password").val(),
            startTime: $("#startTime").val()+":00",
            endTime: $("#endTime").val()+":00"
        }),
        success: function() {
            alert("Doctor added!");
        }
    });
});
</script>
</body>
</html>
