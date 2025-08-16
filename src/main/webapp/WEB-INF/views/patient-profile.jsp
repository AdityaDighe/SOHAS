<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Patient Profile</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f5f7fb;
      margin: 0;
      display: flex; 
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    .profile-wrapper {
      width: 100%;
      max-width: 400px;
      background: #fff;
      padding: 28px;
      border-radius: 10px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
      position: relative;
    }
    h2 {
      text-align: center;
      margin-bottom: 24px;
    }
    .profile-field {
      margin-bottom: 16px;
      position: relative;
    }
    label {
      display: block;
      font-weight: 600;
      margin-bottom: 6px;
      color: #333;
    }
    input[type="text"], 
    input[type="number"], 
    select {
      width: 100%;
      padding: 8px 10px;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 6px;
      height: 36px;
      box-sizing: border-box;
      transition: border-color 0.3s ease;
    }
    input[type="text"]:focus,
    input[type="number"]:focus,
    select:focus {
      border-color: #0d6efd;
      outline: none;
    }
    .edit-icon {
  position: absolute;
  right: 10px;
  top: 50%; /* Change this */
  transform: translateY(-50%); /* Add this */
  font-size: 16px;
  color: #0d6efd;
  cursor: pointer;
}

select {
  -webkit-appearance: none;  /* For Chrome, Safari, Opera */
  -moz-appearance: none;     /* For Firefox */
  appearance: none;          /* For modern browsers */
  background-image: none;    /* Remove any default background images */
  padding-right: 10px;       /* Adjust padding to avoid clipped text */
}

    .error {
      color: #b00020;
      font-size: 13px;
      margin-top: 4px;
      min-height: 1em;
    }
    .btn-row {
      text-align: center;
      margin-top: 24px;
    }
    .btn {
      background: #0d6efd;
      color: white;
      padding: 10px 18px;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      cursor: pointer;
      margin-right: 10px;
      transition: background-color 0.3s ease;
    }
    .btn.cancel {
      background: #ccc;
      color: #000;
    }
    .btn:hover {
      background: #0b5ed7;
      transform: scale(1.10);
      transition: transform 0.2s ease;
    }
    .btn.cancel:hover {
      background: #999;
      transform: scale(1.10);
   	  transition: transform 0.2s ease;
    }
    .success-toast {
      position: fixed;
      bottom: 30px;
      left: 50%;
      transform: translateX(-50%);
      background-color: #4BB543;
      color: white;
      padding: 12px 24px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      font-size: 15px;
      display: none;
      z-index: 1000;
    }
  </style>
</head>
<body>

<div class="profile-wrapper">
  <h2>Patient Profile</h2>
  <form id="profileForm" autocomplete="off" novalidate>
	<div class="profile-field">
  		<label for="email">Email</label>
  		<input type="text" id="email" name="email" disabled 
         value="${patient.email != null ? patient.email : ''}" />
	</div>
		  
    <div class="profile-field">
      <label for="fullName">Full Name</label>
      <input type="text" id="fullName" name="fullName" required
             value="${patient.patientName != null ? patient.patientName : ''}" disabled />
      <span class="edit-icon" data-target="fullName">&#9998;</span>
      <div class="error" id="error-fullName"></div>
    </div>

    <div class="profile-field">
      <label for="age">Age</label>
      <input type="text" id="age" name="age" required
             value="${patient.age != null ? patient.age : ''}" disabled />
      <span class="edit-icon" data-target="age">&#9998;</span>
      <div class="error" id="error-age"></div>
    </div>

    <div class="profile-field">
      <label for="city">Select City</label>
      <input type="text" id="city" name="city" required disabled />
      <span class="edit-icon" data-target="city">&#9998;</span>
      <div class="error" id="error-city"></div>
    </div>

    <div class="btn-row">
      <button type="button" class="btn cancel" id="cancelEdit">Cancel</button>
      <button type="submit" class="btn">Save Changes</button>
    </div>
  </form>
</div>

<div class="success-toast" id="successToast">Updated successfully!</div>

<script>
  $(document).ready(function () {
    // Initially inputs are disabled (set by JSP)

    $('.edit-icon').click(function () {
  const target = $(this).data('target');
  const $field = $('#' + target);
  $field.prop('disabled', false).focus();

  // On blur, disable the field again
  $field.one('blur', function () {
    $(this).prop('disabled', true);
  });
});

    // Cancel button resets form and disables inputs
    $('#cancelEdit').click(function () {
      // Reset inputs to original server-rendered values
      $('#fullName').val("${patient.patientName != null ? patient.patientName : ''}");
      $('#age').val("${patient.age != null ? patient.age : ''}");
      $('#city').val("${patient.city != null ? patient.city : ''}");

      $('.error').text('');
      $('input, select').prop('disabled', true);
    });

    // Validate and submit form via AJAX
    $('#profileForm').submit(function (e) {
      e.preventDefault();
      $('.error').text('');

      const fullName = $('#fullName').val().trim();
      const age = $('#age').val();
      const city = $('#city').val();

      let hasError = false;

      if (!fullName) {
        $('#error-fullName').text('Full Name is required.');
        hasError = true;
      }
      if (!age || age < 0 || age > 120) {
        $('#error-age').text('Age must be between 0 and 120.');
        hasError = true;
      }
      if (!city) {
        $('#error-city').text('Please select a city.');
        hasError = true;
      }
      if (hasError) return;

      $('input, select, button').prop('disabled', true);

      $.ajax({
        url: '${pageContext.request.contextPath}/patients/${patient.patientId}',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({ 
        		patientName: $("#fullName").val(),
            	age: parseInt($("#age").val()),
            	city: $("#city").val(),
            	email: $("#email").val(),
            	password: "${patient.password}"
        	}),
        success: function () {
          showToast();
          // Disable inputs again after save
          $('input, select').prop('disabled', true);
          $('button').prop('disabled', false);
        },
        error: function () {
          alert('Update failed.');
          $('input, select, button').prop('disabled', false);
        }
      });
    });

    function showToast() {
      $('#successToast').fadeIn().delay(1500).fadeOut();
    }
  });
</script>


</body>
</html>
