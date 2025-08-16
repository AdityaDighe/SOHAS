package com.demo.health.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class InitialController {

	@RequestMapping("/")
	public String startPage() {
		return "index";
	}

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
	public String patientDashboard(HttpServletRequest request, Model model) {
		String username = (String) request.getAttribute("username");
		Integer id = (Integer) request.getAttribute("id");

		model.addAttribute("username", username);
		model.addAttribute("id", id);

		return "patient";
	}

	@RequestMapping("/patientDashboard/appointment")
	public String appointment(HttpServletRequest request, Model model) {
		String username = (String) request.getAttribute("username");
		Integer id = (Integer) request.getAttribute("id");

		model.addAttribute("username", username);
		model.addAttribute("id", id);

		return "appointments";
	}

	@RequestMapping("/doctorDashboard")
	public String doctor(HttpServletRequest request, Model model) {
		String username = (String) request.getAttribute("username");
		Integer id = (Integer) request.getAttribute("id");
		
		model.addAttribute("username", username);
		model.addAttribute("id", id);

		return "doctor-dashboard";
	}
}
