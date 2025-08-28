package com.demo.health.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.demo.health.dao.DoctorDAO;
import com.demo.health.dto.AppointmentDTO;
import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.exception.UserNotFoundException;
import com.demo.health.service.DoctorService;

@Service
public class DoctorServiceImpl implements DoctorService {
	@Autowired
	private DoctorDAO doctorDAO;
	
	@Autowired
	private BCryptPasswordEncoder encoder; 

	@Override
	@Transactional
	public void save(DoctorDTO doctorDTO) {
		Doctor doctor = new Doctor(doctorDTO);
		doctorDAO.save(doctor);
	}

	@Override
	@Transactional
	public DoctorDTO get(int doctorId) throws UserNotFoundException {
		Doctor doctor = doctorDAO.get(doctorId);
		DoctorDTO doctorDTO = new DoctorDTO(doctor);
		return doctor != null ? doctorDTO : null;
	}

	@Override
	@Transactional
	public List<DoctorDTO> list() {
		List<Doctor> doctorList =  doctorDAO.list();
		List<DoctorDTO> doctorDTOlist = new ArrayList<>();
		for(Doctor d : doctorList) {
			doctorDTOlist.add(new DoctorDTO(d));
		}
		return doctorList != null ? doctorDTOlist : null;
		
		
	}

	@Override
	@Transactional
	public void update(int id, DoctorDTO doctorDTO) {
		Doctor doctor = new Doctor(doctorDTO);
		doctor.setDoctorId(id);
		doctorDAO.update(doctor);
	}

	@Override
	@Transactional
	public void delete(int doctorId) {
		doctorDAO.delete(doctorId);
	}

	@Override
	@Transactional
	public DoctorDTO findByEmail(String email) {
		Doctor doctor = doctorDAO.findByEmail(email);
		return doctor != null ? new DoctorDTO(doctor) : null;
	}

	@Override
	@Transactional
	public List<DashboardDTO> myAppointments(int id) {
		// TODO Auto-generated method stub
		List<Appointment> doctorList = doctorDAO.myAppointments(id);
		List<DashboardDTO> doctorDTOlist = new ArrayList<>();
		for(Appointment d : doctorList) {
			doctorDTOlist.add(new DashboardDTO(d));
		}
		return doctorList != null ? doctorDTOlist : null;
	}


}
