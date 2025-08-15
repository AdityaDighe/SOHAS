package com.demo.health.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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

    @GetMapping
    public List<Appointment> listAppointments() {
        return appointService.list();
    }

    @PutMapping("/{id}")
    public void updateAppointment(@PathVariable int id, @RequestBody Map<String, String> request) {
        Appointment apt = appointService.get(id);
        if (apt != null) {
            String status = request.get("status");
        	apt.setStatus(status);
            appointService.updateStatus(apt);
        }
    }

    
}
