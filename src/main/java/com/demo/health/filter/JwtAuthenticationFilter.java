package com.demo.health.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.demo.health.util.JwtUtil;

import io.jsonwebtoken.Claims;

@WebFilter("/*")
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
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	@Override
	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletResponse res = response;
		HttpServletRequest req = request;

		String jwtToken = getJwtFromCookies(req);
		;

		String path = request.getRequestURI();

		// Skip JWT check for login endpoint
		if (path.equals(req.getContextPath() + "/") || path.contains("/login") || path.contains("/doctorSignup")
				|| path.contains("/patientSignup") || path.endsWith("index.jsp") || path.contains("/forgot-password")) {
			
			try {
				Claims claims = JwtUtil.validateToken(jwtToken).getBody();

				// Extract username + id
				String username = claims.getSubject();
				Integer id = claims.get("id", Integer.class);
				String role = claims.get("role", String.class);

				// Attach to request attributes so controllers can use them
				req.setAttribute("username", username);
				req.setAttribute("id", id);
				req.setAttribute("role", role);
				
				chain.doFilter(req, res); // proceed only if valid
			} catch (Exception e) {
				chain.doFilter(req,res);
				
			}
			
			return;
		}

		if (jwtToken == null) {
			res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing JWT cookie");
			return;
		}

		try {
			Claims claims = JwtUtil.validateToken(jwtToken).getBody();

			// Extract username + id
			String username = claims.getSubject();
			Integer id = claims.get("id", Integer.class);
			String role = claims.get("role", String.class);

			// Attach to request attributes so controllers can use them
			req.setAttribute("username", username);
			req.setAttribute("id", id);
			req.setAttribute("role", role);
			
			chain.doFilter(req, res); // proceed only if valid
		} catch (Exception e) {
			res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
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

	/**
	 * @see Filter#init(FilterConfig)
	 */
	@Override
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
