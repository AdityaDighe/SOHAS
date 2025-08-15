package com.demo.health.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;

import com.demo.health.util.JwtUtil;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;

@Controller
public class InitialController {
	@RequestMapping("/login")
	public String start() {
		return "login";
	}

	@RequestMapping("/doctorSignup")
	public String dstart() {
		return "doctor-signup";
	}

	@RequestMapping("/patientSignup")
	public String login() {
		return "signup";
	}

	@RequestMapping("/patientDashboard")
	public String patientDashboard(@CookieValue(value = "jwtToken", required = false) String jwtToken, Model model) {
		if (jwtToken == null) {
            return "login";
        }
		
		
        try {
            Jws<Claims> claims = JwtUtil.validateToken(jwtToken);
            String username = claims.getBody().getSubject();
            Integer id = claims.getBody().get("id", Integer.class);
            model.addAttribute("username", username);
            model.addAttribute("id", id);
            System.out.println("USername : "+ username);
            System.out.println("ID : " + id);
            return "patient";
        } catch (Exception e) {
            return "{\"error\":\"Invalid or expired token\"}";
        }
	}

	@RequestMapping("/patientDashboard/appointment")
	public String appointment(@CookieValue(value = "jwtToken", required = false) String jwtToken, Model model) {
		if (jwtToken == null) {
            return "login";
        }
		
		
        try {
            Jws<Claims> claims = JwtUtil.validateToken(jwtToken);
            String username = claims.getBody().getSubject();
            Integer id = claims.getBody().get("id", Integer.class);
            model.addAttribute("username", username);
            model.addAttribute("id", id);
           
            return "appointments";
        } catch (Exception e) {
            return "{\"error\":\"Invalid or expired token\"}";
        }
	}
	@RequestMapping("/doctorDashboard")
	public String doctor(@CookieValue(value = "jwtToken", required = false) String jwtToken, Model model) {
		
		if (jwtToken == null) {
            return "login";
        }
		
		
        try {
            Jws<Claims> claims = JwtUtil.validateToken(jwtToken);
            String username = claims.getBody().getSubject();
            Integer id = claims.getBody().get("id", Integer.class);
            model.addAttribute("username", username);
            model.addAttribute("id", id);
           
            return "doctor-dashboard";
        } catch (Exception e) {
            return "{\"error\":\"Invalid or expired token\"}";
        }
	}
}
