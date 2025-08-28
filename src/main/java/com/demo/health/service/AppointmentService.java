package com.demo.health.service;

import java.util.List;

import com.demo.health.dto.AppointmentDTO;

public interface AppointmentService {
    void save(AppointmentDTO appoint);
    AppointmentDTO get(int  appointmentId);
    List<AppointmentDTO> list();
	void updateStatus(int id, String status);
}
