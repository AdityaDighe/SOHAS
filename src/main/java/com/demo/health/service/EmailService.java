package com.demo.health.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    private String fromEmail = "singhraj45official@gmail.com";


    public void sendOtpEmail(String toEmail, String otp) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("SOHAS • Password Reset OTP");
            message.setText("Dear User,\n\nYour OTP for resetting password is: " + otp 
                            + "\n\nIt is valid for 5 minutes.\n\nRegards,\nSOHAS Team");

            mailSender.send(message);
            System.out.println("✅ OTP email sent successfully to " + toEmail);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("❌ Error while sending OTP email: " + e.getMessage());
        }
    }
}
