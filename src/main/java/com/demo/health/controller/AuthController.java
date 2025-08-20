package com.demo.health.controller;

import java.time.LocalDateTime;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.DoctorService;
import com.demo.health.service.EmailService;
import com.demo.health.service.PatientService;
import com.demo.health.util.JwtUtil;
import com.demo.health.util.OtpUtil;


/*
Authentication controller used for authorization and authentication purposes
*/
@RestController
public class AuthController {

    @Autowired
    private PatientService patientService;

    @Autowired
    private DoctorService doctorService;
    

    @Autowired
    private EmailService emailService;

   

    //Login with BCrypt, single API for both Patient and Doctor entities
    @PostMapping(value = "/api/login", produces = "application/json")
    public ResponseEntity<?> doLogin(@RequestBody Map<String, String> credentials) {
        String email = credentials.get("email");
        String rawPassword = credentials.get("password");
        
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        // Check patient and check if password encoded matches, return token
        Patient p = patientService.findByEmail(email);
        if (p != null && passwordEncoder.matches(rawPassword, p.getPassword())) {
            String token = JwtUtil.generateToken(p.getPatientId(), email, "PATIENT");
            return ResponseEntity.ok(Map.of("token", token));
        }

        // Check doctor and check if password encoded matches, return token
        Doctor d = doctorService.findByEmail(email);
        if (d != null && passwordEncoder.matches(rawPassword, d.getPassword())) {
            String token = JwtUtil.generateToken(d.getDoctorId(), email, "DOCTOR");
            return ResponseEntity.ok(Map.of("token", token));
        }
        
        //Unauthorized access (wrong password or email)
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(Map.of("error", "Invalid credentials"));
    }


    //Logout, entering null cookie and removing jwtToken
    @PostMapping("/api/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
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

        return "Logged out successfully!";
    }
    

    //OTP request to change password
    @PostMapping("/api/request-otp")
    public ResponseEntity<?> requestOtp(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");

        Patient patient = patientService.findByEmail(email);
        Doctor doctor = doctorService.findByEmail(email);
        
        //Check if patient or doctor exists
        if (patient == null && doctor == null) {
            return ResponseEntity.status(404).body(Map.of("message", "Email not found"));
        }

        //OTP generator to give random 6 digits
        String otp = OtpUtil.generateOtp(); 
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(5);
      
        //Checking if patient or doctor and setting password
        if (patient != null) {
            patient.setOtp(otp);
            patient.setOtpExpiry(expiry);
            patientService.update(patient);
        } else {
            doctor.setOtp(otp);
            doctor.setOtpExpiry(expiry);
            doctorService.update(doctor);
        }

      //Sending email, and sending response of success or failure
        try {
            emailService.sendOtpEmail(email, otp); 
        } catch (Exception e) {
            return ResponseEntity.status(500).body(Map.of("message", "Failed to send OTP"));
        }

        return ResponseEntity.ok(Map.of("message", "OTP sent successfully"));
    }

    //Forget password with BCrypt, single API for both doctor and patient
    @PostMapping("/api/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        String otp = payload.get("otp");
        String newPassword = payload.get("newPassword");

        System.out.println("DEBUG => email: " + email + ", otp: " + otp);
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        try {
            Patient patient = patientService.findByEmail(email);
            Doctor doctor = doctorService.findByEmail(email);
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
                patientService.update(patient);
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
                doctorService.update(doctor);
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
