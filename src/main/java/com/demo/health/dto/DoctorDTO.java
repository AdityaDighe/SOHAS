package com.demo.health.dto;

import java.sql.Time;
import java.time.LocalDateTime;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.demo.health.entity.Doctor;

public class DoctorDTO {
	
	private int doctorId;
	
	@NotBlank (message = "Name is required")
	@Size (min = 3, max = 100, message = "Name must be between 3 and 100 characters")
	private String doctorName;
	
	@NotBlank(message = "Specialty is required")
    @Size(max = 100, message = "Specialty cannot exceed 100 characters")
	private String speciality;
	
	private Time startTime;

	private Time endTime;
	
	@NotBlank(message = "Phone number is required")
    @Pattern(regexp = "^[0-9]{10}$", message = "Phone number must be 10 digits")
	private String phoneNumber;
	
	@NotBlank(message = "City is required")
	@Size(max = 50, message = "City cannot exceed 50 characters")
	private String city;
	 
	@NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
	private String email;
	
	@NotBlank(message = "Password is required")
    @Size(min = 8, message = "Password must be at least 8 characters long")
	private String password;
	
	@NotBlank(message = "Hospital name is required")
    @Size(max = 100, message = "Hospital name cannot exceed 100 characters")
	private String hospitalName;
	
	private String otp;
	
	private LocalDateTime otpExpiry;
	
	public DoctorDTO() {}
	
	public DoctorDTO(Doctor doctor) {
		this.doctorId = doctor.getDoctorId();
		this.doctorName = doctor.getDoctorName();
		this.speciality = doctor.getSpeciality();
		this.startTime = doctor.getStartTime();
		this.endTime = doctor.getEndTime();
		this.city = doctor.getCity();
		this.phoneNumber = doctor.getPhoneNumber();
		this.email = doctor.getEmail();
		this.password = doctor.getPassword();
		this.hospitalName = doctor.getHospitalName();
		this.otp = doctor.getOtp();
		this.otpExpiry = doctor.getOtpExpiry();
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
