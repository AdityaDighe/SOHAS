package com.demo.health.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;

/*
 View Rendering for different tasks or roles
 HTTPServletRequest is being for sending the details from FrontEnd to BackEnd
 Model is used for sending details from BackEnd to FrontEnd
 */
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
	
	//Patient side rendering to display the appointments
	@RequestMapping("/patientDashboard")
	public String patientDashboard(HttpServletRequest request, Model model) {
		//Getting role attribute from the cookie JWT
		String role = (String)request.getAttribute("role");
		
		//Ensuring only patients has access and rendering patient.jsp (Already booked appointments of user)
		if(role.equalsIgnoreCase("patient")) {
			String username = (String) request.getAttribute("username");
			Integer id = (Integer) request.getAttribute("id");

			model.addAttribute("username", username);
			model.addAttribute("id", id);

			return "patient";
		}
		return "error";
		
	}
	
	//Patient side rendering to book appointments
	@RequestMapping("/patientDashboard/appointment")
	public String appointment(HttpServletRequest request, Model model) {
		String role = (String)request.getAttribute("role");
		
		//Ensuring only patients has access and rendering appointments.jsp (Available doctors to user)
		if(role.equalsIgnoreCase("patient")) {
			String username = (String) request.getAttribute("username");
			Integer id = (Integer) request.getAttribute("id");

			model.addAttribute("username", username);
			model.addAttribute("id", id);

			return "appointments";
		}
		return "error";
	}
	
	//Doctor side rendering to display the appointments
	@RequestMapping("/doctorDashboard")
	public String doctor(HttpServletRequest request, Model model) {
		String role = (String) request.getAttribute("role");
		
		//Ensuring only doctors has access and rendering doctor-dashboard.jsp (All the bookings of doctor)
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
	
	//Rendering patients profile page containing all the details
	@RequestMapping("/patient/profile")
	public String showPatientProfile(Model model, HttpServletRequest request) {
    	String role = (String) request.getAttribute("role");
    	
    	//Ensuring only patients has access and rendering patient-profile.jsp (Changing any user details)
    	if (role.equalsIgnoreCase("patient")) {
    		int id = (Integer) request.getAttribute("id"); // get logged-in username
            PatientDTO patient = patientService.get(id); // fetch patient data
            model.addAttribute("patient", patient);
            return "patient-profile";
    	}
    	return "error";
    }
	
	//Rendering Doctors profile page containing all the details
	@RequestMapping("/doctor/profile")
	public String showDoctorProfile(Model model, HttpServletRequest request) {
		String role = (String) request.getAttribute("role");
		
		//Ensuring only doctor has access and rendering doctor-profile.jsp (Changing any user details)
    	if (role.equalsIgnoreCase("doctor")) {
    		int id = (Integer) request.getAttribute("id"); 
    		DoctorDTO doctor = doctorService.get(id); 
    		model.addAttribute("doctor", doctor);
    		return "doctor-profile";
    	}
    	return "error";
    }

}
