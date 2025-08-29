package com.demo.health.dao.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.health.dao.DoctorDAO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Repository
public class DoctorDAOImpl implements DoctorDAO {

    @Autowired
    private SessionFactory sessionFactory;

    // Logger instance
    private static final Logger logger = LogManager.getLogger(DoctorDAOImpl.class);

    @Override
    public void addDoctor(Doctor doctor) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(doctor);
            tx.commit();
            logger.info("Doctor added successfully: {}", doctor.getDoctorName());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Error while adding doctor", e);
        } finally {
            session.close();
        }
    }

    @Override
    public Doctor getDoctorById(int doctorId) {
        Session session = sessionFactory.openSession();
        Doctor doctor = null;
        try {
            doctor = session.get(Doctor.class, doctorId);
            logger.info("Fetched doctor with ID: {}", doctorId);
        } catch (Exception e) {
            logger.error("Error fetching doctor with ID: {}", doctorId, e);
        } finally {
            session.close();
        }
        return doctor;
    }

    @Override
    public List<Doctor> listDoctors() {
        Session session = sessionFactory.openSession();
        List<Doctor> doctors = null;
        try {
            doctors = session.createQuery("from Doctor", Doctor.class).list();
            logger.info("Fetched {} doctors from the database", doctors != null ? doctors.size() : 0);
        } catch (Exception e) {
            logger.error("Error listing doctors", e);
        } finally {
            session.close();
        }
        return doctors;
    }

    @Override
    public void updateDoctor(Doctor doctor) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.merge(doctor); // merged to handle detached object update
            tx.commit();
            logger.info("Updated doctor with ID: {}", doctor.getDoctorId());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Error updating doctor with ID: {}", doctor.getDoctorId(), e);
        } finally {
            session.close();
        }
    }

    @Override
    public void deleteDoctor(int doctorId) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Doctor doctor = session.get(Doctor.class, doctorId);
            if (doctor != null) {
                session.delete(doctor);
                logger.info("Deleted doctor with ID: {}", doctorId);
            } else {
                logger.warn("Doctor not found for ID: {}", doctorId);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Error deleting doctor with ID: {}", doctorId, e);
        } finally {
            session.close();
        }
    }

    // Using HQL to find the doctor by email id
    @Override
    public Doctor findByEmail(String email) {
        Session session = sessionFactory.openSession();
        Doctor doctor = null;
        try {
            String hql = "FROM Doctor d WHERE d.email = :email";
            doctor = session.createQuery(hql, Doctor.class)
                            .setParameter("email", email)
                            .uniqueResult();
            if (doctor != null) {
                logger.info("Doctor found with email: {}", email);
            } else {
                logger.warn("No doctor found with email: {}", email);
            }
        } catch (Exception e) {
            logger.error("Error finding doctor by email: {}", email, e);
        } finally {
            session.close();
        }
        return doctor;
    }

    // Using HQL to find the appointment details based on doctor id
    @Override
    public List<Appointment> myAppointments(int id) {
        Session session = sessionFactory.openSession();
        List<Appointment> appointments = null;
        try {
            String hql = "FROM Appointment a WHERE a.doctor.doctorId = :id";
            appointments = session.createQuery(hql, Appointment.class)
                                  .setParameter("id", id)
                                  .list();
            logger.info("Found {} appointments for doctor ID: {}", appointments != null ? appointments.size() : 0, id);
        } catch (Exception e) {
            logger.error("Error fetching appointments for doctor ID: {}", id, e);
        } finally {
            session.close();
        }
        return appointments;
    }
}
