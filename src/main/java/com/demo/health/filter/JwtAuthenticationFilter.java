package com.demo.health.filter;
 
import java.io.IOException;
import java.util.Collections;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.demo.health.dto.DoctorDTO;
import com.demo.health.dto.PatientDTO;
import com.demo.health.service.DoctorService;
import com.demo.health.service.PatientService;
import com.demo.health.util.JwtUtil;

import io.jsonwebtoken.Claims;
 
/*
 JWT Authentication Filter for protecting secured endpoints.
*/
@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter{
 
    @Autowired
    private PatientService patientService;
    @Autowired
    private DoctorService doctorService;
    
    
	public JwtAuthenticationFilter() {
        super();
    }
 
    @Override
    public void destroy() {
        // nothing special to destroy
    }
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException  {
    	HttpServletRequest req = (HttpServletRequest) request;
    	HttpServletResponse res = (HttpServletResponse) response;
        String jwtToken = getJwtFromCookies(req);
        String path = req.getRequestURI();
        String authHeader = req.getHeader("Authorization");
//        Public Endpoints :
        if(path.contains("/login")
                || path.contains("/doctorSignup")
                || path.contains("/patientSignup")
                || path.contains("/forgot-password")
                || path.contains("/signup")
                || path.contains("/api/reset-password")
                || path.contains("/api/request-otp")
        		|| path.contains("/api/login")) {
        	chain.doFilter(req, res);
        	return ;
        }
       
//      if token in Cookie then used to display the name : (only for home page) :
        if (path.equals(req.getContextPath() + "/")) {           
            try {
            	
                Claims claims = JwtUtil.validateToken(jwtToken).getBody();
                int id = claims.get("id", Integer.class);
                String role = claims.get("role", String.class);
                
                if (role.equalsIgnoreCase("patient")) {
                    PatientDTO p = patientService.get(id);
                    req.setAttribute("username", p.getPatientName());
                } else if (role.equalsIgnoreCase("doctor")) {
                    DoctorDTO d = doctorService.get(id);          
                    req.setAttribute("username", d.getDoctorName());     
                }
                req.setAttribute("id", claims.get("id", Integer.class));
                req.setAttribute("role", claims.get("role", String.class));
                chain.doFilter(req, res);
                return;
            } catch (Exception e) {
            	chain.doFilter(req, res);
            	return;
            }
            
        }
        
//      Protected endpoints through jwtToken in cookie :
        if (path.contains("/doctorDashboard") || path.contains("/patientDashboard") || path.contains("/profile")) {           
        	try {
            	
                Claims claims = JwtUtil.validateToken(jwtToken).getBody();
                int id = claims.get("id", Integer.class);
                String role = claims.get("role", String.class);
                String email = claims.getSubject();
                if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                    UsernamePasswordAuthenticationToken auth =
                        new UsernamePasswordAuthenticationToken(email, null, Collections.emptyList());
                    SecurityContextHolder.getContext().setAuthentication(auth);
                 }
                
                if (role.equalsIgnoreCase("patient")) {
                    PatientDTO p = patientService.get(id);
                    req.setAttribute("username", p.getPatientName());
                } else if (role.equalsIgnoreCase("doctor")) {
                    DoctorDTO d = doctorService.get(id);          
                    req.setAttribute("username", d.getDoctorName());     
                }
                req.setAttribute("id", claims.get("id", Integer.class));
                req.setAttribute("role", claims.get("role", String.class));
                chain.doFilter(req, res);
                return;
            } catch (Exception e) {
            	res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
            	return;
            }
        }
        
 
//      Protected endpoints in backend :
        if (authHeader == null) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing JWT cookie");
            return;
        }
        String token = authHeader.substring(7); // Remove Bearer
        try {
        	
            Claims claims = JwtUtil.validateToken(token).getBody();
            int id = claims.get("id", Integer.class);
            String role = claims.get("role", String.class);
            String email = claims.getSubject();
            if (email != null && SecurityContextHolder.getContext().getAuthentication() == null) {
                UsernamePasswordAuthenticationToken auth =
                    new UsernamePasswordAuthenticationToken(email, null, Collections.emptyList());
                SecurityContextHolder.getContext().setAuthentication(auth);
             }
            
            if (role.equalsIgnoreCase("patient")) {
                PatientDTO p = patientService.get(id);
                req.setAttribute("username", p.getPatientName());
            } else if (role.equalsIgnoreCase("doctor")) {
                DoctorDTO d = doctorService.get(id);          
                req.setAttribute("username", d.getDoctorName());     
            }
            
            req.setAttribute("id", claims.get("id", Integer.class));
            req.setAttribute("role", claims.get("role", String.class));
            chain.doFilter(req, res);
            return;
        } catch (Exception e) {
        	res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
        	return;
        }
    }

    private String getJwtFromCookies(HttpServletRequest req) {
        if (req.getCookies() != null) {
            for (Cookie cookie : req.getCookies()) {
                if ("jwtToken".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }
 
   
}