package com.demo.health.service.impl;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import com.demo.health.dao.PatientDAO;
import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.exception.UserNotFoundException;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	private PatientDAO patientdao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	private DoctorService doctorService;

	@Override
	@Transactional
	public ResponseEntity<?> registerPatient(@Valid PatientDTO patientDTO, BindingResult result) {
		// TODO Auto-generated method stub
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
        if (findByEmail(patientDTO.getEmail()) != null || 
            doctorService.findByEmail(patientDTO.getEmail()) != null) {
            return ResponseEntity.badRequest()
                    .body(Map.of("email", "Email already registered"));
        }

        //Encrypt password before saving
        patientDTO.setPassword(passwordEncoder.encode(patientDTO.getPassword()));

		Patient patient = new Patient(patientDTO);
		patientdao.save(patient);
		
		return ResponseEntity.ok("Patient added successfully");
		
	}

	@Override
	@Transactional
	public PatientDTO getPatientById(int patientId) {
		// TODO Auto-generated method stub
		Patient patient = patientdao.get(patientId);
		return patient != null ? new PatientDTO(patient) : null;
	}
	
	@Override
	@Transactional
	public List<PatientDTO> listPatients() {
		// TODO Auto-generated method stub
		List<Patient> patientList =  patientdao.list();
		List<PatientDTO> patientDTOlist = new ArrayList<>();
		for(Patient p: patientList) {
			patientDTOlist.add(new PatientDTO(p));
		}
		return patientList != null ? patientDTOlist : null;
	}

	@Override
	@Transactional
	public void updatePatient(int id, PatientDTO patientDTO) {
		// TODO Auto-generated method stub
		Patient patient = new Patient(patientDTO);
		patient.setPatientId(id);
		patientdao.update(patient);
	}

	@Override
	@Transactional
	public void deletePatient(int patientId) {
		// TODO Auto-generated method stub
		patientdao.delete(patientId);

	}

	@Override
	@Transactional
	public ResponseEntity<?> getAvailableDoctors(String location, Time time, Date date) {
		// TODO Auto-generated method stub
		List<Doctor> doctorList = patientdao.getDoctors(location, time, date);
		//Handling DoctorsNotFoundException and sending custom message
        if (doctorList.isEmpty()) {
            throw new UserNotFoundException("No doctors available for the selected city and time.");
        }
        
		List<DoctorDTO> doctorDTOlist = new ArrayList<>();
		for(Doctor d : doctorList) {
			doctorDTOlist.add(new DoctorDTO(d));
		}
		
		Map<String, Object> response = new HashMap<>();
	    response.put("status", "success");
	    response.put("data", doctorDTOlist);
	    
	    return ResponseEntity.ok(response);
		
	}

	@Override
	@Transactional
	public PatientDTO findByEmail(String email) {
		Patient patient = patientdao.findByEmail(email);
		return patient != null ? new PatientDTO(patient) : null;
	}

	@Override
	@Transactional
	public List<DashboardDTO> getPatientAppointments(int id) {
		// TODO Auto-generated method stub
		List<Appointment> appointmentList =  patientdao.getAppointment(id);
		List<DashboardDTO> appointmentDTOlist = new ArrayList<>();
		for(Appointment app : appointmentList) {
			appointmentDTOlist.add(new DashboardDTO(app));
		}
		
		return appointmentList != null ? appointmentDTOlist : null;
	}

	

}
