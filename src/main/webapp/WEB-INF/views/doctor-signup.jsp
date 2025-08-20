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
            width: 420px;
            padding: 32px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(12px);
            margin: 80px auto;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.25);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            color: #fff;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 1.6rem;
            font-weight: 600;
            text-shadow: 0 0 8px rgba(255, 255, 255, 0.6);
        }

        label {
            display: block;
            margin: 14px 0 6px;
            font-size: 14px;
            color: #e5e5e5;
            text-align: left;
        }

        input, select {
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

        input:focus, select:focus {
            border-color: #0d6efd;
            background: rgba(255, 255, 255, 0.2);
            box-shadow: 0 0 8px #0d6efd;
        }

        .row {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
            margin-top: 18px;
            flex-wrap: wrap;
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

        .error {
            color: #ff6b6b;
            font-size: 13px;
            margin-top: 4px;
            text-align: left;
        }

        #successSticker {
            position: fixed;
            bottom: 30px;
            left: 50%;
            transform: translateX(-50%);
            background-color: #4BB543;
            color: white;
            padding: 12px 24px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
            z-index: 9999;
            font-size: 15px;
            display: none;
            animation: fadeInOut 2s ease-in-out;
        }

        @keyframes fadeInOut {
            0% { opacity: 0; transform: translateX(-50%) translateY(20px); }
            10% { opacity: 1; transform: translateX(-50%) translateY(0); }
            90% { opacity: 1; transform: translateX(-50%) translateY(0); }
            100% { opacity: 0; transform: translateX(-50%) translateY(20px); }
        }
        
        .navbar  a {
		    text-decoration: none !important;
		    color: inherit;
		}
		
		select option {
        background-color:  #203a43; /* grey background */
        color: white;           /* white text */
    	}

    </style>
</head>
<body>
<%@ include file="header.jsp" %>

<div class="wrap">
    <h2>Doctor Signup</h2>

    <form id="doctorSignupForm" autocomplete="off">
        <label>Full Name</label>
        <input type="text" id="doctorName" required />
        <div class="error" id="error-doctorName"></div>

        <label>Speciality</label>
        <input type="text" id="speciality" required />
        <div class="error" id="error-speciality"></div>

        <label>Phone Number</label>
        <input type="text" id="phoneNumber" required />
        <div class="error" id="error-phoneNumber"></div>

        <label>City</label>
        <select id="city" required>
            <option value="">-- Select City --</option>
            <option value="Mumbai">Mumbai</option>
            <option value="Chennai">Chennai</option>
            <option value="Pune">Pune</option>
            <option value="Bhopal">Bhopal</option>
        </select>
        <div class="error" id="error-city"></div>

        <label>Hospital Name</label>
        <input type="text" id="hospitalName" required />
        <div class="error" id="error-hospitalName"></div>

        <label>Start Time</label>
        <input type="time" id="startTime" required />
        <div class="error" id="error-startTime"></div>

        <label>End Time</label>
        <input type="time" id="endTime" required />
        <div class="error" id="error-endTime"></div>

        <label>Email</label>
        <input type="email" id="email" required />
        <div class="error" id="error-email"></div>

        <label>Password</label>
        <input type="password" id="password" required />
        <div class="error" id="error-password"></div>

        <div class="row">
            <button class="btn" type="button" id="doctorSignUp">Sign Up</button>
        </div>
    </form>
</div>

<div id="successSticker">Doctor registered successfully! Redirecting to Login</div>

<script>
    function showError(id, message) {
        $("#error-" + id).text(message);
        $("#" + id).css("border-color", "#ff6b6b");
    }

    function clearError(id) {
        $("#error-" + id).text("");
        $("#" + id).css("border-color", "");
    }

 // 🔹 Validation Functions
	function validateDoctorName() {
	    const val = $("#doctorName").val().trim();
	    if (!val) {
	        showError("doctorName", "Doctor Name is required");
	        return false;
	    } else if (val.length < 3 || val.length > 100) {
	        showError("doctorName", "Name must be between 3 and 100 characters");
	        return false;
	    }
	    return true;
	}

	function validateSpeciality() {
	    const val = $("#speciality").val().trim();
	    if (!val) {
	        showError("speciality", "Speciality is required");
	        return false;
	    } else if (val.length > 100) {
	        showError("speciality", "Speciality must be at most 100 characters");
	        return false;
	    }
	    return true;
	}

	function validatePhoneNumber() {
	    const val = $("#phoneNumber").val().trim();
	    if (!val) {
	        showError("phoneNumber", "Phone Number is required");
	        return false;
	    } else if (!/^\d{10}$/.test(val)) {
	        showError("phoneNumber", "Phone Number must be 10 digits");
	        return false;
	    }
	    return true;
	}

	function validateCity() {
	    const val = $("#city").val();
	    if (!val) {
	        showError("city", "City is required");
	        return false;
	    }
	    return true;
	}

	function validateHospitalName() {
	    const val = $("#hospitalName").val().trim();
	    if (!val) {
	        showError("hospitalName", "Hospital Name is required");
	        return false;
	    }
	    return true;
	}

	function validateEmail() {
	    const val = $("#email").val().trim();
	    if (!val) {
	        showError("email", "Email is required");
	        return false;
	    } else if (!/^\S+@\S+\.\S+$/.test(val)) {
	        showError("email", "Invalid Email format");
	        return false;
	    }
	    return true;
	}

	function validatePassword() {
	    const val = $("#password").val();
	    const pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;
	    if (!val) {
	        showError("password", "Password is required");
	        return false;
	    } else if (!pattern.test(val)) {
	        showError("password", "Password must be at least 8 characters with uppercase, lowercase, number, and special character");
	        return false;
	    }
	    return true;
	}

	function validateStartEndTime() {
	    const startTime = $("#startTime").val();
	    const endTime = $("#endTime").val();
	    let isValid = true;

	    if (!startTime) {
	        showError("startTime", "Start Time is required");
	        isValid = false;
	    }

	    if (!endTime) {
	        showError("endTime", "End Time is required");
	        isValid = false;
	    }

	    if (startTime && endTime && endTime <= startTime) {
	        showError("endTime", "End Time must be after Start Time");
	        isValid = false;
	    }

	    return isValid;
	}
	
	$("#doctorName").on("blur", validateDoctorName);
	$("#speciality").on("blur", validateSpeciality);
	$("#phoneNumber").on("blur", validatePhoneNumber);
	$("#city").on("blur", validateCity);
	$("#hospitalName").on("blur", validateHospitalName);
	$("#email").on("blur", validateEmail);
	$("#password").on("blur", validatePassword);
	$("#startTime, #endTime").on("blur", validateStartEndTime);
	
	$("input, select").on("focus input change", function() {
	    const id = $(this).attr("id");
	    clearError(id);
	});
	

    $("#doctorSignUp").click(function(event){
        event.preventDefault();

        const isValid = [
            validateDoctorName(),
            validateSpeciality(),
            validatePhoneNumber(),
            validateCity(),
            validateHospitalName(),
            validateEmail(),
            validatePassword(),
            validateStartEndTime()
        ].every(Boolean);

        if(!isValid) return;

        $.ajax({
            url: "/SOHAS/doctors/signup",
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                doctorName: $("#doctorName").val(),
                speciality: $("#speciality").val(),
                phoneNumber: $("#phoneNumber").val(),
                city: $("#city").val(),
                hospitalName: $("#hospitalName").val(),
                startTime: $("#startTime").val()+":00",
                endTime: $("#endTime").val()+":00",
                email: $("#email").val(),
                password: $("#password").val()
            }),
            success: function() {
                $("#successSticker").fadeIn();
                setTimeout(() => {
                    $("#successSticker").fadeOut(() => {
                        window.location.href = "${pageContext.request.contextPath}/login";
                    });
                }, 1500);
            },
            error: function(xhr) {
            	if (xhr.status === 400) {
                    const errors = xhr.responseJSON;

                    $(".error").text(""); // Clear previous errors
                    $("input").css("border-color", ""); // Reset borders

                    for (const field in errors) {
                        $("#error-" + field).text(errors[field]);
                        $("#" + field).css("border-color", "#b00020"); // Highlight field
                    }
                }
                //alert("Signup failed: " + xhr.status);
            }
        });
    });
</script>
</body>
</html>
