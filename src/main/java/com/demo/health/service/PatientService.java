package com.demo.health.service;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;

public interface PatientService {
	void save(PatientDTO patientDTO);

	PatientDTO get(int patientId);

	List<PatientDTO> list();

	void update(int id, PatientDTO patientDTO);

	void delete(int patientId);
	
	List<DoctorDTO> getDoctors(String location, Time time, Date date);

	PatientDTO findByEmail(String email);

	List<DashboardDTO> getAppointment(int id);

}
