<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <title>SOHAS • Patient </title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(180deg, #e6f0ff 0%, #ffffff 100%); margin:0; }
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
        .error {color: #b00020; font-size: 13px; margin-top: 4px;}
        
#successSticker {
	position: fixed;
	bottom: 30px;
	left: 50%;
	transform: translateX(-50%);
	background-color: #4BB543;
	color: white;
	padding: 12px 24px;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
	z-index: 9999;
	font-size: 15px;
	display: none;
	animation: fadeInOut 2s ease-in-out;
}

@keyframes fadeInOut {
	0% { opacity: 0; transform: translateX(-50%) translateY(20px); }
	10% { opacity: 1; transform: translateX(-50%) translateY(0); }
	90% { opacity: 1; transform: translateX(-50%) translateY(0); }
	100% { opacity: 0; transform: translateX(-50%) translateY(20px); }
}
    </style>
</head>
<body>
<div class="wrap">
    <h2>Patient Signup</h2>



  <form autocomplete="off">

        <label>Full Name</label>
        <input type="text" name="patientName" id="patientName" required />
		<div class="error" id="error-patientName"></div>
		
        <label>Age</label>
        <input type="number" name="age" id="age" required min=0 />
		<div class="error" id="error-age"></div>
		
        <label>City</label>
        <input type="text" name="city" id="city" required />
		<div class="error" id="error-city"></div>
		
        <label>Email</label>
        <input type="email" name="email" id="email" required />
		<div class="error" id="error-email"></div>
		
        <label>Password</label>
        <input type="password" name="password" id="password" required />
		<div class="error" id="error-password"></div>
		
        <div class="row">
            <button class="btn" type="submit" id="patientSignUp">Sign Up</button>
        </div>
    </form>
</div>
<div id="successSticker" style="display: none;">Patient registered successfully! Redirecting to Login</div>

<script>

//🔹 Helper Functions
function showError(id, message) {
    $("#error-" + id).text(message);
    $("#" + id).css("border-color", "#b00020");
}

function clearError(id) {
    $("#error-" + id).text("");
    $("#" + id).css("border-color", "");
}

// 🔹 Validation Functions
function validatePatientName() {
    const val = $("#patientName").val().trim();
    if (!val) {
        showError("patientName", "Patient Name is required");
        return false;
    } else if (val.length < 3 || val.length > 100) {
        showError("patientName", "Name must be between 3 and 100 characters");
        return false;
    }
    return true;
}

function validateAge() {
	const age = $("#age").val().trim();
	if (!age) {
		showError("age", "Age is required");
		return false;
	}
    const val = parseInt($("#age").val(), 10);
    if (isNaN(val)) {
        showError("age", "Age should be a number");
        return false;
    } else if (val < 0 || val > 120) {
        showError("age", "Age must be between 0 and 120");
        return false;
    }
    return true;
}

function validateCity() {
    const val = $("#city").val().trim();
    if (!val) {
        showError("city", "City is required");
        return false;
    }
    return true;
}

function validateEmail() {
    const val = $("#email").val().trim();
    if (!val) {
        showError("email", "Email is required");
        return false;
    } else if (!/^\S+@\S+\.\S+$/.test(val)) {
        showError("email", "Invalid Email format");
        return false;
    }
    return true;
}

function validatePassword() {
    const val = $("#password").val();
    const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
    if (!val) {
        showError("password", "Password is required");
        return false;
    } else if (!pattern.test(val)) {
        showError("password", "Password must include uppercase, lowercase, number, and special character");
        return false;
    }
    return true;
}

//🔹 Blur (exit) triggers
$("#patientName").on("blur", validatePatientName);
$("#age").on("blur", validateAge);
$("#city").on("blur", validateCity);
$("#email").on("blur", validateEmail);
$("#password").on("blur", validatePassword);

// 🔹 Clear error on typing/focus/change
$("input").on("focus input change", function () {
    const id = $(this).attr("id");
    clearError(id);
});


$("#patientSignUp").click(function(event) {
	event.preventDefault();
	
	const isValid = [
        validatePatientName(),
        validateAge(),
        validateCity(),
        validateEmail(),
        validatePassword()
    ].every(Boolean);

    if (!isValid) return;

	
    $.ajax({
        url: "/SOHAS/patients/signup",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	patientName: $("#patientName").val(),
            age: parseInt($("#age").val()),
            city: $("#city").val(),
            email: $("#email").val(),
            password: $("#password").val()
        }),
        success: function() {
            //alert("Patient added!");
            $("#successSticker").fadeIn();

            setTimeout(() => {
                $("#successSticker").fadeOut(() => {
                    window.location.href = "${pageContext.request.contextPath}/login";
                });
            }, 1000); // 1 seconds
            //window.location.href = "${pageContext.request.contextPath}/";
        },
        error: function(xhr) {
            if (xhr.status === 400) {
                const errors = xhr.responseJSON;

                $(".error").text(""); // Clear previous errors
                $("input").css("border-color", ""); // Reset borders

                for (const field in errors) {
                    $("#error-" + field).text(errors[field]);
                    $("#" + field).css("border-color", "#b00020"); // Highlight field
                }
            }
        }
    });
});
</script>
</body>
</html>
