package com.demo.health.service;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import com.demo.health.dto.PatientDTO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;

public interface PatientService {
	String save(PatientDTO patientDTO);

	PatientDTO get(int patientId);

	List<Patient> list();

	void update(PatientDTO patient);

	void delete(int patientId);

	

	List<Doctor> getDoctors(String location, Time time, Date date);

	Patient findByEmail(String email);

	List<Appointment> getAppointment(int id);

}
