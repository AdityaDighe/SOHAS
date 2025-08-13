package com.demo.health.dao.impl;

import com.demo.health.dao.PatientDAO;
import com.demo.health.entity.Patient;

import java.util.List;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;


@Repository
@Transactional
public class PatientDAOImpl implements PatientDAO{
	@Autowired
	private SessionFactory sessionFactory;

	public void save(Patient patient) {
		sessionFactory.getCurrentSession().save(patient);
	}

	public Patient get(int patientId) {
		return sessionFactory.getCurrentSession().get(Patient.class, patientId);
	}

	public List<Patient> list() {
		return sessionFactory.getCurrentSession().createQuery("from Patient", Patient.class).list();
	}

	public void update(Patient patient) {
		sessionFactory.getCurrentSession().update(patient);
	}

	public void delete(int patientId) {
		Patient p = get(patientId);
		if (p != null)
			sessionFactory.getCurrentSession().delete(p);
	}
	
	public Patient loginPatient(String email, String password) {
		String hql = "SELECT p FROM Patient p WHERE p.email = :email AND p.password = :password";
		return sessionFactory.getCurrentSession().createQuery(hql, Patient.class)
												  .setParameter("email", email)
												  .setParameter("password", password)
												  .uniqueResult();
	}
}

