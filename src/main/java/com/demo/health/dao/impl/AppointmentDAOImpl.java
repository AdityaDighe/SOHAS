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

	public void save(Appointment appointment) {
		sessionFactory.getCurrentSession().save(appointment);
	}

	public Appointment get(int appointmentId) {
		return sessionFactory.getCurrentSession().get(Appointment.class, appointmentId);
	}

	public List<Appointment> list() {
		return sessionFactory.getCurrentSession().createQuery("from Appointment", Appointment.class).list();
	}

	public void update(Appointment appointment) {
		sessionFactory.getCurrentSession().update(appointment);
	}

	public void delete(int appointmentId) {
		Appointment a = get(appointmentId);
		if (a != null)
			sessionFactory.getCurrentSession().delete(a);
	}

	@Override
	public void updateStatus(Appointment apt) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().update(apt);
		
	}
}
