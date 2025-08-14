package com.demo.health.controller;
 
import java.util.Map;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
 
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;
 
@RestController
public class AuthController {
 
    @Autowired
    private PatientService patientService;
 
    @Autowired
    private DoctorService doctorService;
 
    @PostMapping("/login")
    public String doLogin(@RequestBody Map<String, String> credentials) {
        String email = credentials.get("email");
        String pass = credentials.get("password");
 
        Patient p = patientService.loginPatient(email, pass);
        if (p != null) {
            return "patientDashboard"; // send only keyword
        }
 
        Doctor d = doctorService.loginDoctor(email, pass);
        if (d != null) {
            return "doctorDashboard"; // send only keyword
        }
 
        return "error";
    }
}
