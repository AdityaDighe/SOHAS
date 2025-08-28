package com.demo.health.dao;

import java.util.List;

import com.demo.health.dto.AppointmentDTO;
import com.demo.health.entity.Appointment;

public interface AppointmentDAO {
    void save(AppointmentDTO appoint);
    Appointment get(int  appointmentId);
    List<AppointmentDTO> list();
	void updateStatus(AppointmentDTO apt);
}

