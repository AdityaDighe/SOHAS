package com.demo.health.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.demo.health.entity.Appointment;
import com.demo.health.service.AppointmentService;


@RestController
@RequestMapping("/appointment")
public class AppointmentController {
	@Autowired
	private AppointmentService appointService;
	
	@PostMapping
	public void addAppointment(@RequestBody Appointment appointment) {
		appointService.save(appointment);
	}
	
	@GetMapping("/{id}")
	public Appointment getAppointment(@PathVariable int id) {
		return appointService.get(id);
	}
	
	@GetMapping
	public List<Appointment> listAppointment(){
		return appointService.list();
	}
	
	@PutMapping("/{id}")
	public void updateEmployee(@PathVariable int id, @RequestBody Appointment appointment) {
		appointment.setAppointmentId(id);
		appointService.update(appointment);
	}
	
	@DeleteMapping("/{id}")
	public void deleteEmployee(@PathVariable int id) {
		appointService.delete(id);
	} 
	
}
