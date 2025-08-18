package com.demo.health.service.impl;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.health.dao.PatientDAO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	private PatientDAO patientdao;
	
	@Override
	@Transactional
	public void save(Patient patient) {
		// TODO Auto-generated method stub
		patientdao.save(patient);;
		
	}

	@Override
	@Transactional
	public Patient get(int patientId) {
		// TODO Auto-generated method stub
		return patientdao.get(patientId);
	}

	@Override
	@Transactional
	public List<Patient> list() {
		// TODO Auto-generated method stub
		return patientdao.list();
	}

	@Override
	@Transactional
	public void update(Patient patient) {
		// TODO Auto-generated method stub
		patientdao.update(patient);
	}

	@Override
	@Transactional
	public void delete(int patientId) {
		// TODO Auto-generated method stub
		patientdao.delete(patientId);
		
	}

	@Override
	public Patient loginPatient(String email, String password) {
	    Patient patient = patientdao.findByEmail(email);
	    if (patient != null) {
	        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	        if (encoder.matches(password, patient.getPassword())) {
	            return patient; // ✅ login success
	        }
	    }
	    return null; // ❌ login failed
	}



	@Override
	@Transactional
	public List<Doctor> getDoctors(String location, Time time, Date date) {
		// TODO Auto-generated method stub
		return patientdao.getDoctors(location, time, date);
	}

	@Override
	@Transactional
	public Patient findByEmail(String email) {
		return patientdao.findByEmail(email);
	}

	@Override
	@Transactional
	public List<Appointment> getAppointment(int id) {
		// TODO Auto-generated method stub
		return patientdao.getAppointment(id);
	}

}
