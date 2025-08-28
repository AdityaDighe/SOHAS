package com.demo.health.service;

import java.util.List;

import com.demo.health.dto.AppointmentDTO;
import com.demo.health.dto.DoctorDTO;
import com.demo.health.exception.UserNotFoundException;

public interface DoctorService {
	void save(DoctorDTO doctorDTO);

	DoctorDTO get(int doctorId) throws UserNotFoundException;

	List<DoctorDTO> list();

	void update(int id, DoctorDTO doctorDTO);

	void delete(int doctorId);

	

	DoctorDTO findByEmail(String email);

	List<AppointmentDTO> myAppointments(int id);

}