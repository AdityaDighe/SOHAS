<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>SOHAS • Doctor Login</title>
<style>
body {
	font-family: Arial, sans-serif;
	background: #f5f7fb;
	margin: 0;
}

.wrap {
	max-width: 420px;
	margin: 60px auto;
	background: #fff;
	padding: 28px;
	border-radius: 10px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
}

h2 {
	margin: 0 0 18px;
	text-align: center;
}

label {
	display: block;
	margin: 12px 0 6px;
	font-size: 14px;
	color: #333;
}

input {
	width: 100%;
	padding: 10px 12px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-size: 14px;
}

.row {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 16px;
}

.btn {
	background: #0d6efd;
	color: #fff;
	border: 0;
	padding: 10px 16px;
	border-radius: 6px;
	cursor: pointer;
}

.btn:hover {
	background: #0b5ed7;
}

.link {
	font-size: 14px;
	color: #0d6efd;
	text-decoration: none;
}

.link:hover {
	text-decoration: underline;
}

.alert {
	background: #ffe5e5;
	color: #b00020;
	padding: 10px 12px;
	border-radius: 6px;
	margin-bottom: 12px;
	border: 1px solid #ffcaca;
}

.muted {
	color: #666;
	font-size: 13px;
	text-align: center;
	margin-top: 12px;
}

.error {
	color: #b00020;
	font-size: 13px;
	margin-top: 4px;
}

select {
	width: 100%;
	padding: 10px 12px;
	border: 1px solid #ddd;
	border-radius: 6px;
	font-size: 14px;
	background: #fff;
}

select:focus {
	border-color: #0d6efd;
	outline: none;
	box-shadow: 0 0 5px rgba(13, 110, 253, 0.3);
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

</style>
</head>
<body>
	<div class="wrap">
		<h2>Doctor Signup</h2>



		<form autocomplete="off">

			<label>Full Name</label> <input type="text" name="doctorName"
				id="doctorName" required />
			<div class="error" id="error-doctorName"></div>

			<label>Speciality</label> <input type="text" name="speciality"
				id="speciality" required />
			<div class="error" id="error-speciality"></div>

			<label>Phone Number</label> <input type="text" name="phoneNumber"
				id="number" required />
			<div class="error" id="error-phoneNumber"></div>

			<label>City</label> <select name="city" id="city" required>
				<option value="">-- Select City --</option>
				<option value="Mumbai">Mumbai</option>
				<option value="Chennai">Chennai</option>
				<option value="Pune">Pune</option>
				<option value="Bhopal">Bhopal</option>
			</select>
			<div class="error" id="error-city"></div>

			<label>Hospital Name</label> <input type="text" name="hospitalName"
				id="hospitalName" required />
			<div class="error" id="error-hospitalName"></div>

			<label>Start Time</label> <input type="time" name="startTime"
				id="startTime" required />
			<div class="error" id="error-startTime"></div>

			<label>End Time</label> <input type="time" name="endTime"
				id="endTime" required />
			<div class="error" id="error-endTime"></div>

			<label>Email</label> <input type="email" name="email" id="email"
				required />
			<div class="error" id="error-email"></div>

			<label>Password</label> <input type="password" name="password"
				id="password" required />
			<div class="error" id="error-password"></div>

			<!-- If you enable Spring Security CSRF -->
			<c:if test="${not empty _csrf}">
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" />
			</c:if>

			<div class="row">
				<button class="btn" type="submit" id="doctorSignUp">Sign Up</button>
			</div>
		</form>

	</div>
	<div id="successSticker" style="display: none;">Doctor registered successfully! Redirecting to Login</div>
	<script>
	

	//🔹 Helper Functions
	function showError(id, message) {
	    $("#error-" + id).text(message);
	    $("#" + id).css("border-color", "#b00020");
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
	    const val = $("#number").val().trim();
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
	$("#number").on("blur", validatePhoneNumber);
	$("#city").on("blur", validateCity);
	$("#hospitalName").on("blur", validateHospitalName);
	$("#email").on("blur", validateEmail);
	$("#password").on("blur", validatePassword);
	$("#startTime, #endTime").on("blur", validateStartEndTime);
	
	
	$("input, select").on("focus input change", function() {
	    const id = $(this).attr("id");
	    $("#error-" + id).text("");           // Clear the error message
	    $(this).css("border-color", "");     // Reset the border color
	});
	
	
$("#doctorSignUp").click(function(event) {
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

   // if (!isValid) return;
    
    let startTime = $("#startTime").val();
    let endTime = $("#endTime").val();
    startTime = startTime ? startTime : "09:00";
    endTime = endTime ? endTime : "17:00";
   
    $.ajax({
        url: "/SOHAS/doctors/signup",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	doctorName: $("#doctorName").val(),
            speciality: $("#speciality").val(),
            phoneNumber: $("#number").val(),
            city: $("#city").val(),
            hospitalName: $("#hospitalName").val(),
            email: $("#email").val(),
            password: $("#password").val(),
            startTime: $("#startTime").val()+":00",
            endTime: $("#endTime").val()+":00"
        }),
        success: function() {
        	
        	$("#successSticker").fadeIn();

            setTimeout(() => {
                $("#successSticker").fadeOut(() => {
                    window.location.href = "${pageContext.request.contextPath}/login";
                });
            }, 1000); // 1 seconds
            //window.location.href = "${pageContext.request.contextPath}/";
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
        }

    });
});


</script>
</body>
</html>