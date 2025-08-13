<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>SOHAS • Login</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f7fb; margin:0; }
        .wrap { max-width:420px; margin:60px auto; background:#fff; padding:28px; border-radius:10px; box-shadow:0 10px 25px rgba(0,0,0,.08); }
        h2 { margin:0 0 18px; text-align:center; }
        label { display:block; margin:12px 0 6px; font-size:14px; color:#333; }
        input { width:100%; padding:10px 12px; border:1px solid #ddd; border-radius:6px; font-size:14px; }
        .row { display:flex; justify-content:space-between; align-items:center; margin-top:16px; }
        .btn { background:#0d6efd; color:#fff; border:0; padding:10px 16px; border-radius:6px; cursor:pointer; }
        .btn:hover { background:#0b5ed7; }
        .dropdown { position: relative; }
        .dropdown-btn { background:none; border:none; color:#0d6efd; cursor:pointer; font-size:14px; }
        .dropdown-content { display:none; position:absolute; right:0; background:#fff; border:1px solid #ddd; border-radius:6px; min-width:140px; box-shadow:0 8px 16px rgba(0,0,0,.1); }
        .dropdown-content a { display:block; padding:8px 12px; font-size:14px; color:#333; text-decoration:none; }
        .dropdown-content a:hover { background:#f0f0f0; }
        .dropdown.show .dropdown-content { display:block; }
    </style>
</head>
<body>
<div class="wrap">
    <h2>Login</h2>

    <form action="${pageContext.request.contextPath}/login" method="post" autocomplete="off">
        <label>Email</label>
        <input type="email" name="email" required />

        <label>Password</label>
        <input type="password" name="password" required />

        <!-- CSRF token if Spring Security is enabled -->
        <c:if test="${not empty _csrf}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </c:if>

        <div class="row">
            <button class="btn" type="submit">Login</button>

            <div class="dropdown" id="signupDropdown">
                <button type="button" class="dropdown-btn">Sign Up ▾</button>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/patientSignup">Patient</a>
                    <a href="${pageContext.request.contextPath}/doctorSignup">Doctor</a>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    // Toggle dropdown on click
    const dropdown = document.getElementById('signupDropdown');
    const btn = dropdown.querySelector('.dropdown-btn');

    btn.addEventListener('click', function (e) {
        e.stopPropagation();
        dropdown.classList.toggle('show');
    });

    // Close dropdown if clicking outside
    document.addEventListener('click', function () {
        dropdown.classList.remove('show');
    });
</script>
</body>
</html>
