package com.demo.health.controller;
 
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;
import com.demo.health.util.JwtUtil;
 
@RestController
public class AuthController {
 
    @Autowired
    private PatientService patientService;
 
    @Autowired
    private DoctorService doctorService;
 
    @PostMapping(value = "/api/login", produces = "application/json")
    public ResponseEntity<?> doLogin(@RequestBody Map<String, String> credentials) {
        String email = credentials.get("email");
        String pass = credentials.get("password");
 
        Patient p = patientService.loginPatient(email, pass);
        if (p != null) {
        	String token = JwtUtil.generateToken(p.getPatientId(), p.getPatientName(), "PATIENT");
        	return ResponseEntity.ok("{\"token\":\"" + token + "\"}");// send only keyword
        }
 
        Doctor d = doctorService.loginDoctor(email, pass);
        if (d != null) {
        	String token = JwtUtil.generateToken(d.getDoctorId(), d.getDoctorName(), "DOCTOR");
        	return ResponseEntity.ok("{\"token\":\"" + token + "\"}"); // send only keyword
        }
 
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("{\"error\":\"Invalid credentials\"}");
    }
    
    
    
    @PostMapping("/api/forgot-password")
    public ResponseEntity<?> forgotPassword(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        String newPassword = payload.get("newPassword");

        boolean updated = false;

        // Try updating patient password
        Patient patient = patientService.findByEmail(email);
        if (patient != null) {
            patient.setPassword(newPassword);
            patientService.update(patient);
            updated = true;
        }

        // Try updating doctor password
        Doctor doctor = doctorService.findByEmail(email);
        if (doctor != null) {
            doctor.setPassword(newPassword);
            doctorService.update(doctor);
            updated = true;
        }

        if (updated) {
            return ResponseEntity.ok(Map.of("message", "Password updated successfully"));
        } else {
            return ResponseEntity.status(404).body(Map.of("message", "Email not found"));
        }
    }
    
    
    @PostMapping("/api/logout")
    public String logout(HttpServletResponse response) {
        // Create a cookie with the same name as your JWT cookie
        Cookie cookie = new Cookie("jwtToken", null);
        cookie.setHttpOnly(true);      // prevent access from JS
        cookie.setSecure(false);       // set true if using HTTPS
        cookie.setPath("/");           // must match the original cookie path
        cookie.setMaxAge(0);           // expire immediately

        // Add cookie to response to remove it from browser
        response.addCookie(cookie);

        return "Logged out successfully!";
    }

}
