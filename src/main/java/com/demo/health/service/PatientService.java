package com.demo.health.service;

import java.util.List;

import com.demo.health.entity.Patient;

public interface PatientService {
	void save(Patient patient);
	Patient get(int patientId);
	List<Patient> list();
	void update(Patient patient);
	void delete(int patientId);
}
