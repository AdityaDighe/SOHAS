package com.demo.health.dto;

import java.time.LocalDateTime;


import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.PositiveOrZero;
import javax.validation.constraints.Size;

import com.demo.health.entity.Patient;

public class PatientDTO {
	
	private int patientId;
	
	@NotBlank(message = "Name is required")
    @Size(min = 3, max = 100, message = "Name must be between 3 and 100 characters")
    private String patientName;
	
	@PositiveOrZero(message = "Age must be zero or a positive number")
    private int age;
	
	@NotBlank(message = "City is required")
	@Size(max = 50, message = "City cannot exceed 50 characters")
    private String city;
	
	@NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    private String email;
	
	@NotBlank(message = "Password is required")
    @Pattern(
        regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$",
        message = "Password must be at least 8 characters long and include uppercase, lowercase, number, and special character"
    )
    private String password;
	
	private String otp;
	
	private LocalDateTime otpExpiry;
    
	public PatientDTO() {} 
	
	public PatientDTO(Patient patient) {
		this.patientId = patient.getPatientId();
		this.patientName = patient.getPatientName();
		this.age = patient.getAge();
		this.city = patient.getCity();
		this.email = patient.getEmail();
		this.password = patient.getPassword();
		this.otp = patient.getOtp();
		this.otpExpiry = patient.getOtpExpiry();
	}
	
	//getters and setters
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
}
