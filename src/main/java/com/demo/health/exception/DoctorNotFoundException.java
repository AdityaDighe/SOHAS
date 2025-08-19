package com.demo.health.exception;

//Exception class for doctor not found exception in Criteria Query for /patients/doctors
public class DoctorNotFoundException extends RuntimeException {
    public DoctorNotFoundException(String message) {
        super(message);
    }
}
