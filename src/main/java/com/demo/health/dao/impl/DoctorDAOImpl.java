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

@Repository
public class DoctorDAOImpl implements DoctorDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addDoctor(Doctor doctor) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(doctor);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
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
        } catch (Exception e) {
            e.printStackTrace();
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
        } catch (Exception e) {
            e.printStackTrace();
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
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
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
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
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
        } catch (Exception e) {
            e.printStackTrace();
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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return appointments;
    }
}
