package com.demo.health.dao;

import java.util.List;

import com.demo.health.entity.Patient;

public interface PatientDAO {
    void save(Patient patient);
    Patient get(int  patientId);
    List<Patient> list();
    void update(Patient patient);
    void delete(int patientId);
    Patient loginPatient(String email, String password);
}
