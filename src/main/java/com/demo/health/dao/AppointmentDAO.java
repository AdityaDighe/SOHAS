package com.demo.health.dao;

import java.util.List;

import com.demo.health.entity.Appointment;

public interface AppointmentDAO {
    void save(Appointment appoint);
    Appointment get(int  appointmentId);
    List<Appointment> list();
	void updateStatus(Appointment apt);
}

