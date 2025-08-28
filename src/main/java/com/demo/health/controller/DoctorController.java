package com.demo.health.controller;

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
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;

/*
 REST controller for handling doctor-related operations such as registration,
 profile management, and viewing appointments.
 */
@RestController
@RequestMapping ("/doctors")
public class DoctorController {
	
	@Autowired
	private DoctorService doctorService;
	
	@Autowired
	private PatientService patientService;
	
	@GetMapping("/{id}")
    public DoctorDTO getDoctor(@PathVariable int id) {
        return doctorService.get(id);
    }
	
	/*
     Registers a new doctor.
    */
	@PostMapping("/signup")
	public ResponseEntity<?> addDoctor(@RequestBody @Valid DoctorDTO doctorDTO, BindingResult result) {
		
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
	    
	    // Check if start and end time are provided & end time comes after start time
	    if (doctorDTO.getEndTime() != null && doctorDTO.getStartTime() != null &&
	            !doctorDTO.getEndTime().after(doctorDTO.getStartTime())) {
	        return ResponseEntity.badRequest()
	                .body(Map.of("endTime", "End time must be after start time"));
	    }
	    
	    // Check if the email is unique or not across Doctor & Patient Tables
	    if (patientService.findByEmail(doctorDTO.getEmail()) != null || 
	        doctorService.findByEmail(doctorDTO.getEmail()) != null) {
	        return ResponseEntity.badRequest()
	                .body(Map.of("email", "Email already registered"));
	    }

	    // Encrypt password before saving
	    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	    doctorDTO.setPassword(encoder.encode(doctorDTO.getPassword()));

	    doctorService.save(doctorDTO);
	    return ResponseEntity.ok("Doctor added successfully");
	}

    @PutMapping("/{id}")
    public void updateDoctor(@PathVariable int id, @RequestBody DoctorDTO doctorDTO) {
        doctorService.update(id, doctorDTO);
    }
    
    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable int id) {
        doctorService.delete(id);
    }
    
    @GetMapping("/appointment/{id}")
    public List<DashboardDTO> myAppointments(@PathVariable int id){
    	return doctorService.myAppointments(id);
    }
}
