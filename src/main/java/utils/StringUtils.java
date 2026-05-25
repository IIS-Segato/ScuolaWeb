package utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class StringUtils {
	public static final String STRING_EMPTY = "";
	

	public StringUtils() {
		
	}

	public static String encrypt(String password) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            byte[] hash = messageDigest.digest(password.getBytes("UTF-8"));
            StringBuilder stringBuilder = new StringBuilder();
            for (byte b : hash) {
                stringBuilder.append(String.format("%02x", b));
            }
            return stringBuilder.toString();
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
            throw new RuntimeException("Error while encrypting password: " + e.getMessage());
        }
    }
	
	public static boolean verificaPassword(String passwordInChiaro, String hashDalDb) {
	    return encrypt(passwordInChiaro).equals(hashDalDb);
	}
}
