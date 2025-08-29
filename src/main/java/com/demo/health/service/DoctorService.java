package com.demo.health.service;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.exception.UserNotFoundException;

public interface DoctorService {
	ResponseEntity<?> registerDoctor(DoctorDTO doctorDTO);

	DoctorDTO getDoctorById(int doctorId) throws UserNotFoundException;

	List<DoctorDTO> listDoctors();

	void updateDoctor(int id, DoctorDTO doctorDTO);

	void deleteDoctor(int doctorId);

	

	DoctorDTO findByEmail(String email);

	List<DashboardDTO> myAppointments(int id);

}