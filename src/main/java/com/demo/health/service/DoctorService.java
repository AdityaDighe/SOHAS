package com.demo.health.service;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;

import com.demo.health.dto.DashboardDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.exception.UserNotFoundException;

public interface DoctorService {
	ResponseEntity<?> save(DoctorDTO doctorDTO, BindingResult result);

	DoctorDTO get(int doctorId) throws UserNotFoundException;

	List<DoctorDTO> list();

	void update(int id, DoctorDTO doctorDTO);

	void delete(int doctorId);

	

	DoctorDTO findByEmail(String email);

	List<DashboardDTO> myAppointments(int id);

}