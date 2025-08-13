package com.demo.health.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class InitialController {
	@RequestMapping("/")
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
	public String patientDashboard() {
		return "patient";
	}

	@RequestMapping("/patientDashboard/appointment")
	public String appointment() {
		return "appointments";
	}
}
