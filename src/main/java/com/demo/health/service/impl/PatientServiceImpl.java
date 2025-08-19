package com.demo.health.service.impl;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

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
	
	//Logging the patient and matching the hashcode with encoded password
	@Override
	public Patient loginPatient(String email, String password) {
	    Patient patient = patientdao.findByEmail(email);
	    if (patient != null) {
	        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	        if (encoder.matches(password, patient.getPassword())) {
	            return patient; //login success
	        }
	    }
	    return null; //login failed
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

	@Autowired
	private BCryptPasswordEncoder encoder;

	//Generating random otp and setting in the db
	@Override
	@Transactional
	public void sendOtp(String email) {
	    Patient patient = patientdao.findByEmail(email);
	    if (patient != null) {
	        String otp = String.format("%06d", new Random().nextInt(999999));
	        LocalDateTime expiry = LocalDateTime.now().plusMinutes(5);

	        patientdao.updateOtp(email, otp, expiry);

	        // TODO: call EmailService to send OTP to patient.getEmail()
	    }
	}

	
	//Verifying otp by checking that the patient entry exists or not
	@Override
	@Transactional
	public boolean verifyOtp(String email, String otp) {
	    Patient patient = patientdao.findByEmailAndOtp(email, otp);
	    if (patient != null && patient.getOtpExpiry().isAfter(LocalDateTime.now())) {
	        return true;
	    }
	    return false;
	}

	//Setting the new Password after encoding
	@Override
	@Transactional
	public void resetPassword(String email, String newPassword) {
	    String hashed = encoder.encode(newPassword);
	    patientdao.updatePassword(email, hashed);
	}

}
