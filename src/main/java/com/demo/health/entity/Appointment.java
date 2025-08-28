package com.demo.health.entity;

import java.sql.Date;
import java.sql.Time;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import com.demo.health.dto.AppointmentDTO;
import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name="appointments", uniqueConstraints = @UniqueConstraint(columnNames = {"doctorId", "date", "time"}))
public class Appointment {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int appointmentId;
	
	private String status = "BOOKED";
	
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    private Date date;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "HH:mm:ss")
    private Time time;
	
	@ManyToOne
    @JoinColumn(name = "patientId")
    private Patient patient;
	
	@ManyToOne
    @JoinColumn(name = "doctorId")
    private Doctor doctor;

	public Appointment(AppointmentDTO appointmentdto) {
		this.status = appointmentdto.getStatus();
		this.date = appointmentdto.getDate();
		this.time = appointmentdto.getTime();
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