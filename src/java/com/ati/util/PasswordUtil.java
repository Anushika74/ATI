package com.ati.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

/**
 * Simple SHA-256 password hashing utility.
 * Passwords are never stored in plain text in the database.
 */
public class PasswordUtil {

    /** Returns the SHA-256 hash of the given text as a hex string. */
    public static String hash(String plain) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(plain.getBytes(StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Unable to hash password", e);
        }
    }

    /** Verifies a plain text password against a stored hash. */
    public static boolean verify(String plain, String storedHash) {
        return hash(plain).equals(storedHash);
    }
}
