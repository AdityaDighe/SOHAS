package com.demo.health.service;

import java.util.List;

import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.exception.UserNotFoundException;

public interface DoctorService {
	void save(Doctor doctor);

	Doctor get(int doctorId) throws UserNotFoundException;

	List<Doctor> list();

	void update(Doctor doctor);

	void delete(int doctorId);

	

	Doctor findByEmail(String email);

	List<Appointment> myAppointments(int id);

}