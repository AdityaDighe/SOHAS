<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Patient Profile</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: "Segoe UI", Arial, sans-serif;
      background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
      margin: 0;
    }

    .main-content {
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding: 50px 20px;
      min-height: calc(100vh - 80px);
    }

    .profile-wrapper {
      width: 100%;
      max-width: 650px;
      background: rgba(255, 255, 255, 0.15);
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      animation: fadeIn 0.5s ease-in-out;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 28px;
      color: #0d6efd;
      text-shadow: 0 0 4px rgba(13, 110, 253, 0.5);
    }

    .grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: 20px;
    }

    @media(min-width: 700px) {
      .grid {
        grid-template-columns: 1fr 1fr;
      }
    }

    .profile-field {
      display: flex;
      flex-direction: column;
      position: relative;
    }

    label {
      font-weight: 600;
      margin-bottom: 6px;
      color: #333;
      font-size: 14px;
    }

    input[type="text"],
    input[type="email"],
    input[type="number"],
    select {
      width: 100%;
      padding: 10px 12px;
      padding-right: 36px; /* for edit icon */
      font-size: 14px;
      border: 1px solid #ddd;
      border-radius: 6px;
      box-sizing: border-box;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    input:focus,
    select:focus {
      border-color: #0d6efd;
      box-shadow: 0 0 5px rgba(13, 110, 253, 0.3);
      outline: none;
    }

    .edit-icon {
      position: absolute;
      right: 10px;
      top: 38px;
      font-size: 16px;
      color: #0d6efd;
      cursor: pointer;
      z-index: 2;
    }

    .error {
      color: #b00020;
      font-size: 12px;
      margin-top: 3px;
      min-height: 1em;
    }

    .btn-row {
      display: flex;
      justify-content: center;
      gap: 15px;
      margin-top: 30px;
    }

    .btn {
      background: #0d6efd;
      color: #fff;
      padding: 12px 22px;
      border: none;
      border-radius: 6px;
      font-size: 15px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn.cancel {
      background: #f1f1f1;
      color: #333;
    }

    .btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(13, 110, 253, 0.25);
    }

    .btn.cancel:hover {
      background: #ddd;
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
      font-size: 15px;
      display: none;
      z-index: 1000;
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    
    .navbar a {
      text-decoration: none !important;
      color: inherit;
    }
  </style>
</head>

<body>
<%@ include file="header.jsp" %>

<div class="main-content">
  <div class="profile-wrapper">
    <h2>Patient Profile</h2>
    <form id="profileForm" autocomplete="off" novalidate>
      <div class="grid">
        <div class="profile-field" style="grid-column: 1 / -1;">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" disabled value="${patient.email != null ? patient.email : ''}" />
        </div>

        <div class="profile-field">
          <label for="fullName">Full Name</label>
          <input type="text" id="fullName" name="fullName" value="${patient.patientName}" disabled />
          <span class="edit-icon" data-target="fullName">&#9998;</span>
          <div class="error" id="error-fullName"></div>
        </div>

        <div class="profile-field">
          <label for="age">Age</label>
          <input type="number" id="age" name="age" value="${patient.age}" disabled />
          <span class="edit-icon" data-target="age">&#9998;</span>
          <div class="error" id="error-age"></div>
        </div>

        <div class="profile-field">
          <label for="city">City</label>
          <select id="city" name="city">
            <option value="">-- Select City --</option>
            <option value="Mumbai" ${patient.city == 'Mumbai' ? 'selected' : ''}>Mumbai</option>
            <option value="Chennai" ${patient.city == 'Chennai' ? 'selected' : ''}>Chennai</option>
            <option value="Pune" ${patient.city == 'Pune' ? 'selected' : ''}>Pune</option>
            <option value="Bhopal" ${patient.city == 'Bhopal' ? 'selected' : ''}>Bhopal</option>
          </select>
          <div class="error" id="error-city"></div>
        </div>
      </div>

      <div class="btn-row">
        <button type="button" class="btn cancel" id="cancelEdit">Cancel</button>
        <button type="submit" class="btn">Save Changes</button>
      </div>
    </form>
  </div>
</div>

<div class="success-toast" id="successToast">Profile updated successfully!</div>

<script>
$(document).ready(function() {
  $('.edit-icon').click(function () {
    const target = $(this).data('target');
    const $field = $('#' + target);
    $field.prop('disabled', false).focus();
    $field.one('blur', function () {
      $(this).prop('disabled', true);
    });
  });

  $('#cancelEdit').click(function () {
    $('#fullName').val("${patient.patientName}");
    $('#age').val("${patient.age}");
    $('#city').val("${patient.city}");
    $('.error').text('');
  });
  function getCookie(name) {
      let match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
      return match ? match[2] : null;
  }
	
	let tokenFromCookie = getCookie("jwtToken");
  $('#profileForm').submit(function (e) {
    e.preventDefault();
    $('.error').text('');

    const fullName = $('#fullName').val().trim();
    const age = $('#age').val();
    const city = $('#city').val();

    let hasError = false;
    if (!fullName) { $('#error-fullName').text('Full Name is required.'); hasError = true; }
    if (!age || age < 0 || age > 120) { $('#error-age').text('Age must be 0-120.'); hasError = true; }
    if (!city) { $('#error-city').text('City is required.'); hasError = true; }
    if (hasError) return;

    $('input, select, button').prop('disabled', true);

    $.ajax({
      url: '${pageContext.request.contextPath}/patients/${patient.patientId}',
      method: 'PUT',
      contentType: 'application/json',
      data: JSON.stringify({
        patientName: fullName,
        age: parseInt(age),
        city: city,
        email: $("#email").val(),
        password: "${patient.password}"
      }),
      headers: {
          "Authorization": "Bearer " + tokenFromCookie
      },
      success: function () {
        $('#successToast').fadeIn().delay(1500).fadeOut();
        $('input, select').prop('disabled', true);
        $('button').prop('disabled', false);
      },
      error: function () {
        alert('Update failed.');
        $('input, select, button').prop('disabled', false);
      }
    });
  });
});
</script>
</body>
</html>
