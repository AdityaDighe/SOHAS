package com.demo.health.service.impl;

import java.time.LocalDateTime;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.LoginDTO;
import com.demo.health.dto.PatientDTO;
import com.demo.health.security.CustomUserDetails;
import com.demo.health.service.AuthService;
import com.demo.health.service.DoctorService;
import com.demo.health.service.EmailService;
import com.demo.health.service.PatientService;
import com.demo.health.util.JwtUtil;
import com.demo.health.util.OtpUtil;

@Service
@Transactional
public class AuthServiceImpl implements AuthService{
	 @Autowired
	 private AuthenticationManager authenticationManager;
	 
	 @Autowired
	 private PatientService patientService;

	 @Autowired
	 private DoctorService doctorService;

	 @Autowired
	 private EmailService emailService;
	
	@Override
	public ResponseEntity<?> doLogin(LoginDTO loginDTO) {
		// TODO Auto-generated method stub
		String email = loginDTO.getEmail();
	   	String rawPassword = loginDTO.getPassword();
	   	 
	   	Authentication auth = authenticationManager.authenticate(
	   		        new UsernamePasswordAuthenticationToken(email, rawPassword)
	   	);
	   	CustomUserDetails user = (CustomUserDetails) auth.getPrincipal();
	   	
	   	String token = JwtUtil.generateToken(user.getId(), user.getUsername(), 
	   											user.getAuthorities().iterator().next().getAuthority());
	   	
	   	return ResponseEntity.ok(Map.of("token", token));
	}

	@Override
	public ResponseEntity<?> logout(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    	
    	Cookie cookie = new Cookie("jwtToken", null);
        cookie.setHttpOnly(true);
        cookie.setSecure(false);   // set true if using HTTPS
        cookie.setPath("/");
        cookie.setMaxAge(0);
        
        response.addCookie(cookie);
        
        return ResponseEntity.ok(Map.of("message", "Logout Successfully!!!"));
	}

	@Override
	public ResponseEntity<?> requestOtp(String email) {
		// TODO Auto-generated method stub
		PatientDTO patientDTO = patientService.findByEmail(email);
        DoctorDTO doctorDTO = doctorService.findByEmail(email);
        
        //Check if patient or doctor exists
        if (patientDTO == null && doctorDTO == null) {
            return ResponseEntity.status(404).body(Map.of("message", "Email not found"));
        }

        //OTP generator to give random 6 digits
        String otp = OtpUtil.generateOtp(); 
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(5);
      
        //Checking if patient or doctor and setting password
        if (patientDTO != null) {
            patientDTO.setOtp(otp);
            patientDTO.setOtpExpiry(expiry);
            patientService.update(patientDTO.getPatientId(), patientDTO);
        } else {
            doctorDTO.setOtp(otp);
            doctorDTO.setOtpExpiry(expiry);
            doctorService.update(doctorDTO.getDoctorId(), doctorDTO);
        }

        //Sending email, and sending response of success or failure
        try {
            emailService.sendOtpEmail(email, otp); 
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "Failed to send OTP"));
        }

        return ResponseEntity.ok(Map.of("message", "OTP sent successfully"));
	}

	
	@Override
	public ResponseEntity<?> resetPassword(String email, String newPassword, String otp) {
		// TODO Auto-generated method stub
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        try {
            PatientDTO patient = patientService.findByEmail(email);
            DoctorDTO doctor = doctorService.findByEmail(email);
            //Try updating patient password
            if (patient != null) {
                System.out.println("DEBUG => Patient OTP: " + patient.getOtp() + ", Expiry: " + patient.getOtpExpiry());
            }
            if (doctor != null) {
                System.out.println("DEBUG => Doctor OTP: " + doctor.getOtp() + ", Expiry: " + doctor.getOtpExpiry());
            }

            boolean updated = false;

            //Check for patient entity requesting for reset password
            if (patient != null && patient.getOtp() != null &&
                patient.getOtp().equals(otp) &&
                patient.getOtpExpiry() != null &&
                patient.getOtpExpiry().isAfter(LocalDateTime.now())) {

            	patient.setPassword(passwordEncoder.encode(newPassword));
                patient.setOtp(null);
                patient.setOtpExpiry(null);
                patientService.update(patient.getPatientId(), patient);
                updated = true;
            }
            
            //Check for doctor entity requesting for reset password
            if (doctor != null && doctor.getOtp() != null &&
                doctor.getOtp().equals(otp) &&
                doctor.getOtpExpiry() != null &&
                doctor.getOtpExpiry().isAfter(LocalDateTime.now())) {

            	doctor.setPassword(passwordEncoder.encode(newPassword)); 
                doctor.setOtp(null);
                doctor.setOtpExpiry(null);
                doctorService.update(doctor.getDoctorId(), doctor);
                updated = true;
            }
            
            //Return if successful or not
            if (updated) {
                return ResponseEntity.ok(Map.of("message", "Password updated successfully"));
            } else {
                return ResponseEntity.status(400).body(Map.of("message", "Invalid OTP or expired"));
            }

        } catch (Exception e) {
            e.printStackTrace(); //print full error in console
            return ResponseEntity.status(500).body(Map.of("message", "Server error: " + e.getMessage()));
        }
	}

}
