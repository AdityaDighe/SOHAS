package com.demo.health.service;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.PatientDTO;

public interface PatientService {
	ResponseEntity<?> registerPatient(PatientDTO patientDTO);

	PatientDTO getPatientById(int patientId);

	List<PatientDTO> listPatients();

	void updatePatient(int id, PatientDTO patientDTO);

	void deletePatient(int patientId);
	
	ResponseEntity<?> getAvailableDoctors(String location, Time time, Date date);

	PatientDTO findByEmail(String email);

	List<DashboardDTO> getPatientAppointments(int id);

}
