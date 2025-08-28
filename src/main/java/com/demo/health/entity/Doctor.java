package com.demo.health.entity;

import java.sql.Time;
import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.demo.health.dto.DoctorDTO;

@Entity
@Table(name="doctors")
public class Doctor {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int doctorId;
	
	private String doctorName;
	
	private String speciality;
	
	private Time startTime;

	private Time endTime;
	
	private String phoneNumber;

	private String city;
	 
	private String email;
	
	private String password;
	
	private String hospitalName;
	
	private String otp;
	
	private LocalDateTime otpExpiry;
	
	public Doctor() {}
	
	public Doctor(DoctorDTO doctorDTO) {
		this.doctorName = doctorDTO.getDoctorName();
		this.speciality = doctorDTO.getSpeciality();
		this.startTime = doctorDTO.getStartTime();
		this.endTime = doctorDTO.getEndTime();
		this.phoneNumber = doctorDTO.getPhoneNumber();
		this.city = doctorDTO.getCity();
		this.email = doctorDTO.getEmail();
		this.password = doctorDTO.getPassword();
		this.hospitalName = doctorDTO.getHospitalName();
		this.otp = doctorDTO.getOtp();
		this.otpExpiry = doctorDTO.getOtpExpiry();
	}
	
	public String getOtp() {
	    return otp;
	}
	public void setOtp(String otp) {
	    this.otp = otp;
	}

	public LocalDateTime getOtpExpiry() {
	    return otpExpiry;
	}
	public void setOtpExpiry(LocalDateTime otpExpiry) {
	    this.otpExpiry = otpExpiry;
	}

	
	public int getDoctorId() {
		return doctorId;
	}
	public void setDoctorId(int doctorId) {
		this.doctorId = doctorId;
	}
	public String getDoctorName() {
		return doctorName;
	}
	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}
	public String getSpeciality() {
		return speciality;
	}
	public void setSpeciality(String speciality) {
		this.speciality = speciality;
	}
	
	public Time getStartTime() {
		return startTime;
	}
	public void setStartTime(Time startTime) {
		this.startTime = startTime;
	}
	public Time getEndTime() {
		return endTime;
	}
	public void setEndTime(Time endTime) {
		this.endTime = endTime;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getHospitalName() {
		return hospitalName;
	}
	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}
}
 
 