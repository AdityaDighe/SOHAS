package com.demo.health.dao;

import java.util.List;

import com.demo.health.entity.Appointment;
import com.demo.health.entity.Doctor;
 
public interface DoctorDAO {
	void save(Doctor doctor);
    Doctor get(int doctorId);
    List<Doctor> list();
    void update(Doctor doctor);
    void delete(int doctorId);
    Doctor loginDoctor(String email, String password);
    Doctor findByEmail(String email);
	List<Appointment> myAppointments(int id);
}