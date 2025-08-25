package com.demo.health.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.demo.health.entity.Doctor;
import com.demo.health.entity.Patient;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;

@Component
public class CustomUserDetailsService implements UserDetailsService {

  @Autowired
  private PatientService patientService;
  
  @Autowired
  private DoctorService doctorService;

  @Override
  public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
	 
	  Patient patient = patientService.findByEmail(email);
      if (patient != null) {
          return new CustomUserDetails(
                  patient.getPatientId(),
                  patient.getEmail(),
                  patient.getPassword(),
                  "PATIENT"
          );
      }

      Doctor doctor = doctorService.findByEmail(email);
      if (doctor != null) {
          return new CustomUserDetails(
                  doctor.getDoctorId(),
                  doctor.getEmail(),
                  doctor.getPassword(),
                  "DOCTOR"
          );
      }

      throw new UsernameNotFoundException("User not found with email: " + email);
  }
}
