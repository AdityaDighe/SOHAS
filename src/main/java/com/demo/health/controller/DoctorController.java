package com.demo.health.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;

@RestController
@RequestMapping ("/doctors")
public class DoctorController {
	
	@Autowired
	private DoctorService doctorService;
	
	@Autowired
	private PatientService patientService;
	
	@GetMapping("/{id}")
    public Doctor getDoctor(@PathVariable int id) {
        return doctorService.get(id);
    }
	
//	@PostMapping("/signup")
//	public ResponseEntity<?> addDoctor(@RequestBody @Valid Doctor doctor, BindingResult result) {
//	    if (result.hasErrors()) {
//	        // Only one message per field (the first one)
//	        Map<String, String> errors = result.getFieldErrors().stream()
//	            .collect(Collectors.toMap(
//	                FieldError::getField,
//	                FieldError::getDefaultMessage,
//	                (existing, replacement) -> existing // keep first message
//	            ));
//
//	        return ResponseEntity.badRequest().body(errors);
//	    }
//
//	    // Custom validation: End time after start time
//	    if (doctor.getEndTime() != null && doctor.getStartTime() != null &&
//	            !doctor.getEndTime().after(doctor.getStartTime())) {
//
//	        return ResponseEntity.badRequest()
//	                .body(Map.of("endTime", "End time must be after start time"));
//	    }
//
//	    // Custom validation: Email already exists
//	    if (patientService.findByEmail(doctor.getEmail()) != null) {
//	        return ResponseEntity.badRequest()
//	                .body(Map.of("email", "Email already registered"));
//	    }
//	    
//	    if (doctorService.findByEmail(doctor.getEmail()) != null) {
//	        return ResponseEntity.badRequest()
//	                .body(Map.of("email", "Email already registered"));
//	    }
//
//	    doctorService.save(doctor);
//	    return ResponseEntity.ok("Doctor added successfully");
//	}

	@PostMapping("/signup")
	public ResponseEntity<?> addDoctor(@RequestBody @Valid Doctor doctor, BindingResult result) {
	    if (result.hasErrors()) {
	        Map<String, String> errors = result.getFieldErrors().stream()
	            .collect(Collectors.toMap(
	                FieldError::getField,
	                FieldError::getDefaultMessage,
	                (existing, replacement) -> existing
	            ));
	        return ResponseEntity.badRequest().body(errors);
	    }

	    if (doctor.getEndTime() != null && doctor.getStartTime() != null &&
	            !doctor.getEndTime().after(doctor.getStartTime())) {
	        return ResponseEntity.badRequest()
	                .body(Map.of("endTime", "End time must be after start time"));
	    }

	    if (patientService.findByEmail(doctor.getEmail()) != null || 
	        doctorService.findByEmail(doctor.getEmail()) != null) {
	        return ResponseEntity.badRequest()
	                .body(Map.of("email", "Email already registered"));
	    }

	    // 🔑 Encrypt password before saving
	    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	    doctor.setPassword(encoder.encode(doctor.getPassword()));

	    doctorService.save(doctor);
	    return ResponseEntity.ok("Doctor added successfully");
	}
	
//	@GetMapping
//    public List<Doctor> listDoctors() {
//        return doctorService.list();
//    }

    @PutMapping("/{id}")
    public void updateDoctor(@PathVariable int id, @RequestBody Doctor doctor) {
    	doctor.setDoctorId(id);
        doctorService.update(doctor);
    }
    
    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable int id) {
        doctorService.delete(id);
    }
    
    @GetMapping("/appointment/{id}")
    public List<Appointment> myAppointments(@PathVariable int id){
    	return doctorService.myAppointments(id);
    }
}
