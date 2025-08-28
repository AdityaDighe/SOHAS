package com.demo.health.dao.impl;

import com.demo.health.dao.AppointmentDAO;
import com.demo.health.entity.Appointment;

import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class AppointmentDAOImpl implements AppointmentDAO{
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Appointment appointment) {
		sessionFactory.getCurrentSession().save(appointment);
	}

	@Override
	public Appointment get(int appointmentId) {
		return sessionFactory.getCurrentSession().get(Appointment.class, appointmentId);
	}

	@Override
	public List<Appointment> list() {
		return sessionFactory.getCurrentSession().createQuery("from Appointment", Appointment.class).list();
	}
	
	@Override
	public void updateStatus(Appointment apt) {
		sessionFactory.getCurrentSession().update(apt);
	}
}
