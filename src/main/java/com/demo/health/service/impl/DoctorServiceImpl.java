package com.demo.health.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.demo.health.dao.DoctorDAO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.exception.DoctorNotFoundException;
import com.demo.health.service.DoctorService;

@Service
public class DoctorServiceImpl implements DoctorService {
	@Autowired
	private DoctorDAO doctorDAO;

	@Override
	@Transactional
	public void save(Doctor doctor) {
		doctorDAO.save(doctor);
	}

	@Override
	@Transactional
	public Doctor get(int doctorId) throws DoctorNotFoundException {
		Doctor doctor = doctorDAO.get(doctorId);
		return doctor;
	}

	@Override
	@Transactional
	public List<Doctor> list() {
		return doctorDAO.list();
	}

	@Override
	@Transactional
	public void update(Doctor doctor) {
		doctorDAO.update(doctor);
	}

	@Override
	@Transactional
	public void delete(int doctorId) {
		doctorDAO.delete(doctorId);
	}

	// Login doctor and match the encoded password with the stored hashcode
	@Override
	public Doctor loginDoctor(String email, String password) {
		Doctor doctor = doctorDAO.findByEmail(email);
		if (doctor != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if (encoder.matches(password, doctor.getPassword())) {
				return doctor; // login success
			}
		}
		return null; // login failed
	}

	@Override
	public Doctor findByEmail(String email) {
		return doctorDAO.findByEmail(email);
	}

	@Override
	public List<Appointment> myAppointments(int id) {
		// TODO Auto-generated method stub
		return doctorDAO.myAppointments(id);
	}

	@Autowired
	private BCryptPasswordEncoder encoder; // reuse for password encoding

}
