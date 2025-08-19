<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS • Forgot Password</title>
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
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .wrap {
            width: 400px;
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
            margin-bottom: 24px;
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

        .btn {
            background: linear-gradient(135deg, #0d6efd, #6610f2);
            color: #fff;
            border: none;
            padding: 12px 18px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 18px;
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
    <h2>Forgot Password</h2>
    <form id="forgotForm">
        <label>Email</label>
        <input type="email" id="email" name="email" required />
        <div class="error" id="error-email"></div>

        <label>New Password</label>
        <input type="password" id="newPassword" name="newPassword" required />
        <div class="error" id="error-newPassword"></div>

        <button type="submit" class="btn">Reset Password</button>
    </form>
</div>

<div id="successSticker">Password reset successfully! Redirecting to Login</div>

<script>
    function showError(id, message) {
        $("#error-" + id).text(message);
        $("#" + id).css("border-color", "#ff6b6b");
    }

    function clearError(id) {
        $("#error-" + id).text("");
        $("#" + id).css("border-color", "");
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
            showError("newPassword", "Password must include uppercase, lowercase, number, and special character");
            return false;
        }
        return true;
    }

    $("#email").on("blur", validateEmail);
    $("#newPassword").on("blur", validatePassword);

    $("input").on("focus input change", function () {
        clearError($(this).attr("id"));
    });

    $("#forgotForm").on("submit", function(e) {
        e.preventDefault();

        const valid = validateEmail() & validatePassword();
        if(!valid) return;

        $.ajax({
            url: "${pageContext.request.contextPath}/api/forgot-password",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                email: $("#email").val(),
                newPassword: $("#newPassword").val()
            }),
            success: function(response) {
                $("#successSticker").fadeIn();
                setTimeout(() => {
                    $("#successSticker").fadeOut(() => {
                        window.location.href = "${pageContext.request.contextPath}/login";
                    });
                }, 1500);
            },
            error: function(xhr) {
                alert(xhr.responseJSON?.message || "Error resetting password");
            }
        });
    });
</script>
</body>
</html>
