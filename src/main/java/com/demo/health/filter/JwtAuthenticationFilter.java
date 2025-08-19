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

/**
 * JWT Authentication Filter for protecting secured endpoints.
 */
@WebFilter("/*")
public class JwtAuthenticationFilter extends HttpFilter implements Filter {

    public JwtAuthenticationFilter() {
        super();
    }

    @Override
    public void destroy() {
        // nothing special to destroy
    }

    @Override
    public void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        String jwtToken = getJwtFromCookies(req);
        String path = req.getRequestURI();

        // ✅ Public endpoints (no JWT required)
        if (path.equals(req.getContextPath() + "/")
                || path.contains("/login")
                || path.contains("/doctorSignup")
                || path.contains("/patientSignup")
                || path.endsWith("index.jsp")
                || path.contains("/forgot-password")
                || path.contains("/signup")
                || path.contains("/api/reset-password")
                || path.contains("/api/request-otp")) {
            
//            chain.doFilter(req, res); // let it pass without JWT
//            
            try {
                Claims claims = JwtUtil.validateToken(jwtToken).getBody();

                // Attach claims to request for controllers
                req.setAttribute("username", claims.getSubject());
                req.setAttribute("id", claims.get("id", Integer.class));
                req.setAttribute("role", claims.get("role", String.class));

                chain.doFilter(req, res); // proceed only if valid
            } catch (Exception e) {
            	chain.doFilter(req, res);
//                res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
            }
            return;
        }

        // Protected endpoints → JWT required
        if (jwtToken == null) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing JWT cookie");
            return;
        }

        try {
            Claims claims = JwtUtil.validateToken(jwtToken).getBody();

            // Attach claims to request for controllers
            req.setAttribute("username", claims.getSubject());
            req.setAttribute("id", claims.get("id", Integer.class));
            req.setAttribute("role", claims.get("role", String.class));

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

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // nothing special to init
    }
}
