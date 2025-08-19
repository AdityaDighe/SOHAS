package com.demo.health.dao.impl;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Subquery;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.demo.health.dao.PatientDAO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;


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
	
	//Getting list of doctors using criteria query based on location, date and time
	@Override
	public List<Doctor> getDoctors(String location, Time time, Date date) {
		//Main CriteriaBuilder : 
		CriteriaBuilder cb = sessionFactory.getCurrentSession().getCriteriaBuilder();
		CriteriaQuery<Doctor> cq = cb.createQuery(Doctor.class);
		
		// Root for Doctor Table : 
		Root<Doctor> doctorRoot = cq.from(Doctor.class);
		
         //SubQuery to get busy doctors : 
		 Subquery<Integer> subquery = cq.subquery(Integer.class);
		 Root<Appointment> appointmentRoot = subquery.from(Appointment.class);
		 subquery.select(appointmentRoot.get("doctor").get("doctorId"))
		         .where(
		                 cb.equal(appointmentRoot.get("date"), date),
		                 cb.equal(appointmentRoot.get("time"), time),
		                 cb.equal(appointmentRoot.get("status"), "BOOKED")
		         );
		 
         //Main Query : 
		 cq.select(doctorRoot).where(
				    cb.and(
				        cb.equal(doctorRoot.get("city"), location),
				        cb.not(doctorRoot.get("doctorId").in(subquery)),
				        cb.between(cb.literal(time), 
				                   doctorRoot.get("startTime"), 
				                   doctorRoot.get("endTime"))
				    )
				);
		
		 
		 List<Doctor> doctors = sessionFactory.getCurrentSession().createQuery(cq).getResultList();
		
		
		return doctors;
	}
	
	//Finding patient with certain email id
	@Override
	public Patient findByEmail(String email) {
		String hql = "FROM Patient p WHERE p.email = :email";
	    return sessionFactory.getCurrentSession()
	            .createQuery(hql, Patient.class)
	            .setParameter("email", email)
	            .uniqueResult();
	}
	
	//Appointment list of the patient 
	@Override
	public List<Appointment> getAppointment(int id) {
		// TODO Auto-generated method stub
		String hql = "FROM Appointment a WHERE a.patient.patientId = :patientId";
	    return sessionFactory.getCurrentSession()
	            .createQuery(hql, Appointment.class)
	            .setParameter("patientId", id)
	            .list();
	}
	
	//set otp for the patient entity
	@Override
	public void updateOtp(String email, String otp, LocalDateTime expiry) {
	    Patient patient = findByEmail(email);
	    if (patient != null) {
	        patient.setOtp(otp);
	        patient.setOtpExpiry(expiry);
	        sessionFactory.getCurrentSession().update(patient);
	    }
	}
	
	//finding the patient using email and otp
	@Override
	public Patient findByEmailAndOtp(String email, String otp) {
	    String hql = "FROM Patient p WHERE p.email = :email AND p.otp = :otp";
	    return sessionFactory.getCurrentSession()
	            .createQuery(hql, Patient.class)
	            .setParameter("email", email)
	            .setParameter("otp", otp)
	            .uniqueResult();
	}
	
	//updating the password from the patient request
	@Override
	public void updatePassword(String email, String newPassword) {
	    Patient patient = findByEmail(email);
	    if (patient != null) {
	        patient.setPassword(newPassword);
	        patient.setOtp(null); // clear OTP after use
	        patient.setOtpExpiry(null);
	        sessionFactory.getCurrentSession().update(patient);
	    }
	}

	
	
	
}

