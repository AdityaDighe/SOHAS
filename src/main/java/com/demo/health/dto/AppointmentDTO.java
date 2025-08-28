package com.demo.health.dto;

import java.sql.Date;
import java.sql.Time;

import com.demo.health.entity.Appointment;
import com.fasterxml.jackson.annotation.JsonFormat;

public class AppointmentDTO {
	
	private int appointmentId;
	
	private String status = "BOOKED";
	
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date date;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss")
    private Time time;
	
    private int patientId;
	
    private int doctorId;

	public AppointmentDTO(Appointment appointment) {
		this.appointmentId = appointment.getAppointmentId();
		this.status = appointment.getStatus();
		this.date = appointment.getDate();
		this.time = appointment.getTime();
		this.patientId = appointment.getPatient().getPatientId();
		this.doctorId = appointment.getDoctor().getDoctorId();
	}
	
	

	public int getAppointmentId() {
		return appointmentId;
	}
	
	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public Time getTime() {
		return time;
	}

	public void setTime(Time time) {
		this.time = time;
	}

	public int getPatientId() {
		return patientId;
	}

	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}

	public int getDoctorId() {
		return doctorId;
	}

	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
}