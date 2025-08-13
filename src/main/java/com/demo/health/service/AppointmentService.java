package com.demo.health.service;

import java.util.List;

import com.demo.health.entity.Appointment;

public interface AppointmentService {
    void save(Appointment appoint);
    Appointment get(int  appointmentId);
    List<Appointment> list();
    void update(Appointment appoint);
    void delete(int appointmentId);
	void updateStatus(Appointment apt);
}
