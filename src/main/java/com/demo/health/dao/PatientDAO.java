package com.demo.health.dao;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.List;

import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;

public interface PatientDAO {
    void save(Patient patient);
    Patient get(int  patientId);
    List<Patient> list();
    void update(Patient patient);
    void delete(int patientId);
//    Patient loginPatient(String email, String password);
	List<Doctor> getDoctors(String location, Time time, Date date);
	Patient findByEmail(String email);
	List<Appointment> getAppointment(int id);
	
	void updateOtp(String email, String otp, LocalDateTime expiry);
	Patient findByEmailAndOtp(String email, String otp);
	void updatePassword(String email, String newPassword);
}

