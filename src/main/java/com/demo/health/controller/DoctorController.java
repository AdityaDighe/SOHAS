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

import com.demo.health.entity.Doctor;
import com.demo.health.service.DoctorService;

@RestController
@RequestMapping ("/doctors")
public class DoctorController {
	
	@Autowired
	private DoctorService doctorService;
	
	@GetMapping("/{id}")
    public Doctor getDoctor(@PathVariable int id) {
        return doctorService.get(id);
    }
	
	@PostMapping
	public ResponseEntity<?> addDoctor(@RequestBody @Valid Doctor doctor, BindingResult result) {
	    if (result.hasErrors()) {
	    	Map<String, List<String>> errors = result.getFieldErrors().stream()
	    		    .collect(Collectors.groupingBy(
	    		        FieldError::getField,
	    		        Collectors.mapping(FieldError::getDefaultMessage, Collectors.toList())
	    		    ));

	        return ResponseEntity.badRequest().body(errors);
	    }

	    doctorService.save(doctor);
	    return ResponseEntity.ok("Doctor added successfully");
	}
	
	@GetMapping
    public List<Doctor> listDoctors() {
        return doctorService.list();
    }

    @PutMapping("/{id}")
    public void updateDoctor(@PathVariable int id, @RequestBody Doctor doctor) {
    	doctor.setDoctorId(id);
        doctorService.update(doctor);
    }
    
    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable int id) {
        doctorService.delete(id);
    }
}
