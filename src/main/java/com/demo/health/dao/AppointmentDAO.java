package com.demo.health.dao;

import java.util.List;

import com.demo.health.entity.Appointment;

public interface AppointmentDAO {
    void addAppointment(Appointment appoint);
    Appointment getAppointmentById(int  appointmentId);
    List<Appointment> listAppointments();
	void updateAppointmentStatus(Appointment apt);
}

