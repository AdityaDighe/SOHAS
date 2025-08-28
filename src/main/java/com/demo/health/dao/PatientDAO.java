package com.demo.health.dao;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;

public interface PatientDAO {
	void addPatient(Patient patient);

	Patient getPatientById(int patientId);

	List<Patient> listPatients();

	void updatePatient(Patient patient);

	void deletePatient(int patientId);


	List<Doctor> getAvailableDoctors(String location, Time time, Date date);

	Patient findByEmail(String email);

	List<Appointment> getPatientAppointments(int id);

}
