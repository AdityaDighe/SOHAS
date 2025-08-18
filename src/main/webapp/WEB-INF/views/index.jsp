<%-- 
String user = (String) request.getAttribute("username");
String role = (String) request.getAttribute("role");
boolean loggedIn = (user != null);
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>SOHAS</title>
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">

	<style>
		:root {
			--brand: #4facfe;
			--brand2: #00f2fe;
			--bg: #0f2027;
			--bg2: #203a43;
			--bg3: #2c5364;
			--text-light: #e0e0e0;
			--text-dark: #fff;
		}

		body {
			margin: 0;
			font-family: 'Inter', sans-serif;
			background: linear-gradient(135deg, var(--bg), var(--bg2), var(--bg3));
			color: var(--text-dark);
			min-height: 100vh;
		}

		/* ===== Navbar ===== */
		.navbar {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 14px 28px;
			background: rgba(255, 255, 255, 0.08);
			backdrop-filter: blur(10px);
			border-bottom: 1px solid rgba(255, 255, 255, 0.15);
			position: sticky;
			top: 0;
			z-index: 1000;
		}

		.navbar .logo {
			font-size: 1.5rem;
			font-weight: 700;
			background: linear-gradient(90deg, var(--brand), var(--brand2));
			-webkit-background-clip: text;
			-webkit-text-fill-color: transparent;
			text-decoration: none;
		}

		.nav-links a {
			color: white;
			text-decoration: none;
			margin-left: 20px;
			font-weight: 500;
			transition: color 0.3s ease;
		}
		.nav-links a:hover {
			color: var(--brand2);
		}

		/* Clear Login Button */
		.btn-login {
			display: inline-block;
			padding: 10px 20px;
			border-radius: 10px;
			background: linear-gradient(135deg, var(--brand), var(--brand2));
			color: #fff !important;
			font-weight: 600;
			border: none;
			cursor: pointer;
			box-shadow: 0 0 12px rgba(79,172,254,0.8);
			transition: transform 0.3s ease, box-shadow 0.3s ease;
			text-decoration: none;
		}
		.btn-login:hover {
			transform: scale(1.05);
			box-shadow: 0 0 18px rgba(0,242,254,1);
			text-decoration: none;
		}

		/* ===== Hero Section ===== */
		.hero {
			display: flex;
			align-items: center;
			justify-content: center;
			min-height: 80vh;
			padding: 2rem;
			text-align: center;
			background: transparent;
		}
		.hero-content {
			max-width: 800px;
			background: rgba(255, 255, 255, 0.07);
			backdrop-filter: blur(14px);
			border-radius: 20px;
			padding: 3rem;
			box-shadow: 0 8px 30px rgba(0,0,0,0.3);
		}
		.hero-content h1 {
			font-size: 3rem;
			font-weight: 700;
			margin-bottom: 1rem;
			background: linear-gradient(90deg, var(--brand), var(--brand2));
			-webkit-background-clip: text;
			-webkit-text-fill-color: transparent;
		}
		.hero-content p {
			font-size: 1.2rem;
			color: var(--text-light);
			margin-bottom: 2rem;
		}
		.hero-buttons a {
			display: inline-block;
			padding: 0.9rem 1.6rem;
			margin: 0 0.6rem;
			border-radius: 12px;
			font-weight: 600;
			text-decoration: none;
			transition: 0.3s ease;
		}
		.btn-primary {
			background: linear-gradient(135deg, var(--brand), var(--brand2));
			color: white;
			box-shadow: 0 0 12px rgba(79,172,254,0.8);
		}
		.btn-primary:hover {
			transform: scale(1.05);
			box-shadow: 0 0 18px rgba(0,242,254,1);
		}

		/* ===== Bento Grid ===== */
		 .bento-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            padding: 40px;
            max-width: 1200px;
            margin: auto;
        }
        .bento-item {
            background: #1c2536;
            padding: 20px;
            border-radius: 20px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.4);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .bento-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 18px rgba(0,0,0,0.6);
        }
        .bento-item h3 {
            color: #00c3ff;
            font-size: 20px;
            margin-bottom: 10px;
        }
        .bento-item p {
            font-size: 15px;
            color: #d1d5db;
        }

		/* ===== Footer ===== */
		footer {
			text-align: center;
			padding: 2rem;
			color: var(--text-light);
			font-size: 0.9rem;
		}
	</style>
</head>
<body>

	<%@ include file="header.jsp" %>

	<!-- HERO -->
	<section class="hero">
		<div class="hero-content">
			<h1>Your Health, Our Priority</h1>
			<p>SOHAS connects patients and doctors seamlessly — book, manage,
				and consult with ease. Secure, fast, and designed for the modern world.</p>
			<div class="hero-buttons">
				<a href="<%= loggedIn
					? (role != null && role.equalsIgnoreCase("patient") ? "/SOHAS/patientDashboard" : "/SOHAS/doctorDashboard")
					: "/SOHAS/login"%>" class="btn-primary">Get Started</a>
			</div>
		</div>
	</section>

	<!-- BENTO GRID -->
	<section class="bento-grid">
		<div class="bento-item">
			<h3>📅 Easy Appointment Booking</h3>
			<p>Schedule consultations with top doctors in just a few clicks.</p>
		</div>
		<div class="bento-item">
			<h3>👨‍⚕️ Verified Doctors</h3>
			<p>Only licensed and verified healthcare professionals are listed on SOHAS.</p>
		</div>
		<div class="bento-item">
			<h3>🏥 Multi-City Coverage</h3>
			<p>Available across major cities like Mumbai, Pune, Bhopal, and Chennai.</p>
		</div>
		<div class="bento-item">
			<h3>🔒 Secure & Private</h3>
			<p>We use modern encryption and secure authentication to protect your data.</p>
		</div>
		<div class="bento-item">
			<h3>📊 Smart Dashboard</h3>
			<p>Track appointments, medical history, and doctor notes in one place.</p>
		</div>
		<div class="bento-item">
			<h3>⚡ Real-time Updates</h3>
			<p>Get instant notifications for booking confirmations and changes.</p>
		</div>
	</section>

	<!-- FOOTER -->
	<footer> &copy; 2025 SOHAS. All rights reserved. </footer>

</body>
</html>
