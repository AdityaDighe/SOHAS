package com.demo.health.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;

@Controller
public class InitialController {
	
	@Autowired
	PatientService patientService;
	
	@Autowired
	DoctorService doctorService;

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
		String role = (String)request.getAttribute("role");
		
		if(role.equalsIgnoreCase("patient")) {
			String username = (String) request.getAttribute("username");
			Integer id = (Integer) request.getAttribute("id");

			model.addAttribute("username", username);
			model.addAttribute("id", id);

			return "patient";
		}
		return "error";
		
	}

	@RequestMapping("/patientDashboard/appointment")
	public String appointment(HttpServletRequest request, Model model) {
		String role = (String)request.getAttribute("role");
		
		if(role.equalsIgnoreCase("patient")) {
			String username = (String) request.getAttribute("username");
			Integer id = (Integer) request.getAttribute("id");

			model.addAttribute("username", username);
			model.addAttribute("id", id);

			return "appointments";
		}
		return "error";
	}

	@RequestMapping("/doctorDashboard")
	public String doctor(HttpServletRequest request, Model model) {
		String role = (String) request.getAttribute("role");
		
		if(role.equalsIgnoreCase("doctor")) {
			String username = (String) request.getAttribute("username");
			Integer id = (Integer) request.getAttribute("id");
			
			model.addAttribute("username", username);
			model.addAttribute("id", id);

			return "doctor-dashboard";
		}
		
		return "error";
	}
	
	@RequestMapping("/forgot-password")
	public String forgotPasswordPage() {
	    return "forgot-password";
	}
	
	@RequestMapping("/patient/profile")
	public String showPatientProfile(Model model, HttpServletRequest request) {
    	String role = (String) request.getAttribute("role");
    	if (role.equalsIgnoreCase("patient")) {
    		int id = (Integer) request.getAttribute("id"); // get logged-in username
            Patient patient = patientService.get(id); // fetch patient data
            model.addAttribute("patient", patient);
            return "patient-profile";
    	}
    	return "error";
    }
	
	@RequestMapping("/doctor/profile")
	public String showDoctorProfile(Model model, HttpServletRequest request) {
		String role = (String) request.getAttribute("role");
    	if (role.equalsIgnoreCase("doctor")) {
    		int id = (Integer) request.getAttribute("id"); // get logged-in username
    		Doctor doctor = doctorService.get(id); // fetch patient data
    		model.addAttribute("doctor", doctor);
    		return "doctor-profile";
    	}
    	return "error";
    }

}
