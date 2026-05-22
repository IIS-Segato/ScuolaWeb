package utils;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;

public class PasswordUtils {

	private static final String PEPPER = "ScuolaFacilePepper2026";

	// Hash unico usato per tutte le password dell'applicazione.
	public static String hash(String password) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] digest = md.digest((password + PEPPER).getBytes(StandardCharsets.UTF_8));
			StringBuilder sb = new StringBuilder();

			for (byte b : digest) {
				sb.append(String.format("%02x", b));
			}

			return sb.toString();
		} catch (Exception e) {
			throw new RuntimeException("Errore durante la cifratura della password", e);
		}
	}

	public static boolean matches(String password, String storedPassword) {
		if (password == null || storedPassword == null) {
			return false;
		}

		// Compatibilita temporanea con gli account storici salvati in chiaro.
		return hash(password).equalsIgnoreCase(storedPassword) || password.equals(storedPassword);
	}

	public static boolean isHashed(String password) {
		return password != null && password.matches("(?i)[0-9a-f]{32}");
	}
}
