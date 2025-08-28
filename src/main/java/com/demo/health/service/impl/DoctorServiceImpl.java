package com.demo.health.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;

import com.demo.health.dao.DoctorDAO;
import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.exception.UserNotFoundException;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;

@Service
public class DoctorServiceImpl implements DoctorService {
	@Autowired
	private DoctorDAO doctorDAO;
	
	@Autowired
	private PatientService patientService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder; 

	@Override
	public ResponseEntity<?> registerDoctor(@Valid DoctorDTO doctorDTO, BindingResult result) {
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
	        findByEmail(doctorDTO.getEmail()) != null) {
	        return ResponseEntity.badRequest()
	                .body(Map.of("email", "Email already registered"));
	    }

	    // Encrypt password before saving
	    doctorDTO.setPassword(passwordEncoder.encode(doctorDTO.getPassword()));
		
	    Doctor doctor = new Doctor(doctorDTO);
		doctorDAO.addDoctor(doctor);
		
		return ResponseEntity.ok("Doctor added successfully");
	}

	@Override
	public DoctorDTO getDoctorById(int doctorId) throws UserNotFoundException {
		Doctor doctor = doctorDAO.getDoctorById(doctorId);
		DoctorDTO doctorDTO = new DoctorDTO(doctor);
		return doctor != null ? doctorDTO : null;
	}

	@Override
	public List<DoctorDTO> listDoctors() {
		List<Doctor> doctorList =  doctorDAO.listDoctors();
		List<DoctorDTO> doctorDTOlist = new ArrayList<>();
		for(Doctor d : doctorList) {
			doctorDTOlist.add(new DoctorDTO(d));
		}
		return doctorList != null ? doctorDTOlist : null;
	}

	@Override
	public void updateDoctor(int id, DoctorDTO doctorDTO) {
		Doctor doctor = new Doctor(doctorDTO);
		doctor.setDoctorId(id);
		doctorDAO.updateDoctor(doctor);
	}

	@Override
	public void deleteDoctor(int doctorId) {
		doctorDAO.deleteDoctor(doctorId);
	}

	@Override
	public DoctorDTO findByEmail(String email) {
		Doctor doctor = doctorDAO.findByEmail(email);
		return doctor != null ? new DoctorDTO(doctor) : null;
	}

	@Override
	public List<DashboardDTO> myAppointments(int id) {
		// TODO Auto-generated method stub
		List<Appointment> doctorList = doctorDAO.myAppointments(id);
		List<DashboardDTO> doctorDTOlist = new ArrayList<>();
		for(Appointment d : doctorList) {
			doctorDTOlist.add(new DashboardDTO(d));
		}
		return doctorList != null ? doctorDTOlist : null;
	}


}
