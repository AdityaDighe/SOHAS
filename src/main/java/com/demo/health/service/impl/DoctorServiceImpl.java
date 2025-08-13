package com.demo.health.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import com.demo.health.dao.DoctorDAO;
import com.demo.health.entity.Doctor;
import com.demo.health.service.DoctorService;

public class DoctorServiceImpl implements DoctorService{
	@Autowired
	private DoctorDAO doctorDAO;

	@Override
	@Transactional
	public void save(Doctor doctor) {
		doctorDAO.save(doctor);
	}

	@Override
	@Transactional
	public Doctor get(int doctorId) {
		return doctorDAO.get(doctorId);
	}

	@Override
	@Transactional
	public List<Doctor> list() {
		return doctorDAO.list();
	}

	@Override
	@Transactional
	public void update(Doctor doctor) {
		doctorDAO.update(doctor);
	}

	@Override
	@Transactional
	public void delete(int doctorId) {
		doctorDAO.delete(doctorId);
	}
}


