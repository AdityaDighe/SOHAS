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
    <h2>Patient Signup</h2>



  <form autocomplete="off">

        <label>Full Name</label>
        <input type="text" name="patientName" id="name" required />

        <label>Age</label>
        <input type="number" name="age" id="age" required min=0 />

        <label>City</label>
        <input type="text" name="city" id="city" required />

        <label>Email</label>
        <input type="email" name="email" id="email" required />

        <label>Password</label>
        <input type="password" name="password" id="password" required />

        <div class="row">
            <button class="btn" type="submit" id="patientSignUp">Sign Up</button>
        </div>
    </form>
</div>

<script>
$("#patientSignUp").click(function(event) {
	event.preventDefault();
	
    $.ajax({
        url: "/SOHAS/patients",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	patientName: $("#name").val(),
            age: parseInt($("#age").val()),
            city: $("#city").val(),
            email: $("#email").val(),
            password: $("#password").val()
        }),
        success: function() {
            alert("Patient added!");
        }
    });
});
</script>
</body>
</html>
