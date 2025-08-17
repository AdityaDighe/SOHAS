<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Doctor Profile</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: linear-gradient(180deg, #e6f0ff 0%, #ffffff 100%);
      margin: 0;
    }

    .main-content {
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: calc(100vh - 80px); /* Adjust if header height changes */
      padding-top: 40px;
    }

    .profile-wrapper {
      max-width: 480px;
      background: #fff;
      padding: 28px;
      border-radius: 10px;
      box-shadow: 0 10px 25px rgba(0, 0, 0, .08);
      width: 100%;
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
      font-weight: 600;
      margin-bottom: 6px;
      display: block;
      color: #333;
    }

    input[type="text"],
    input[type="email"],
    input[type="time"],
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

    input:focus,
    select:focus {
      border-color: #0d6efd;
      outline: none;
    }

    .edit-icon {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 16px;
      color: #0d6efd;
      cursor: pointer;
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
      transform: scale(1.10);
    }

    .btn.cancel:hover {
      background: #999;
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
    }
  </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="main-content">
  <div class="profile-wrapper">
    <h2>Doctor Profile</h2>
    <form id="doctorProfileForm" autocomplete="off" novalidate>
      <div class="profile-field">
        <label for="email">Email</label>
        <input type="email" id="email" name="email" disabled value="${doctor.email != null ? doctor.email : ''}" />
      </div>

      <div class="profile-field">
        <label for="doctorName">Full Name</label>
        <input type="text" id="doctorName" name="doctorName" value="${doctor.doctorName}" disabled />
        <span class="edit-icon" data-target="doctorName">&#9998;</span>
        <div class="error" id="error-doctorName"></div>
      </div>

      <div class="profile-field">
        <label for="speciality">Speciality</label>
        <input type="text" id="speciality" name="speciality" value="${doctor.speciality}" disabled />
        <span class="edit-icon" data-target="speciality">&#9998;</span>
        <div class="error" id="error-speciality"></div>
      </div>

      <div class="profile-field">
        <label for="number">Phone Number</label>
        <input type="text" id="number" name="number" value="${doctor.phoneNumber}" disabled />
        <span class="edit-icon" data-target="number">&#9998;</span>
        <div class="error" id="error-phoneNumber"></div>
      </div>

      <div class="profile-field">
        <label for="city">City</label>
        <select id="city" name="city">
          <option value="">-- Select City --</option>
          <option value="Mumbai" ${doctor.city == 'Mumbai' ? 'selected' : ''}>Mumbai</option>
          <option value="Chennai" ${doctor.city == 'Chennai' ? 'selected' : ''}>Chennai</option>
          <option value="Pune" ${doctor.city == 'Pune' ? 'selected' : ''}>Pune</option>
          <option value="Bhopal" ${doctor.city == 'Bhopal' ? 'selected' : ''}>Bhopal</option>
        </select>
        <div class="error" id="error-city"></div>
      </div>

      <div class="profile-field">
        <label for="hospitalName">Hospital Name</label>
        <input type="text" id="hospitalName" name="hospitalName" value="${doctor.hospitalName}" disabled />
        <span class="edit-icon" data-target="hospitalName">&#9998;</span>
        <div class="error" id="error-hospitalName"></div>
      </div>

      <div class="profile-field">
        <label for="startTime">Start Time</label>
        <input type="time" id="startTime" name="startTime" value="${doctor.startTime}" />
        <div class="error" id="error-startTime"></div>
      </div>

      <div class="profile-field">
        <label for="endTime">End Time</label>
        <input type="time" id="endTime" name="endTime" value="${doctor.endTime}" />
        <div class="error" id="error-endTime"></div>
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
  $(document).ready(function () {
    $('.edit-icon').click(function () {
      const target = $(this).data('target');
      const $field = $('#' + target);
      $field.prop('disabled', false).focus();
      $field.one('blur', function () {
        $(this).prop('disabled', true);
      });
    });

    $('#cancelEdit').click(function () {
      $('#doctorName').val("${doctor.doctorName}");
      $('#speciality').val("${doctor.speciality}");
      $('#number').val("${doctor.phoneNumber}");
      $('#city').val("${doctor.city}");
      $('#hospitalName').val("${doctor.hospitalName}");
      $('#startTime').val("${doctor.startTime}");
      $('#endTime').val("${doctor.endTime}");
      $('input, select').prop('disabled', true);
      $('.error').text('');
    });

    $('#doctorProfileForm').submit(function (e) {
      e.preventDefault();
      $('.error').text('');

      const doctorName = $('#doctorName').val().trim();
      const speciality = $('#speciality').val().trim();
      const phoneNumber = $('#number').val().trim();
      const city = $('#city').val();
      const hospitalName = $('#hospitalName').val().trim();
      const startTime = $('#startTime').val() || "09:00:00";
      const endTime = $('#endTime').val() || "17:00:00";

      let hasError = false;

      if (!doctorName) {
        $('#error-doctorName').text('Name is required.');
        hasError = true;
      }

      if (!speciality) {
        $('#error-speciality').text('Speciality is required.');
        hasError = true;
      }

      if (!/^\d{10}$/.test(phoneNumber)) {
        $('#error-phoneNumber').text('Phone number must be 10 digits.');
        hasError = true;
      }

      if (!city) {
        $('#error-city').text('City is required.');
        hasError = true;
      }

      if (!hospitalName) {
        $('#error-hospitalName').text('Hospital name is required.');
        hasError = true;
      }

      if (!startTime || !endTime || endTime <= startTime) {
        $('#error-endTime').text('End time must be after start time.');
        hasError = true;
      }

      if (hasError) return;

      $('input, select, button').prop('disabled', true);

      $.ajax({
        url: '${pageContext.request.contextPath}/doctors/${doctor.doctorId}',
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({
          doctorName: doctorName,
          speciality: speciality,
          phoneNumber: phoneNumber,
          city: city,
          hospitalName: hospitalName,
          email: $("#email").val(),
          password: "${doctor.password}",
          startTime: startTime,
          endTime: endTime
        }),
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
