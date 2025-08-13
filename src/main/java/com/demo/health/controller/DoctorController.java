package com.demo.health.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
    public void addDepartment(@RequestBody Doctor doctor) {
        doctorService.save(doctor);
    }
	
	@GetMapping
    public List<Doctor> listDoctors() {
        return doctorService.list();
    }

    @PutMapping("/{id}")
    public void updateDepartment(@PathVariable int id, @RequestBody Doctor doctor) {
    	doctor.setDoctorId(id);
        doctorService.update(doctor);
    }
    
    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable int id) {
        doctorService.delete(id);
    }
}
