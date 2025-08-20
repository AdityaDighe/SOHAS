<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>SOHAS</title>
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
            width: 380px;
            padding: 32px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            margin: 120px auto 50px auto; /* spacing from sticky header */
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            color: #fff;
        }

        h2 { margin-bottom: 20px; }

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
            justify-content: space-between;
            align-items: center;
            margin-top: 18px;
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

        .dropdown {
            position: relative;
        }

        .dropdown-btn {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            color: #fff;
            cursor: pointer;
            font-size: 14px;
            padding: 10px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .dropdown-btn:hover {
            background: rgba(255,255,255,0.2);
            box-shadow: 0 0 10px #6f42c1;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            right: 0;
            margin-top: 6px;
            background: rgba(30, 30, 30, 0.9);
            border-radius: 8px;
            min-width: 150px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.4);
            overflow: hidden;
        }

        .dropdown-content a {
            display: block;
            padding: 10px 14px;
            font-size: 14px;
            color: #fff;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .dropdown-content a:hover {
            background: rgba(255,255,255,0.1);
        }

        .dropdown.show .dropdown-content {
            display: block;
        }

        .anchor-forgot {
            margin-top: 20px;
        }

        .anchor-forgot a {
            color: #fff;
            font-size: 14px;
            text-decoration: none;
            opacity: 0.85;
        }

        .anchor-forgot a:hover {
            text-decoration: underline;
            opacity: 1;
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
    <h2>Login</h2>

    <form id="loginForm" autocomplete="off">
        <label>Email</label>
        <input type="email" name="email" id="email" required />

        <label>Password</label>
        <input type="password" name="password" id="password" required />

        <c:if test="${not empty _csrf}">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </c:if>

        <div class="row">
            <button class="btn" type="button" id="login">Login</button>

            <div class="dropdown" id="signupDropdown">
                <button type="button" class="dropdown-btn">Sign Up ▾</button>
                <div class="dropdown-content">
                    <a href="${pageContext.request.contextPath}/patientSignup">Patient</a>
                    <a href="${pageContext.request.contextPath}/doctorSignup">Doctor</a>
                </div>
            </div>
        </div>

        <div class="anchor-forgot">
            <a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a>
        </div>
    </form>
</div>


<script>
    // Dropdown toggle
    const dropdown = document.getElementById('signupDropdown');
    const btn = dropdown.querySelector('.dropdown-btn');

    btn.addEventListener('click', function (e) {
        e.stopPropagation();
        dropdown.classList.toggle('show');
    });

    document.addEventListener('click', function () {
        dropdown.classList.remove('show');
    });

    // Cookie setter
    function setCookie(name, value, hours) {
        let expires = "";
        if (hours) {
            let date = new Date();
            date.setTime(date.getTime() + (hours * 60 * 60 * 1000));
            expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + value + expires + "; path=/; Secure; SameSite=Strict";
    }

    // AJAX login
    $("#login").click(function(event) {
        event.preventDefault();

        $.ajax({
            url: "${pageContext.request.contextPath}/api/login",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                email: $("#email").val(),
                password: $("#password").val()
            }),
            success: function(data) {
                setCookie("jwtToken", data.token, 2);
                window.location.href = "${pageContext.request.contextPath}/";
            },
            error: function(xhr) {
                alert("Login failed: " + xhr.status);
            }
        });
    });
</script>
</body>
</html>
