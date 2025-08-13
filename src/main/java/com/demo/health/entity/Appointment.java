package com.demo.health.entity;

import java.sql.Date;
import java.sql.Time;

import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;

public class Appointment {
	int doctorId;
	int patientId;
	int appointmentId;
	String status;
	Date date;
	Time time;
	
	@ManyToOne
    @JoinColumn(name = "patientId")
    private Patient patient;
	
	@ManyToOne
    @JoinColumn(name = "doctorId")
    private Doctor doctor;
	
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
	public Patient getPatient() {
		return patient;
	}
	public void setPatient(Patient patient) {
		this.patient = patient;
	}
	public Doctor getDoctor() {
		return doctor;
	}
	public void setDoctor(Doctor doctor) {
		this.doctor = doctor;
	}
}
