
<%
String user = (String) request.getAttribute("username");
String role = (String) request.getAttribute("role");
boolean loggedIn = (user != null);
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<style>
:root {
	--brand: #0d6efd;
	--bg: #0f172a;
}

.navbar {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 12px 24px;
	background: #6A3DAA;
	backdrop-filter: blur(10px);
	border-bottom: 1px solid rgba(255, 255, 255, 0.2);
	position: sticky;
	top: 0;
	z-index: 9999; /* high z-index to stay above other content */
}

.logo {
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
	position: relative;
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
	position: relative;
}

/* Toast Notification */
#toast {
	display: none;
	position: fixed;
	bottom: 30px;
	left: 50%;
	transform: translateX(-50%); /* Center horizontally */
	padding: 12px 20px;
	background: #ffc107;
	color: #000;
	font-weight: bold;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
	z-index: 9999;
	text-align: center;
}

.btn-blue {
	background: linear-gradient(135deg, #3a7bd5, #00d2ff);
	box-shadow: 0 0 12px #00d2ff;
}

.btn-purple {
	background: linear-gradient(135deg, #8e2de2, #4a00e0);
	box-shadow: 0 0 12px #8e2de2;
}

.btn-green {
	background: linear-gradient(135deg, #56ab2f, #a8e063);
	box-shadow: 0 0 12px #56ab2f;
}

.btn-red {
	background: linear-gradient(135deg, #ff416c, #ff4b2b);
	box-shadow: 0 0 12px #ff416c;
}

.nav-btn:hover {
	transform: translateY(-2px) scale(1.05);
	box-shadow: 0 0 18px rgba(255, 255, 255, 0.8);
}

/* Dropdown */
.dropdown {
	position: relative;
}

.dropdown-content {
	display: none;
	position: absolute;
	top: 120%;
	right: 0;
	background: rgba(20, 20, 30, 0.97); /* opaque dark background */
	border-radius: 8px;
	min-width: 150px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
	z-index: 10000; /* above .wrap */
	flex-direction: column;
}

.dropdown-content a {
	color: #fff;
	padding: 10px 14px;
	text-decoration: none;
}

.dropdown-content a:hover {
	background: rgba(255, 255, 255, 0.1);
}

.dropdown:hover .dropdown-content {
	display: flex;
	flex-direction: column;
}

.dropdown-content a:last-child {
	border-bottom: none;
}

.dropdown:hover .dropdown-content {
	display: flex;
}

@media ( max-width : 640px) {
	.navbar {
		flex-direction: column;
		gap: 12px;
	}
	.navbar-center {
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
			<%
			if (loggedIn) {
				if ("doctor".equalsIgnoreCase(role)) {
			%>
			Welcome Dr.
			<%=user%>
			!
			<%
			} else {
			%>
			Welcome
			<%=user%>
			!
			<%
			}
			}
			%>
		</div>

		<!-- Right: Buttons -->
		<div class="navbar-right">
			<%
			if (!loggedIn) {
			%>
			<a href="${pageContext.request.contextPath}/login">
				<button class="nav-btn btn-blue">
					<i class="fas fa-sign-in-alt"></i> Login
				</button>
			</a>

			<!-- Register Dropdown -->
			<div class="dropdown">
				<button class="nav-btn btn-purple">
					<i class="fas fa-user-plus"></i> Register <i
						class="fas fa-caret-down"></i>
				</button>
				<div class="dropdown-content">
					<a href="${pageContext.request.contextPath}/patientSignup"><i
						class="fas fa-user"></i> Patient</a> <a
						href="${pageContext.request.contextPath}/doctorSignup"><i
						class="fas fa-user-md"></i> Doctor</a>
				</div>
			</div>
			<%
			} else {
			%>
			<%
			if ("doctor".equalsIgnoreCase(role)) {
			%>
			<a href="${pageContext.request.contextPath}/doctorDashboard">
				<button class="nav-btn btn-green">
					<i class="fas fa-calendar-check"></i> Appointments
				</button>
			</a> <a href="${pageContext.request.contextPath}/doctor/profile">
				<button class="nav-btn btn-purple">
					<i class="fas fa-user-md"></i> Profile
				</button>
			</a>
			<%
			} else if ("patient".equalsIgnoreCase(role)) {
			%>
			<a href="${pageContext.request.contextPath}/patientDashboard">
				<button class="nav-btn btn-green">
					<i class="fas fa-calendar-check"></i> Appointments
				</button>
			</a> <a href="${pageContext.request.contextPath}/patient/profile">
				<button class="nav-btn btn-purple">
					<i class="fas fa-user"></i> Profile
				</button>
			</a>
			<%
			}
			%>
			<a href="javascript:void(0);" id="logoutBtn">
				<button class="nav-btn btn-red">
					<i class="fas fa-sign-out-alt"></i> Logout
				</button>
			</a>
			<%
			}
			%>
		</div>
	</header>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	
	
	
	 function showToast(message, type) {
	        let toast = $("#toast");
	        toast.removeClass("toast-success toast-error");
	        toast.addClass(type === "success" ? "toast-success" : "toast-error");
	        toast.text(message).fadeIn();

	        setTimeout(() => { toast.fadeOut(); }, 3000);
	    }
	 
	 
		// Helper to get cookie
	    function getCookie(name) {
	        let match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
	        return match ? match[2] : null;
	    }
		
		let tokenFromCookie = getCookie("jwtToken");
		$(document).ready(function() {
			$("#logoutBtn").click(function() {
				$.ajax({
						url : "${pageContext.request.contextPath}/api/logout",
						type : "POST",
						headers: {
			                "Authorization": "Bearer " + tokenFromCookie
			            },
						success : function(response) {
							alert(response);
							history.pushState(null, null, "/SOHAS/");
							window.onpopstate = function () {
							    history.go(1);
							};
							window.location.href = "${pageContext.request.contextPath}/";
						},
					    error : function(xhr) {
							alert("Logout failed: "+ xhr.responseText);
						}
						});
				});
		});
	</script>


	<div id="toast"
		style="display: none; position: fixed; bottom: 30px; right: 30px; padding: 12px 20px; background: #ffc107; color: #000; font-weight: bold; border-radius: 8px; box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3); z-index: 9999;">
	</div>
</body>
</html>
