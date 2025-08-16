<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="en">



<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SOHAS • Smarter Healthcare</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap"
	rel="stylesheet">
<style>
:root {
	--brand: #0d6efd;
	--bg: #f5f7fb;
	--text-dark: #0b1220;
	--text-light: #6b7280;
	--card-bg: rgba(255, 255, 255, 0.85);
	--card-border: rgba(255, 255, 255, 0.3);
}

body {
	font-family: 'Inter', sans-serif;
	margin: 0;
	background: var(--bg);
	color: var(--text-dark);
}

/* ===== Hero ===== */
.hero {
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 80vh;
	padding: 2rem;
	background: linear-gradient(135deg, #eaf2ff, #fefefe);
}

.hero-content {
	max-width: 900px;
	text-align: center;
}

.hero-content h1 {
	font-size: 3rem;
	font-weight: 700;
	margin-bottom: 1rem;
	background: linear-gradient(90deg, var(--brand), #5b9dff);
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
	margin: 0 0.5rem;
	border-radius: 12px;
	font-weight: 600;
	text-decoration: none;
	transition: 0.3s ease;
}

.btn-primary {
	background: var(--brand);
	color: white;
}

.btn-primary:hover {
	background: #0b5ed7;
}

.btn-outline {
	border: 2px solid var(--brand);
	color: var(--brand);
}

.btn-outline:hover {
	background: var(--brand);
	color: white;
}

/* ===== Bento Grid ===== */
.bento-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
	gap: 1.5rem;
	padding: 4rem 2rem;
	max-width: 1200px;
	margin: auto;
}

.bento-item {
	background: var(--card-bg);
	border: 1px solid var(--card-border);
	border-radius: 18px;
	padding: 1.5rem;
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
	backdrop-filter: blur(14px) saturate(140%);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.bento-item:hover {
	transform: translateY(-6px);
	box-shadow: 0 14px 30px rgba(0, 0, 0, 0.08);
}

.bento-item h3 {
	margin-top: 0;
	font-size: 1.2rem;
}

.bento-item p {
	color: var(--text-light);
	font-size: 0.95rem;
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

	<%@ include file="header.jsp"%>

	<!-- HERO -->
	<section class="hero">
		<div class="hero-content">
			<h1>Your Health, Our Priority</h1>
			<p>SOHAS connects patients and doctors seamlessly — book, manage,
				and consult with ease. Secure, fast, and designed for the modern
				world.</p>
			<div class="hero-buttons">
				<a href="${pageContext.request.contextPath}/login"
					class="btn-primary">Get Started</a>

			</div>
		</div>
	</section>

	<!-- BENTO GRID -->
	<section class="bento-grid">
		<div class="bento-item">
			<h3>📅 Easy Appointment Booking</h3>
			<p>Schedule consultations with top doctors in just a few clicks,
				from anywhere at any time.</p>
		</div>
		<div class="bento-item">
			<h3>👨‍⚕️ Verified Doctors</h3>
			<p>Only licensed and verified healthcare professionals are listed
				on SOHAS.</p>
		</div>
		<div class="bento-item">
			<h3>🏥 Multi-City Coverage</h3>
			<p>Available across major cities like Mumbai, Pune, Bhopal, and
				Chennai.</p>
		</div>
		<div class="bento-item">
			<h3>🔒 Secure & Private</h3>
			<p>We use modern encryption and secure authentication to protect
				your data.</p>
		</div>
		<div class="bento-item">
			<h3>📊 Smart Dashboard</h3>
			<p>Track appointments, medical history, and doctor notes in one
				place.</p>
		</div>
		<div class="bento-item">
			<h3>⚡ Real-time Updates</h3>
			<p>Get instant notifications for booking confirmations and
				changes.</p>
		</div>
	</section>

	<!-- FOOTER -->
	<footer> © 2025 SOHAS. All rights reserved. </footer>

</body>
</html>

