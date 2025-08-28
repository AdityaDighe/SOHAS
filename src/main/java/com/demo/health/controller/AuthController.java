package com.demo.health.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.dto.LoginDTO;
import com.demo.health.service.AuthService;

/*
Authentication controller used for authorization and authentication purposes
*/
@RestController
@RequestMapping("/api")
public class AuthController {    
    @Autowired
    private AuthService authService;
    
    
    @PostMapping(value = "/login", produces = "application/json")
    public ResponseEntity<?> doLogin(@RequestBody LoginDTO loginDTO){
    	 return authService.doLogin(loginDTO);
    }


    //Logout, entering null cookie and removing jwtToken
    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request, HttpServletResponse response) {
    	return authService.logout(request, response);
    }
    

    //OTP request to change password
    @PostMapping("/request-otp")
    public ResponseEntity<?> requestOtp(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");

        return authService.requestOtp(email);
    }

    
    //Forget password with BCrypt, single API for both doctor and patient
    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody Map<String, String> payload) {
        String email = payload.get("email");
        String otp = payload.get("otp");
        String newPassword = payload.get("newPassword");

        return authService.resetPassword(email, newPassword, otp);
    }

}
