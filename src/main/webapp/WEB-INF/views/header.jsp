
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
            --bg: #0f172a;
            --card-bg: rgba(255, 255, 255, 0.08);
            --card-border: rgba(255, 255, 255, 0.2);
        }

        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow-x: hidden;   /* prevent sideways scroll */
            overflow-y: auto;     /* only scroll if real content exists */
            font-family: 'Segoe UI', sans-serif;
            background: var(--bg);
        }

      .navbar {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 12px 24px;   /* Add spacing inside navbar */
		    background: #6A3DAA;
		    backdrop-filter: blur(10px);
		    border-bottom: 1px solid rgba(255, 255, 255, 0.2);
		    position: sticky;
		    top: 0;
		    z-index: 1000;
		    overflow: visible;   /* allow glow to show fully */
		}
        .navbar .logo {
            font-size: 1.6rem;
            font-weight: 700;
            background: linear-gradient(90deg, #00c6ff, #0072ff);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            cursor: pointer;
        }

        .navbar-center {
            flex: 1;
            text-align: center;
            font-size: 1.3rem;
            font-weight: 600;
            background: linear-gradient(90deg, #a1ffce, #faffd1);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .navbar-right {
            display: flex;
            gap: 10px;
        }

        /* remove underline globally for navbar links */
        .navbar a {
		    text-decoration: none;
		    margin: 0 12px;
		    color: white;
		    font-weight: 500;
		}
        .navbar a:link,
        .navbar a:visited,
        .navbar a:hover,
        .navbar a:active {
            text-decoration: none !important;
            color: inherit;
        }

        .nav-btn {
            border: none;
            padding: 8px 14px;
            border-radius: 25px;
            font-size: 0.9rem;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: transform 0.2s ease, box-shadow 0.3s ease;
            color: white;
        }

        /* Button Glow Variants */
        .btn-blue   { background: linear-gradient(135deg, #3a7bd5, #00d2ff); box-shadow: 0 0 12px #00d2ff; }
        .btn-purple { background: linear-gradient(135deg, #8e2de2, #4a00e0); box-shadow: 0 0 12px #8e2de2; }
        .btn-green  { background: linear-gradient(135deg, #56ab2f, #a8e063); box-shadow: 0 0 12px #56ab2f; }
        .btn-red    { background: linear-gradient(135deg, #ff416c, #ff4b2b); box-shadow: 0 0 12px #ff416c; }

        .nav-btn:hover {
            transform: translateY(-2px) scale(1.05);
            box-shadow: 0 0 18px rgba(255, 255, 255, 0.8);
        }

        @media (max-width: 640px) {
            .navbar { flex-direction: column; gap: 12px; }
            .navbar-center { margin: 10px 0; }
            .navbar-right { justify-content: center; flex-wrap: wrap; }
        }
    </style>
</head>
<body>

<header class="navbar">
    <!-- Left: Logo -->
    <a href="${pageContext.request.contextPath}/" class="logo">SOHAS</a>

    <!-- Center: Welcome -->
    <div class="navbar-center">
	    <% 
	        if (loggedIn) { 
	            if ("doctor".equalsIgnoreCase(role)) {   // role should be set in session or request
	    %>
	                Welcome Dr. <%= user %> !
	    <% 
	            } else { 
	    %>
	                Welcome <%= user %> !
	    <% 
	            } 
	        } 
	    %>
	</div>


    <!-- Right: Buttons -->
    <div class="navbar-right">
        <% if (!loggedIn) { %>
            <a href="${pageContext.request.contextPath}/login">
                <button class="nav-btn btn-blue"><i class="fas fa-sign-in-alt"></i> Login</button>
            </a>
        <% } else { %>
            <% if ("doctor".equalsIgnoreCase(role)) { %>
                <a href="${pageContext.request.contextPath}/doctorDashboard">
                    <button class="nav-btn btn-green"><i class="fas fa-calendar-check"></i> Appointments</button>
                </a>
                <a href="${pageContext.request.contextPath}/doctor/profile">
                    <button class="nav-btn btn-purple"><i class="fas fa-user-md"></i> Profile</button>
                </a>
            <% } else if ("patient".equalsIgnoreCase(role)) { %>
                <a href="${pageContext.request.contextPath}/patientDashboard">
                    <button class="nav-btn btn-green"><i class="fas fa-calendar-check"></i> Appointments</button>
                </a>
                <a href="${pageContext.request.contextPath}/patient/profile">
                    <button class="nav-btn btn-purple"><i class="fas fa-user"></i> Profile</button>
                </a>
            <% } %>
            <a href="javascript:void(0);" id="logoutBtn">
                <button class="nav-btn btn-red"><i class="fas fa-sign-out-alt"></i> Logout</button>
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
                    alert(response);
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
