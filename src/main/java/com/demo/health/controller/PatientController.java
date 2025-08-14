package com.demo.health.controller;

import java.sql.Date;
import java.sql.Time;
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
import com.demo.health.entity.Patient;
import com.demo.health.service.PatientService;

@RestController
@RequestMapping("/patients")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @PostMapping
    public ResponseEntity<?> addPatient(@RequestBody @Valid Patient patient, BindingResult result) {
        if (result.hasErrors()) {
            Map<String, List<String>> errors = result.getFieldErrors().stream()
                .collect(Collectors.groupingBy(
                    FieldError::getField,
                    Collectors.mapping(FieldError::getDefaultMessage, Collectors.toList())
                ));

            return ResponseEntity.badRequest().body(errors);
        }

        patientService.save(patient);
        return ResponseEntity.ok("Patient added successfully");
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
    public List<Doctor> getDoctors(@RequestBody Map<String, String> requirement){
    	String location = requirement.get("location");
    	String stime = requirement.get("time");
    	String sdate = requirement.get("date");
    	Time time = Time.valueOf(stime);
    	Date date = Date.valueOf(sdate);
    	
    	return patientService.getDoctors(location, time, date);
    }
}
