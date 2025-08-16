
<%
    String user = (String) session.getAttribute("username"); 
    boolean loggedIn = false;

    // Check if jwtToken cookie exists
    javax.servlet.http.Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (javax.servlet.http.Cookie c : cookies) {
            if ("jwtToken".equals(c.getName()) && c.getValue() != null && !c.getValue().isEmpty()) {
                loggedIn = true;
                break;
            }
        }
    }
%>


<!DOCTYPE html>
<html>
<head>
    <style>
        :root {
            --brand: #0d6efd;
            --bg: #f5f7fb;
            --text-dark: #0b1220;
            --text-light: #6b7280;
            --card-bg: rgba(255, 255, 255, 0.85);
            --card-border: rgba(255, 255, 255, 0.3);
        }

        /* Header Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .profile {
            position: relative;
        }

        .profile-btn {
            background: var(--brand);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 30px;
            cursor: pointer;
            font-size: 0.95rem;
            font-weight: 600;
            transition: background 0.3s ease;
        }

        .profile-btn:hover {
            background: #0b5ed7;
        }

        /* Dropdown Menu */
        .dropdown {
            display: none;
            position: absolute;
            top: 110%;
            right: 0;
            background: white;
            border-radius: 12px;
            border: 1px solid var(--card-border);
            box-shadow: 0 6px 20px rgba(0,0,0,0.1);
            min-width: 170px;
            overflow: hidden;
        }

        .dropdown a {
            display: block;
            padding: 12px 16px;
            text-decoration: none;
            color: var(--text-dark);
            font-size: 0.95rem;
            transition: background 0.2s;
        }

        .dropdown a:hover {
            background: var(--bg);
        }

        .profile:hover .dropdown {
            display: block;
        }

        /* Responsive */
        @media (max-width: 640px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
                padding: 12px 20px;
            }
            .profile {
                margin-top: 8px;
                width: 100%;
            }
            .profile-btn {
                width: 100%;
                text-align: center;
            }
            .dropdown {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<header class="navbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="logo">SOHAS</a>
    <div class="profile">
        <% if (!loggedIn) { %>
            <a href="${pageContext.request.contextPath}/login">
                <button class="profile-btn">Login</button>
            </a>
        <% } else { %>
            <button class="profile-btn"><%= (user != null) ? user : "User" %></button>
            <div class="dropdown">
                <a href="#">Profile</a>
                <a href="#">Settings</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        <% } %>
    </div>
</header>
</body>
</html>
