package com.demo.health.controller;
 
import java.sql.Date;
import java.sql.Time;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;
import com.demo.health.exception.UserNotFoundException;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;


/*
REST controller for handling patient-related operations such as registration,
profile management, and viewing appointments.
*/
@RestController
@RequestMapping("/patients")
public class PatientController {
 
    @Autowired
    private PatientService patientService;
    
    @Autowired
    private DoctorService doctorService;
    
    /*
     Registers a new patient 
     */
    @PostMapping("/signup")
    public ResponseEntity<?> addPatient(@RequestBody @Valid PatientDTO patientDTO, BindingResult result) {
    	
    	//Check for validation errors and return
        if (result.hasErrors()) {
            Map<String, String> errors = result.getFieldErrors().stream()
                .collect(Collectors.toMap(
                    FieldError::getField,
                    FieldError::getDefaultMessage,
                    (existing, replacement) -> existing
                ));
            return ResponseEntity.badRequest().body(errors);
        }

        // Check if the email is unique or not across Doctor & Patient Tables
        if (patientService.findByEmail(patientDTO.getEmail()) != null || 
            doctorService.findByEmail(patientDTO.getEmail()) != null) {
            return ResponseEntity.badRequest()
                    .body(Map.of("email", "Email already registered"));
        }

        //Encrypt password before saving
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        patientDTO.setPassword(encoder.encode(patientDTO.getPassword()));

        patientService.save(patientDTO);
        return ResponseEntity.ok("Patient added successfully");
    
//        return ResponseEntity.ok(patientService.save(patientDTO));
    }


 
 
    @GetMapping("/{id}")
    public PatientDTO getPatient(@PathVariable int id) {
//        return patientService.get(id);
    	return patientService.get(id);
    }
 
    @PutMapping("/{id}")
    public void updatePatient(@PathVariable int id, @RequestBody PatientDTO patientDTO) {
//    	patient.setPatientId(id);
//    	patientService.update(patient);
    	patientService.update(id, patientDTO);
    }
 
    @DeleteMapping("/{id}")
    public void deletePatient(@PathVariable int id) {
    	patientService.delete(id);
    }
    
    //getting all the doctors list based on parameters
    @GetMapping("/doctors")
    public ResponseEntity<?> getDoctors(@RequestParam String location, @RequestParam String time, @RequestParam String date) {
        Time t = Time.valueOf(time);
        Date d = Date.valueOf(date);
 
        List<DoctorDTO> doctorDTO = patientService.getDoctors(location, t, d);
        
        //Handling DoctorsNotFoundException and sending custom message
        if (doctorDTO.isEmpty()) {
            throw new UserNotFoundException("No doctors available for the selected city and time.");
        }
 
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("data", doctorDTO);
 
        return ResponseEntity.ok(response);
    }
    
    @GetMapping("/appointment/{id}")
    public List<DashboardDTO> getAppointment(@PathVariable int id){
    	return patientService.getAppointment(id);
    }
    
}