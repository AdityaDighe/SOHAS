package com.demo.health.dao;

import java.util.List;

import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;

public interface DoctorDAO {
	void addDoctor(Doctor doctor);

	Doctor getDoctorById(int doctorId);

	List<Doctor> listDoctors();

	void updateDoctor(Doctor doctor);

	void deleteDoctor(int doctorId);

	Doctor findByEmail(String email);

	List<Appointment> myAppointments(int id);

}