package com.demo.health.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
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

/*
 REST controller for handling doctor-related operations such as registration,
 profile management, and viewing appointments.
 */
@RestController
@RequestMapping ("/doctors")
public class DoctorController {
	
	@Autowired
	private DoctorService doctorService;
	
	@GetMapping("/{id}")
    public DoctorDTO getDoctorById(@PathVariable int id) {
        return doctorService.getDoctorById(id);
    }
	
	/*
     Registers a new doctor.
    */
	@PostMapping("/signup")
	public ResponseEntity<?> registerDoctor(@RequestBody @Valid DoctorDTO doctorDTO) {
	    return doctorService.registerDoctor(doctorDTO);
	   
	}

    @PutMapping("/{id}")
    public void updateDoctor(@PathVariable int id, @RequestBody @Valid DoctorDTO doctorDTO) {
        doctorService.updateDoctor(id, doctorDTO);
    }
    
    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable int id) {
        doctorService.deleteDoctor(id);
    }
    
    @GetMapping("/appointment/{id}")
    public List<DashboardDTO> myAppointments(@PathVariable int id){
    	return doctorService.myAppointments(id);
    }
}
