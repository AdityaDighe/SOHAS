package com.demo.health.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;

import com.demo.health.dto.LoginDTO;

public interface AuthService {
	ResponseEntity<?> doLogin(LoginDTO loginDTO);
	ResponseEntity<?> logout(HttpServletRequest req, HttpServletResponse res);
	ResponseEntity<?> requestOtp(String email);
	ResponseEntity<?> resetPassword(String email, String newPassword, String otp);
	
}
