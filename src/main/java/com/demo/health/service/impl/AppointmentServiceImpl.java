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
import com.demo.health.service.EmailService;


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
	public void bookAppointment(AppointmentDTO appointmentDTO) {
		Appointment appointment = new Appointment(appointmentDTO);
		Patient patient = patientDAO.getPatientById(appointmentDTO.getPatientId());
		appointment.setPatient(patient);
		Doctor doctor = doctorDAO.getDoctorById(appointmentDTO.getDoctorId());
		appointment.setDoctor(doctor);
		
		appointmentdao.addAppointment(appointment);
		
		emailService.sendAppointmentConfirmationEmail(doctor, patient, appointment);
	}

	@Override
	public AppointmentDTO getAppointmentById(int appointmentId) {
		// TODO Auto-generated method stub
		Appointment appointment = appointmentdao.getAppointmentById(appointmentId);
		AppointmentDTO appointmentDTO = new AppointmentDTO(appointment);
		return appointmentDTO;
	}

	@Override
	public List<AppointmentDTO> listAppointments() {
		// TODO Auto-generated method stub
			List<Appointment> appointmentList = appointmentdao.listAppointments();
			List<AppointmentDTO> appointmentDTOList = new ArrayList<>();
			for(Appointment a: appointmentList) {
				appointmentDTOList.add(new AppointmentDTO(a));
			}
		return appointmentDTOList;
	}

	
	@Override
	public void updateAppointmentStatus(int id, String status) {
		// TODO Auto-generated method stub
		Appointment appointment = appointmentdao.getAppointmentById(id);
		appointment.setStatus(status);
		appointmentdao.updateAppointmentStatus(appointment);	
	}
}
