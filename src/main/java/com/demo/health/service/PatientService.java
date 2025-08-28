package com.demo.health.service;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;

public interface PatientService {
	ResponseEntity<?> save(PatientDTO patientDTO, BindingResult result);

	PatientDTO get(int patientId);

	List<PatientDTO> list();

	void update(int id, PatientDTO patientDTO);

	void delete(int patientId);
	
	ResponseEntity<?> getDoctors(String location, Time time, Date date);

	PatientDTO findByEmail(String email);

	List<DashboardDTO> getAppointment(int id);

}
