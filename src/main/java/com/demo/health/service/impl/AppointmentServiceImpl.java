package com.demo.health.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.demo.health.dao.AppointmentDAO;
import com.demo.health.entity.Appointment;
import com.demo.health.service.AppointmentService;

@Service
public class AppointmentServiceImpl implements AppointmentService{
	
	@Autowired
	private AppointmentDAO appointmentdao;
	
	@Override
	@Transactional
	public void save(Appointment appoint) {
		// TODO Auto-generated method stub
		appointmentdao.save(appoint);
	}

	@Override
	@Transactional
	public Appointment get(int appointmentId) {
		// TODO Auto-generated method stub
		return appointmentdao.get(appointmentId);
	}

	@Override
	@Transactional
	public List<Appointment> list() {
		// TODO Auto-generated method stub
		return appointmentdao.list();
	}

	@Override
	@Transactional
	public void update(Appointment appoint) {
		// TODO Auto-generated method stub
		appointmentdao.update(appoint);
		
	}

	@Override
	@Transactional
	public void delete(int appointmentId) {
		// TODO Auto-generated method stub
		appointmentdao.delete(appointmentId);
		
	}

	@Override
	@Transactional
	public void updateStatus(Appointment apt) {
		// TODO Auto-generated method stub
		appointmentdao.updateStatus(apt);
		
	}

}
