package com.demo.health.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

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
public class DoctorServiceImpl implements DoctorService{
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

	@Override
	public Doctor loginDoctor(String email, String password) {
	    Doctor doctor = doctorDAO.findByEmail(email);
	    if (doctor != null) {
	        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	        if (encoder.matches(password, doctor.getPassword())) {
	            return doctor; // ✅ login success
	        }
	    }
	    return null; // ❌ login failed
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
 
	@Override
	@Transactional
	public void sendOtp(String email) {
	    Doctor doctor = doctorDAO.findByEmail(email);
	    if (doctor != null) {
	        String otp = String.format("%06d", new Random().nextInt(999999));
	        LocalDateTime expiry = LocalDateTime.now().plusMinutes(5);
 
	        doctorDAO.updateOtp(email, otp, expiry);
 
	        // TODO: call EmailService to send OTP to doctor.getEmail()
	    }
	}
 
	@Override
	@Transactional
	public boolean verifyOtp(String email, String otp) {
	    Doctor doctor = doctorDAO.findByEmailAndOtp(email, otp);
	    if (doctor != null && doctor.getOtpExpiry().isAfter(LocalDateTime.now())) {
	        return true;
	    }
	    return false;
	}
 
	@Override
	@Transactional
	public void resetPassword(String email, String newPassword) {
	    String hashed = encoder.encode(newPassword);
	    doctorDAO.updatePassword(email, hashed);
	}
}


