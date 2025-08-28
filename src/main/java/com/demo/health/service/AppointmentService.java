package com.demo.health.service;

import java.util.List;

import com.demo.health.dto.AppointmentDTO;

public interface AppointmentService {
    void bookAppointment(AppointmentDTO appoint);
    AppointmentDTO getAppointmentById(int  appointmentId);
    List<AppointmentDTO> listAppointments();
	void updateAppointmentStatus(int id, String status);
}
