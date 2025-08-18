<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        body { font-family: Arial; background: linear-gradient(180deg, #e6f0ff 0%, #ffffff 100%); margin: 0; padding: 0; width: 100%; x`}
        h2 { text-align: center; }
        .wrap { max-width:400px; margin:60px auto; background:#fff; padding:20px; border-radius:10px; box-shadow:0 10px 20px rgba(0,0,0,0.1); }
        button { width:100%; padding:10px; margin-top:10px; border-radius:6px; }
        label { display:block; margin:12px 0 6px; font-size:14px; color:#333; }
        input { width:100%; padding:10px 12px; border:1px solid #ddd; border-radius:6px; font-size:14px;  }
        .btn { background:#007bff; color:#fff; border:none; cursor:pointer; }
        .btn:hover { background:#0056b3; transform: scale(1.05);}
        .error {color: #b00020; font-size: 13px; margin-top: 4px;}
    </style>
</head>
<body>
<header style="padding: 1rem 2rem; display: flex; align-items: center; background-color: white; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); width: 100%; box-sizing: border-box;">
	<a href="${pageContext.request.contextPath}/" style="text-decoration: none; font-weight: 600; font-size: 1.4rem; color: #0d6efd;">
		SOHAS
	</a>
</header>
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>

function showError(id, message) {
    $("#error-" + id).text(message);
    $("#" + id).css("border-color", "#b00020");
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
    const id = $(this).attr("id");
    clearError(id);
});




    $("#forgotForm").on("submit", function(e) {
        e.preventDefault();
        $.ajax({
            url: "${pageContext.request.contextPath}/api/forgot-password",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                email: $("#email").val(),
                newPassword: $("#newPassword").val()
            }),
            success: function(response) {
                alert(response.message);
                window.location.href = "${pageContext.request.contextPath}/login";
            },
            error: function(xhr) {
                alert(xhr.responseJSON.message || "Error resetting password");
            }
        });
    });
</script>
</body>
</html>