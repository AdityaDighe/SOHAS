package com.demo.health.controller;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.PatientService;

@RestController
@RequestMapping("/patients")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @PostMapping
    public void addPatient(@RequestBody Patient patient) {
    	patientService.save(patient);
    }

    @GetMapping("/{id}")
    public Patient getPatient(@PathVariable int id) {
        return patientService.get(id);
    }

    @GetMapping
    public List<Patient> listPatient() {
        return patientService.list();
    }

    @PutMapping("/{id}")
    public void updatePatient(@PathVariable int id, @RequestBody Patient patient) {
    	patient.setPatientId(id);
    	patientService.update(patient);
    }

    @DeleteMapping("/{id}")
    public void deletePatient(@PathVariable int id) {
    	patientService.delete(id);
    }
    
    @GetMapping("/doctors")
    public List<Doctor> getDoctors(@RequestParam String location, @RequestParam String time, @RequestParam String date){
    	
    	Time t = Time.valueOf(time);
    	Date d = Date.valueOf(date);
    	
    	return patientService.getDoctors(location, t, d);
    }
}
