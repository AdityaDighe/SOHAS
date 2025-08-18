<%
    String user = (String) request.getAttribute("username");
    String role = (String) request.getAttribute("role");
    boolean loggedIn = (user != null);
%>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        :root {
            --brand: #0d6efd;
            --bg: #f5f7fb;
            --text-dark: #0b1220;
            --text-light: #6b7280;
            --card-bg: rgba(255, 255, 255, 0.85);
            --card-border: rgba(255, 255, 255, 0.3);
        }

        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 28px;
            background: var(--card-bg);
            backdrop-filter: blur(14px) saturate(160%);
            border-bottom: 1px solid var(--card-border);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar .logo {
            font-size: 1.6rem;
            font-weight: 700;
            background: linear-gradient(90deg, var(--brand), #5b9dff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            cursor: pointer;
        }

        .navbar-center {
            flex: 1;
            text-align: center;
            font-size: 1.4rem;
            font-weight: 600;
            background: linear-gradient(90deg, #0d6efd, #5b9dff);
			-webkit-background-clip: text;
			-webkit-text-fill-color: transparent;
        }

        .navbar-right {
            display: flex;
            gap: 10px;
        }

        .nav-btn {
            background: var(--brand);
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: background 0.3s ease, transform 0.15s ease;
        }
        
        .navbar a {
    		text-decoration: none;
    		color: inherit;
		}
        

        .nav-btn:hover {
            background: #0b5ed7;
            transform: scale(1.07);
        }

        @media (max-width: 640px) {
            .navbar {
                flex-direction: column;
                align-items: stretch;
                gap: 10px;
            }
            .navbar-center {
                text-align: center;
                margin: 10px 0;
            }
            .navbar-right {
                justify-content: center;
                flex-wrap: wrap;
            }
        }
    </style>
</head>
<body>

<header class="navbar">
    <!-- Left: Logo -->
    <a href="${pageContext.request.contextPath}/" class="logo">SOHAS</a>

    <!-- Center: Welcome -->
    <div class="navbar-center">
        <% if (loggedIn) { %>
            Welcome <%= user %> !
        <% } %>
    </div>

    <!-- Right: Buttons -->
    <div class="navbar-right">
        <% if (!loggedIn) { %>
            <a href="${pageContext.request.contextPath}/login">
                <button class="nav-btn"><i class="fas fa-sign-in-alt"></i> Login</button>
            </a>
        <% } else { %>
            <% if ("doctor".equalsIgnoreCase(role)) { %>
                <a href="${pageContext.request.contextPath}/doctorDashboard">
                    <button class="nav-btn"><i class="fas fa-calendar-check"></i> Appointments</button>
                </a>
                <a href="${pageContext.request.contextPath}/doctor/profile">
                    <button class="nav-btn"><i class="fas fa-user-md"></i> Profile</button>
                </a>
            <% } else if ("patient".equalsIgnoreCase(role)) { %>
                <a href="${pageContext.request.contextPath}/patientDashboard">
                    <button class="nav-btn"><i class="fas fa-calendar-check"></i> Appointments</button>
                </a>
                <a href="${pageContext.request.contextPath}/patient/profile">
                    <button class="nav-btn"><i class="fas fa-user"></i> Profile</button>
                </a>
            <% } %>
				<a href="javascript:void(0);" id="logoutBtn">
				    <button class="nav-btn"><i class="fas fa-sign-out-alt"></i> Logout</button>
				</a>
        <% } %>
    </div>
</header>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $("#logoutBtn").click(function () {
            $.ajax({
                url: "${pageContext.request.contextPath}/api/logout",
                type: "POST",
                success: function (response) {
                    alert(response); // shows "Logged out successfully!"
                    window.location.href = "${pageContext.request.contextPath}/"; 
                },
                error: function (xhr) {
                    alert("Logout failed: " + xhr.responseText);
                }
            });
        });
    });
</script>
</body>
</html>
