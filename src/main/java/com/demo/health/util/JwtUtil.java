package com.demo.health.util;

import java.security.Key;
import java.util.Date;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

public class JwtUtil {
//    private static final Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
	private static final String SECRET = "my-very-strong-secret-key-for-jwt-signing-which-should-be-long";
	private static final Key key = Keys.hmacShaKeyFor(SECRET.getBytes());

	private static final long EXPIRATION_MS = 3600000; // 1 hour

    public static String generateToken(int id, String email, String role) {
        return Jwts.builder()
                .setSubject(email)
                .claim("id", id)
                .claim("role", role)
                .setIssuer("SOHAS")
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_MS))
                .signWith(key)
                .compact();
    }

   
    public static Jws<Claims> validateToken(String token) throws JwtException {
        return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
    }
    
    
}
