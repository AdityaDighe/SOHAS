package com.demo.health.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.health.util.JwtUtil;

import io.jsonwebtoken.Claims;

@WebFilter("/jwt")
public class JwtAuthenticationFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public JwtAuthenticationFilter() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
		  HttpServletResponse res = (HttpServletResponse) response;
	      HttpServletRequest req = (HttpServletRequest) request;

	        String authHeader = req.getHeader("Authorization");

	        String path = request.getRequestURI();

	        // Skip JWT check for login endpoint
	        if (path.contains("/") || path.contains("/login") || path.contains("/doctorSignup") || path.contains("/patientSignup")) {
	            chain.doFilter(request, response);
	            return;
	        }
	        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
	            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing or invalid Authorization header");
	            return; // stop chain
	        }

	        String token = authHeader.substring(7); // remove "Bearer "

	        try {
	            Claims claims = JwtUtil.validateToken(token).getBody();
	            System.out.println(claims);
	            req.setAttribute("claims", claims);
	            chain.doFilter(request, response); // proceed only if valid
	        } catch (Exception e) {
	            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
	        }
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
