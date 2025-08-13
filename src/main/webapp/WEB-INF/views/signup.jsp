<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS - Sign up</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { width: 400px; margin: auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); }
        h2 { text-align: center; }
        input, select { width: 100%; padding: 10px; margin: 5px 0; }
        button { background: #28a745; color: #fff; border: none; padding: 10px; cursor: pointer; }
        button:hover { background: #218838; }
    </style>
</head>
<body>
<div class="container">
    <h2>Create an Account</h2>
    <form action="signup" method="post">
        <label>Full Name</label>
        <input type="text" name="name" required>

        <label>Email</label>
        <input type="email" name="email" required>

        <label>Password</label>
        <input type="password" name="password" required>

        <label>Role</label>
        <select name="role" required>
            <option value="PATIENT">Patient</option>
            <option value="DOCTOR">Doctor</option>
        </select>

        <button type="submit">Sign Up</button>
    </form>
</div>
</body>
</html>
