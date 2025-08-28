package com.demo.health.service.impl;

import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.health.dao.PatientDAO;
import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.PatientService;

@Service
public class PatientServiceImpl implements PatientService {

	@Autowired
	private PatientDAO patientdao;
	
	@Autowired
	private BCryptPasswordEncoder encoder;

	@Override
	@Transactional
	public void save(PatientDTO patientDTO) {
		// TODO Auto-generated method stub
		Patient patient = new Patient(patientDTO);
		patientdao.save(patient);
		
	}

	@Override
	@Transactional
	public PatientDTO get(int patientId) {
		// TODO Auto-generated method stub
		Patient patient = patientdao.get(patientId);
		return patient != null ? new PatientDTO(patient) : null;
	}
	
	@Override
	@Transactional
	public List<PatientDTO> list() {
		// TODO Auto-generated method stub
		List<Patient> patientList =  patientdao.list();
		List<PatientDTO> patientDTOlist = new ArrayList<>();
		for(Patient p: patientList) {
			patientDTOlist.add(new PatientDTO(p));
		}
		return patientList != null ? patientDTOlist : null;
	}

	@Override
	@Transactional
	public void update(int id, PatientDTO patientDTO) {
		// TODO Auto-generated method stub
		Patient patient = new Patient(patientDTO);
		patient.setPatientId(id);
		patientdao.update(patient);
	}

	@Override
	@Transactional
	public void delete(int patientId) {
		// TODO Auto-generated method stub
		patientdao.delete(patientId);

	}

	@Override
	@Transactional
	public List<DoctorDTO> getDoctors(String location, Time time, Date date) {
		// TODO Auto-generated method stub
		List<Doctor> doctorList = patientdao.getDoctors(location, time, date);
		List<DoctorDTO> doctorDTOlist = new ArrayList<>();
		for(Doctor d : doctorList) {
			doctorDTOlist.add(new DoctorDTO(d));
		}
		return doctorList != null ? doctorDTOlist : null;
	}

	@Override
	@Transactional
	public PatientDTO findByEmail(String email) {
		Patient patient = patientdao.findByEmail(email);
		return patient != null ? new PatientDTO(patient) : null;
	}

	@Override
	@Transactional
	public List<DashboardDTO> getAppointment(int id) {
		// TODO Auto-generated method stub
		List<Appointment> appointmentList =  patientdao.getAppointment(id);
		List<DashboardDTO> appointmentDTOlist = new ArrayList<>();
		for(Appointment app : appointmentList) {
			appointmentDTOlist.add(new DashboardDTO(app));
		}
		
		return appointmentList != null ? appointmentDTOlist : null;
	}

	

}
