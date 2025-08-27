package com.demo.health.service;

import java.sql.Date;
import java.sql.Time;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    private String fromEmail = "singhraj45official@gmail.com";
    
    private void sendEmail(String toEmail, String mailSubject, String mailBody) {
    	try {
    		SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject(mailSubject);
            message.setText(mailBody);
            mailSender.send(message);
            System.out.println("Email sent to " + toEmail);
    	} catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("❌ Error while sending email: " + e.getMessage());
        }
    }

    public void sendOtpEmail(String toEmail, String otp) {
    	String mailSubject = "SOHAS • Password Reset OTP";
    	String mailBody = "Dear User,\n\nYour OTP for resetting password is: " + otp 
                + "\n\nIt is valid for 5 minutes.\n\nRegards,\nSOHAS Team";
    	
    	sendEmail(toEmail, mailSubject, mailBody);
    	System.out.println("OTP email sent successfully");
    }
    
    public void sendAppointmentConfirmationToPatient(String patientEmail, String patientName, String doctorName, Date date, Time time) {
    	String mailSubject = "SOHAS • Appointment Confirmed";
    	String mailBody = "Dear " + patientName + ",\n\nYour appointment with Dr. " + doctorName + 
             " has been successfully booked.\n\nDate: " + date + "\nTime: " + time + 
             "\n\nThank you for using SOHAS.\n\nRegards,\nSOHAS Team";
    			
        sendEmail(patientEmail, mailSubject, mailBody);
        System.out.println("Appointment confirmation emails sent to patient.");
    }

    public void sendAppointmentConfirmationToDoctor(String doctorEmail, String doctorName, String patientName, Date date, Time time) {
    	String mailSubject = "SOHAS • New Appointment Booked";
    	String mailBody = "Dear Dr. " + doctorName + ",\n\nYou have a new appointment booked by " + patientName + 
             ".\n\nDate: " + date + "\nTime: " + time + 
             "\n\nPlease be available.\n\nRegards,\nSOHAS Team";
    	
        sendEmail(doctorEmail, mailSubject, mailBody);
        System.out.println("Appointment confirmation emails sent to doctor.");
    }
    
    public void sendAppointmentConfirmationEmail(String doctorEmail, String patientEmail, String doctorName, String patientName, Date date, Time time) {
    	sendAppointmentConfirmationToPatient(patientEmail, patientName, doctorName, date, time);
    	sendAppointmentConfirmationToDoctor(doctorEmail, doctorName, patientName, date, time);
    }
}
