package com.demo.health.dao.impl;

import java.time.LocalDateTime;
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
public class DoctorDAOImpl implements DoctorDAO{
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
		if (doctor != null) sessionFactory.getCurrentSession().delete(doctor);	
	}

	
	@Override
	public Doctor findByEmail(String email) {
		String hql = "FROM Doctor d WHERE d.email = :email";
	    return sessionFactory.getCurrentSession()
	            .createQuery(hql, Doctor.class)
	            .setParameter("email", email)
	            .uniqueResult();
	}

	@Override
	public List<Appointment> myAppointments(int id) {
		// TODO Auto-generated method stub
		String hql = "FROM Appointment a WHERE a.doctor.doctorId = :id";
		 return sessionFactory.getCurrentSession()
		            .createQuery(hql, Appointment.class)
		            .setParameter("id", id)
		            .list();
	}
	
	@Override
	public void updateOtp(String email, String otp, LocalDateTime expiry) {
	    Doctor doctor = findByEmail(email);
	    if (doctor != null) {
	        doctor.setOtp(otp);
	        doctor.setOtpExpiry(expiry);
	        sessionFactory.getCurrentSession().update(doctor);
	    }
	}

	@Override
	public Doctor findByEmailAndOtp(String email, String otp) {
	    String hql = "FROM Doctor d WHERE d.email = :email AND d.otp = :otp";
	    return sessionFactory.getCurrentSession()
	            .createQuery(hql, Doctor.class)
	            .setParameter("email", email)
	            .setParameter("otp", otp)
	            .uniqueResult();
	}

	@Override
	public void updatePassword(String email, String newPassword) {
	    Doctor doctor = findByEmail(email);
	    if (doctor != null) {
	        doctor.setPassword(newPassword);
	        doctor.setOtp(null); // clear OTP after use
	        doctor.setOtpExpiry(null);
	        sessionFactory.getCurrentSession().update(doctor);
	    }
	}

}
