package com.demo.health.service;

import java.util.List;

import com.demo.health.entity.Doctor;

public interface DoctorService {
	void save(Doctor doctor);
	Doctor get(int doctorId);
	List<Doctor> list();
	void update(Doctor doctor);
	void delete(int doctorId);
	Doctor loginDoctor(String email, String password);
}
