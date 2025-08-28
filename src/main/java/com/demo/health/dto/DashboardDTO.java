package com.demo.health.dto;

import java.sql.Date;
import java.sql.Time;

import com.demo.health.entity.Appointment;
import com.fasterxml.jackson.annotation.JsonFormat;

public class DashboardDTO {
	private int appointmentId;
	private int doctorId;
	private int patientId;
	private String patientName;
	private String doctorName;
	private String speciality;
	private String status;
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss")
	private Time time;
	 @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
	private Date date;
	
	public DashboardDTO() {}
	
	public DashboardDTO(Appointment appointment) {
		this.appointmentId = appointment.getAppointmentId();
		this.doctorId = appointment.getDoctor().getDoctorId();
		this.patientId = appointment.getPatient().getPatientId();
		this.patientName = appointment.getPatient().getPatientName();
		this.doctorName = appointment.getDoctor().getDoctorName();
		this.status = appointment.getStatus();
		this.time = appointment.getTime();
		this.date = appointment.getDate();
		this.speciality = appointment.getDoctor().getSpeciality();
	}
	public String getSpeciality() {
		return speciality;
	}

	public void setSpeciality(String speciality) {
		this.speciality = speciality;
	}

	public int getAppointmentId() {
		return appointmentId;
	}
	public void setAppointmentId(int appointmentId) {
		this.appointmentId = appointmentId;
	}
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
	public int getPatientId() {
		return patientId;
	}
	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}
	public String getPatientName() {
		return patientName;
	}
	public void setPatientName(String patientName) {
		this.patientName = patientName;
	}
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	
}
