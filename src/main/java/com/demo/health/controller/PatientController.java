package com.demo.health.controller;
 
import java.sql.Date;
import java.sql.Time;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.PatientDTO;
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

    /*
     Registers a new patient 
     */
    @PostMapping("/signup")
    public ResponseEntity<?> addPatient(@RequestBody PatientDTO patientDTO, BindingResult result) {
        return patientService.save(patientDTO, result);
    }

    @GetMapping("/{id}")
    public PatientDTO getPatient(@PathVariable int id) {
    	return patientService.get(id);
    }
 
    @PutMapping("/{id}")
    public void updatePatient(@PathVariable int id, @RequestBody PatientDTO patientDTO) {
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
 
        return patientService.getDoctors(location, t, d);        
    }
    
    @GetMapping("/appointment/{id}")
    public List<DashboardDTO> getAppointment(@PathVariable int id){
    	return patientService.getAppointment(id);
    }
    
}