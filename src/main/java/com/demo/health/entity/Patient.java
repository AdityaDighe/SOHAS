package com.demo.health.entity;


import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.PositiveOrZero;
import javax.validation.constraints.Size;

import com.demo.health.dto.PatientDTO;

import java.time.LocalDateTime;

@Entity
@Table(name = "patients")
public class Patient {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int patientId;
	
	private String patientName;
	
	private int age;
	
	private String city;
	
	private String email;
	
	private String password;
	
	private String otp;
	
	private LocalDateTime otpExpiry;
	
	public Patient(PatientDTO patientDTO) {
		this.patientName = patientDTO.getPatientName();
		this.age = patientDTO.getAge();
		this.city = patientDTO.getCity();
		this.email = patientDTO.getEmail();
		this.password = patientDTO.getPassword();
		this.otp = patientDTO.getOtp();
		this.otpExpiry = patientDTO.getOtpExpiry();
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
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
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
}