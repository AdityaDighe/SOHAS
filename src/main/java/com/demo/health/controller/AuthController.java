package com.demo.health.controller;
 
import java.util.Map;

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
        	String token = JwtUtil.generateToken(p.getPatientId(), p.getPatientName());
            return ResponseEntity.ok("{\"token\":\"" + token + "\", \"role\":\"patientDashboard\"}"); // send only keyword
        }
 
        Doctor d = doctorService.loginDoctor(email, pass);
        if (d != null) {
        	String token = JwtUtil.generateToken(d.getDoctorId(), d.getDoctorName());
        	return ResponseEntity.ok("{\"token\":\"" + token + "\", \"role\":\"doctorDashboard\"}"); // send only keyword
        }
 
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("{\"error\":\"Invalid credentials\"}");
    }
}
