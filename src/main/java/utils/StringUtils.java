package utils;

public class StringUtils {
	public static final String STRING_EMPTY = "";

	private StringUtils() {
	}

	public static String escapeHtml(String value) {
		if (value == null) {
			return STRING_EMPTY;
		}

		return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;")
				.replace("'", "&#39;");
	}
}
