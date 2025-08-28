package com.demo.health.dao.impl;

import com.demo.health.dao.AppointmentDAO;
import com.demo.health.entity.Appointment;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AppointmentDAOImpl implements AppointmentDAO {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void addAppointment(Appointment appointment) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(appointment);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

    @Override
    public Appointment getAppointmentById(int appointmentId) {
        Session session = sessionFactory.openSession();
        Appointment appointment = null;
        try {
            appointment = session.get(Appointment.class, appointmentId);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return appointment;
    }

    @Override
    public List<Appointment> listAppointments() {
        Session session = sessionFactory.openSession();
        List<Appointment> appointments = null;
        try {
            appointments = session.createQuery("from Appointment", Appointment.class).list();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return appointments;
    }
    
    //Updating the status of appointment
    @Override
    public void updateAppointmentStatus(Appointment apt) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.update(apt);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
