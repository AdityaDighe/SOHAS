package com.demo.health.util;

import java.util.Random;

public class OtpUtil {

    // Generate 6-digit OTP
    public static String generateOtp() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }
}