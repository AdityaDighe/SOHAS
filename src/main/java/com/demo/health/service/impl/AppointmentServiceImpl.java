package com.demo.health.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.health.dao.AppointmentDAO;
import com.demo.health.dao.DoctorDAO;
import com.demo.health.dao.PatientDAO;
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
	private PatientDAO patientDAO;
	
	@Autowired
	private DoctorDAO doctorDAO;
	
	@Override
	@Transactional
	public void save(AppointmentDTO appointmentDTO) {
		Appointment appointment = new Appointment(appointmentDTO);
		Patient patient = patientDAO.get(appointmentDTO.getPatientId());
		appointment.setPatient(patient);
		Doctor doctor = doctorDAO.get(appointmentDTO.getDoctorId());
		appointment.setDoctor(doctor);
		appointmentdao.save(appointment);
		
		emailService.sendAppointmentConfirmationEmail(doctor.getEmail(), patient.getEmail(), doctor.getDoctorName(), patient.getPatientName(), appointment.getDate(), appointment.getTime());
	}

	@Override
	@Transactional
	public AppointmentDTO get(int appointmentId) {
		// TODO Auto-generated method stub
		Appointment appointment = appointmentdao.get(appointmentId);
		AppointmentDTO appointmentDTO = new AppointmentDTO(appointment);
		return appointmentDTO;
	}

	@Override
	@Transactional
	public List<AppointmentDTO> list() {
		// TODO Auto-generated method stub
			List<Appointment> appointmentList = appointmentdao.list();
			List<AppointmentDTO> appointmentDTOList = new ArrayList<>();
			for(Appointment a: appointmentList) {
				appointmentDTOList.add(new AppointmentDTO(a));
			}
		return appointmentDTOList;
	}

	
	@Override
	@Transactional
	public void updateStatus(int id, String status) {
		// TODO Auto-generated method stub
		Appointment appointment = appointmentdao.get(id);
		appointment.setStatus(status);
		appointmentdao.updateStatus(appointment);	
	}
}
