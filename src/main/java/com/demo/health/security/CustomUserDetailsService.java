package com.demo.health.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;
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
	 
	  PatientDTO patient = patientService.findByEmail(email);
      if (patient != null) {
          return new CustomUserDetails(
                  patient.getPatientId(),
                  patient.getEmail(),
                  patient.getPassword(),
                  "PATIENT"
          );
      }

      DoctorDTO doctor = doctorService.findByEmail(email);
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
