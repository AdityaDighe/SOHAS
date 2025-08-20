<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error - SOHAS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            color: #fff;
        }
        .error-box {
            background: rgba(255,255,255,0.1);
            backdrop-filter: blur(14px);
            border-radius: 16px;
            padding: 40px 50px;
            text-align: center;
            box-shadow: 0 8px 32px rgba(0,0,0,0.4);
            max-width: 500px;
        }
        h1 {
            font-size: 60px;
            margin: 0;
            color: #ff4e50;
            text-shadow: 0 0 20px rgba(255,78,80,0.8);
        }
        h2 {
            margin-top: 10px;
            font-size: 22px;
            font-weight: 600;
        }
        p {
            margin-top: 10px;
            font-size: 15px;
            opacity: 0.9;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: bold;
            cursor: pointer;
            background: linear-gradient(135deg, #00c6ff, #0072ff);
            color: #fff;
            text-decoration: none;
            transition: 0.2s;
        }
        .btn:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(0, 198, 255, 0.8);
        }
    </style>
</head>
<body>
<div class="error-box">
    <h1>Oops!</h1>
    <h2>Something went wrong</h2>
    <p>
        <% if (exception != null) { %>
            <%= exception.getMessage() %>
        <% } else { %>
            An unexpected error has occurred.
        <% } %>
    </p>
    <a href="<%= request.getContextPath() %>/" class="btn">Go Back Home</a>
</div>
</body>
</html>
