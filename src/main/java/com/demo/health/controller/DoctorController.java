package com.demo.health.controller;

import java.util.List;

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
	public ResponseEntity<?> addDoctor(@RequestBody DoctorDTO doctorDTO, BindingResult result) {
	    return doctorService.save(doctorDTO, result);
	   
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
