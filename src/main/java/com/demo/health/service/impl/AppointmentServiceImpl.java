package com.demo.health.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.health.dao.AppointmentDAO;
import com.demo.health.dto.AppointmentDTO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.AppointmentService;
import com.demo.health.service.DoctorService;
import com.demo.health.service.EmailService;
import com.demo.health.service.PatientService;

@Service
public class AppointmentServiceImpl implements AppointmentService{
	
	@Autowired
	private AppointmentDAO appointmentdao;
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private PatientService patientService;
	
	@Autowired
	private DoctorService doctorService;
	
	@Override
	@Transactional
	public void save(AppointmentDTO appointment) {
		appointmentdao.save(appointment);
		
		int patientId = appointment.getPatientId(); 
		Patient patient = patientService.get(patientId);
		
		int doctorId = appointment.getDoctorId(); 
		Doctor doctor = doctorService.get(doctorId);
		
		emailService.sendAppointmentConfirmationEmail(doctor.getEmail(), patient.getEmail(), doctor.getDoctorName(), patient.getPatientName(), appointment.getDate(), appointment.getTime());
	}

	@Override
	@Transactional
	public AppointmentDTO get(int appointmentId) {
		// TODO Auto-generated method stub
		return appointmentdao.get(appointmentId);
	}

	@Override
	@Transactional
	public List<AppointmentDTO> list() {
		// TODO Auto-generated method stub
		return appointmentdao.list();
	}

	
	@Override
	@Transactional
	public void updateStatus(AppointmentDTO apt) {
		// TODO Auto-generated method stub
		appointmentdao.updateStatus(apt);	
	}
}
