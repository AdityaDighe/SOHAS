package com.demo.health.dao.impl;

import java.sql.Date;
import java.sql.Time;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.persistence.criteria.Subquery;

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

    @Override
    public void save(Patient patient) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(patient);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    @Override
    public Patient get(int patientId) {
        Session session = sessionFactory.openSession();
        Patient patient = null;
        try {
            patient = session.get(Patient.class, patientId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return patient;
    }

    @Override
    public List<Patient> list() {
        Session session = sessionFactory.openSession();
        List<Patient> patients = null;
        try {
            patients = session.createQuery("from Patient", Patient.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return patients;
    }

    @Override
    public void update(Patient patient) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.merge(patient);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    @Override
    public void delete(int patientId) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            Patient p = session.get(Patient.class, patientId);
            if (p != null) {
                session.delete(p);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    // Getting list of doctors using criteria query based on location, date and time
    @Override
    public List<Doctor> getDoctors(String location, Time time, Date date) {
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
        } catch (Exception e) {
            e.printStackTrace();
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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return patient;
    }

    // Appointment list of the patient
    @Override
    public List<Appointment> getAppointment(int id) {
        Session session = sessionFactory.openSession();
        List<Appointment> appointments = null;
        try {
            String hql = "FROM Appointment a WHERE a.patient.patientId = :patientId";
            appointments = session.createQuery(hql, Appointment.class)
                                  .setParameter("patientId", id)
                                  .list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return appointments;
    }
}
