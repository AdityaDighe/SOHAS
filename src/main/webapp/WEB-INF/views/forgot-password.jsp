<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>SOHAS • Forgot Password</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body {
             margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            min-height: 100vh;
        }

       

        .wrap {
            width: 420px;
            padding: 32px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            margin: 80px auto;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            color: #fff;
        }

        h2 {
            text-align: center;
            margin-bottom: 1.5rem;
            color: #fff;
        }

        label {
            font-size: 0.9rem;
            margin-bottom: 6px;
            display: block;
            color: #fff;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 12px;
            border-radius: 10px;
            border: none;
            font-size: 14px;
            outline: none;
            background: rgba(255,255,255,0.15);
            color: #fff;
        }

        input::placeholder {
            color: rgba(255,255,255,0.7);
        }

        button {
            width: 100%;
            padding: 12px;
            margin-top: 8px;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: #fff;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.2);
        }

        .error {
            color: #ffcccc;
            font-size: 13px;
            margin-top: -6px;
            margin-bottom: 10px;
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
    <h2>Forgot Password</h2>
    <form id="forgotForm">
        <div id="step1">
            <label>Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required />
            <div id="error-email" class="error"></div>
            <button type="button" class="btn" id="sendOtpBtn">Send OTP</button>
        </div>

        <div id="step2" style="display:none;">
            <label>OTP</label>
            <input type="text" id="otp" name="otp" placeholder="Enter OTP" required />

            <label>New Password</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required />
            <div id="error-newPassword" class="error"></div>

            <button type="submit" class="btn">Reset Password</button>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
// keep your same validation + ajax code
function showError(id, message) {
    $("#error-" + id).text(message);
    $("#" + id).css("border", "1px solid #ff6666");
}

function clearError(id) {
    $("#error-" + id).text("");
    $("#" + id).css("border", "none");
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
    const val = $("#newPassword").val();
    const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
    if (!val) {
        showError("newPassword", "Password is required");
        return false;
    } else if (!pattern.test(val)) {
        showError("newPassword","Password must include uppercase, lowercase, number, and special character");
        return false;
    }
    return true;
}

$("#email").on("blur", validateEmail);
$("#newPassword").on("blur", validatePassword);

$("input").on("focus input change", function() {
    const id = $(this).attr("id");
    clearError(id);
});

$("#sendOtpBtn").on("click", function() {
    $.ajax({
        url: "${pageContext.request.contextPath}/api/request-otp",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ email: $("#email").val() }),
        success: function(response) {
            alert(response.message);
            $("#step1").hide();
            $("#step2").fadeIn();
        },
        error: function(xhr) {
            alert(xhr.responseJSON.message || "Error sending OTP");
        }
    });
});

$("#forgotForm").on("submit", function(e) {
    e.preventDefault();
    if (!validateEmail() || !validatePassword()) return;

    $.ajax({
        url: "${pageContext.request.contextPath}/api/reset-password",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            email: $("#email").val(),
            otp: $("#otp").val(),
            newPassword: $("#newPassword").val()
        }),
        success: function(response) {
            alert(response.message);
            window.location.href = "${pageContext.request.contextPath}/login";
        },
        error: function(xhr) {
            alert(xhr.responseJSON?.message || "Error resetting password");
        }
    });
});
</script>
</body>
</html>
