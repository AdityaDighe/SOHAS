package com.demo.health.dao.impl;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.demo.health.dao.AppointmentDAO;
import com.demo.health.entity.Appointment;

@Repository
public class AppointmentDAOImpl implements AppointmentDAO {

    @Autowired
    private SessionFactory sessionFactory;
    
    // Logger instance
    private static final Logger logger = LogManager.getLogger(AppointmentDAOImpl.class);

    @Override
    public void addAppointment(Appointment appointment) {
        Session session = sessionFactory.openSession();
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            session.save(appointment);
            tx.commit();
            logger.info("Booked appointment on date {} time {}", appointment.getDate(), appointment.getTime());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Booking falied : {}", e);
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
            logger.info("Successfully Fetched appointment");
        } catch (Exception e) {
            logger.error("Failed to fetch appointment : {}",e);
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
            logger.info("Get all appointment {}", appointments.size());
        } catch (Exception e) {
            logger.error("Failed to load appointments: {}", e);
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
            logger.info("Updated status of appointment successfully {}", apt.getStatus());
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            logger.error("Failed to update status : {}",e);
        } finally {
            session.close();
        }
    }
}
