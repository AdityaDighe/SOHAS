package com.demo.health.exception;

//Exception class for doctor not found exception in Criteria Query for /patients/doctors
public class UserNotFoundException extends RuntimeException {
    public UserNotFoundException(String message) {
        super(message);
    }
}
