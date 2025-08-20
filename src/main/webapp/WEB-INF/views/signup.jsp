<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS • Patient Signup</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        :root {
            --bg: #0f2027;
            --bg2: #203a43;
            --bg3: #2c5364;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, var(--bg), var(--bg2), var(--bg3));
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
            display: block;
            flex-direction: column;
            align-items: center;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .wrap {
            width: 380px;
            padding: 32px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            margin: 120px auto 50px auto; /* spacing from header */
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            color: #fff;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 1.6rem;
            font-weight: 600;
            text-shadow: 0 0 8px rgba(255, 255, 255, 0.6);
        }

        label {
            display: block;
            margin: 14px 0 6px;
            font-size: 14px;
            color: #e5e5e5;
            text-align: left;
        }

        input {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid rgba(255,255,255,0.3);
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease;
        }

        input:focus {
            border-color: #0d6efd;
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 8px #0d6efd;
        }

        .row {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 18px;
            flex-wrap: wrap;
        }

        .btn {
            background: linear-gradient(135deg, #0d6efd, #6610f2);
            color: #fff;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: scale(1.05);
            box-shadow: 0 0 12px #0d6efd, 0 0 20px #6610f2;
        }

        .error {
            color: #ff6b6b;
            font-size: 13px;
            margin-top: 4px;
            text-align: left;
        }

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
        
        .navbar  a {
		    text-decoration: none !important;
		    color: inherit;
		}

    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="wrap">
    <h2>Patient Signup</h2>

    <form id="signupForm" autocomplete="off">
        <label>Full Name</label>
        <input type="text" name="patientName" id="patientName" required />
        <div class="error" id="error-patientName"></div>

        <label>Age</label>
        <input type="number" name="age" id="age" required min="0" />
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
            <button class="btn" type="button" id="patientSignUp">Sign Up</button>
        </div>
    </form>
</div>

<div id="successSticker">Patient registered successfully! Redirecting to Login</div>

<script>
    function showError(id, message) {
        $("#error-" + id).text(message);
        $("#" + id).css("border-color", "#ff6b6b");
    }
    function clearError(id) {
        $("#error-" + id).text("");
        $("#" + id).css("border-color", "");
    }
	
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
    
  	// Blur (exit) triggers
    $("#patientName").on("blur", validatePatientName);
    $("#age").on("blur", validateAge);
    $("#city").on("blur", validateCity);
    $("#email").on("blur", validateEmail);
    $("#password").on("blur", validatePassword);
    
 	//  Clear error on typing/focus/change
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
                $("#successSticker").fadeIn();
                setTimeout(() => {
                    $("#successSticker").fadeOut(() => {
                        window.location.href = "${pageContext.request.contextPath}/login";
                    });
                }, 1500);
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
            	//alert("Signup failed: " + xhr.status);
            }
        });
    });
</script>
</body>
</html>
