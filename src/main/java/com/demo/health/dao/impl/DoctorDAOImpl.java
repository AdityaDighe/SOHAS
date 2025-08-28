package com.demo.health.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.health.dao.DoctorDAO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;

@Repository
@Transactional
public class DoctorDAOImpl implements DoctorDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public void save(Doctor doctor) {
		sessionFactory.getCurrentSession().save(doctor);
	}

	@Override
	public Doctor get(int doctorId) {
		return sessionFactory.getCurrentSession().get(Doctor.class, doctorId);
	}

	@Override
	public List<Doctor> list() {
		return sessionFactory.getCurrentSession().createQuery("from Doctor", Doctor.class).list();
	}

	@Override
	public void update(Doctor doctor) {
		sessionFactory.getCurrentSession().update(doctor);
	}

	@Override
	public void delete(int doctorId) {
		Doctor doctor = sessionFactory.getCurrentSession().get(Doctor.class, doctorId);
		if (doctor != null) {
			sessionFactory.getCurrentSession().delete(doctor);
		}
	}

	// Using Hql to find the doctor by email id
	@Override
	public Doctor findByEmail(String email) {
		String hql = "FROM Doctor d WHERE d.email = :email";
		return sessionFactory.getCurrentSession().createQuery(hql, Doctor.class).setParameter("email", email)
				.uniqueResult();
	}

	// Using Hql to find the appointment details based on doctor id
	@Override
	public List<Appointment> myAppointments(int id) {
		// TODO Auto-generated method stub
		String hql = "FROM Appointment a WHERE a.doctor.doctorId = :id";
		return sessionFactory.getCurrentSession().createQuery(hql, Appointment.class).setParameter("id", id).list();
	}

	
}
