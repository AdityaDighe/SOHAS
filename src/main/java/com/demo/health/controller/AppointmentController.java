package com.demo.health.controller;

import com.demo.health.entity.Appointment;
import com.demo.health.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @PostMapping("/cancel/{id}")
    public void cancelAppointment(@PathVariable int id) {
        Appointment apt = appointService.get(id);
        if (apt != null) {
            apt.setStatus("CANCELLED");
            appointService.updateCancelStatus(apt);
        }
    }

    @PostMapping("/complete/{id}")
    public void completeAppointment(@PathVariable int id) {
        Appointment apt = appointService.get(id);
        if (apt != null) {
            apt.setStatus("COMPLETED");
            appointService.updateCompleteStatus(apt);
        }
    }
}
