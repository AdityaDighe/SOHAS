<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forgot Password</title>
    <style>
        body { font-family: Arial; background:#f5f5f5; }
        h2 { text-align: center; }
        .wrap { max-width:400px; margin:60px auto; background:#fff; padding:20px; border-radius:10px; box-shadow:0 10px 20px rgba(0,0,0,0.1); }
        button { width:100%; padding:10px; margin-top:10px; border-radius:6px; }
        label { display:block; margin:12px 0 6px; font-size:14px; color:#333; }
        input { width:100%; padding:10px 12px; border:1px solid #ddd; border-radius:6px; font-size:14px;  }
        .btn { background:#007bff; color:#fff; border:none; cursor:pointer; }
        .btn:hover { background:#0056b3; }
    </style>
</head>
<body>
<div class="wrap">
    <h2>Forgot Password</h2>
    <form id="forgotForm">
        <label>Email</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required />
        <label>New Password</label>
        <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required />
        <button type="submit" class="btn">Reset Password</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
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