package com.demo.health.dao.impl;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Subquery;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.health.dao.PatientDAO;
import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;

@Repository
public class PatientDAOImpl implements PatientDAO {

    @Autowired
    private SessionFactory sessionFactory;
    
    // Logger instance
    private static final Logger logger = LogManager.getLogger(PatientDAOImpl.class);

    @Override
    public void addPatient(Patient patient) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(patient);
            tx.commit();
            logger.info("User registered successfully {}", patient.getPatientName());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Failed to register User", e);
        } finally {
            session.close();
        }
    }

    @Override
    public Patient getPatientById(int patientId) {
        Session session = sessionFactory.openSession();
        Patient patient = null;
        try {
            patient = session.get(Patient.class, patientId);
            logger.info("Fetched user with Name: {}", patient.getPatientName());
        } catch (Exception e) {
        	logger.error("Error fetching user with name: {}", e); 	
        } finally {
            session.close();
        }
        return patient;
    }

    @Override
    public List<Patient> listPatients() {
        Session session = sessionFactory.openSession();
        List<Patient> patients = null;
        try {
            patients = session.createQuery("from Patient", Patient.class).list();
            logger.info("Fetched {} users from the database", patients != null ? patients.size() : 0);
        } catch (Exception e) {
        	logger.error("Error listing users : ", e);
        } finally {
            session.close();
        }
        return patients;
    }

    @Override
    public void updatePatient(Patient patient) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.merge(patient);
            tx.commit();
            logger.info("Updated user with Name : {}", patient.getPatientName());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Error updating user : {}", e);
        } finally {
            session.close();
        }
    }

    @Override
    public void deletePatient(int patientId) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Patient p = session.get(Patient.class, patientId);
            if (p != null) {
                session.delete(p);
                logger.info("Deleted user with Name: {}", p.getPatientName());
            }else {
            	logger.warn("User not found");
            }
            tx.commit();
            logger.info("Deleted user with Name: {}", p.getPatientName());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Error deleting user : {}", e);
        } finally {
            session.close();
        }
    }

    // Getting list of doctors using criteria query based on location, date and time
    @Override
    public List<Doctor> getAvailableDoctors(String location, Time time, Date date) {
        Session session = sessionFactory.openSession();
        List<Doctor> doctors = null;
        try {
            // Main CriteriaBuilder :
            CriteriaBuilder cb = session.getCriteriaBuilder();
            CriteriaQuery<Doctor> cq = cb.createQuery(Doctor.class); // Return Doctor object

            // Root for Doctor Table :
            Root<Doctor> doctorRoot = cq.from(Doctor.class); // Access data from doctor table

            // SubQuery to get busy doctors :
            Subquery<Integer> subquery = cq.subquery(Integer.class);
            Root<Appointment> appointmentRoot = subquery.from(Appointment.class);
            subquery.select(appointmentRoot.get("doctor").get("doctorId")).where(
                    cb.equal(appointmentRoot.get("date"), date),
                    cb.equal(appointmentRoot.get("time"), time),
                    cb.equal(appointmentRoot.get("status"), "BOOKED"));

            // Main Query :
            cq.select(doctorRoot)
                    .where(cb.and(
                            cb.equal(doctorRoot.get("city"), location),
                            cb.not(doctorRoot.get("doctorId").in(subquery)),
                            cb.between(cb.literal(time), doctorRoot.get("startTime"), doctorRoot.get("endTime"))
                    ));

            doctors = session.createQuery(cq).getResultList();
            if(doctors != null) {
            	logger.info("{} Doctors found for {}",doctors.size(), location, time, date);
            } else {
            	logger.warn("Doctor not found {}", location, time, date);
            }
        } catch (Exception e) {
            logger.error("Error finding doctor : ",e);
        } finally {
            session.close();
        }
        return doctors;
    }

    // Finding patient with certain email id
    @Override
    public Patient findByEmail(String email) {
        Session session = sessionFactory.openSession();
        Patient patient = null;
        try {
            String hql = "FROM Patient p WHERE p.email = :email";
            patient = session.createQuery(hql, Patient.class)
                             .setParameter("email", email)
                             .uniqueResult();
            
            if (patient != null) {
                logger.info("User found with email: {}", email);
            } else {
                logger.warn("No user found with email: {}", email);
            }
        } catch (Exception e) {
        	logger.error("Error finding user by email: {}", email, e);
        } finally {
            session.close();
        }
        return patient;
    }

    // Appointment list of the patient
    @Override
    public List<Appointment> getPatientAppointments(int id) {
        Session session = sessionFactory.openSession();
        List<Appointment> appointments = null;
        try {
            String hql = "FROM Appointment a WHERE a.patient.patientId = :patientId";
            appointments = session.createQuery(hql, Appointment.class)
                                  .setParameter("patientId", id)
                                  .list();
            
            logger.info("Found {} appointments for user", appointments != null ? appointments.size() : 0);
        } catch (Exception e) {
        	logger.error("Error fetching appointments for user: {}", e);
        } finally {
            session.close();
        }
        return appointments;
    }
}
