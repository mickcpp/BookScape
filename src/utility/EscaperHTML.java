package utility;

import java.util.HashMap;
import java.util.Map;

public class EscaperHTML {
    private static final Map<Character, String> escapeMap = new HashMap<>();

    static {
        escapeMap.put('<', "&lt;");
        escapeMap.put('>', "&gt;");
        escapeMap.put('&', "&amp;");
        escapeMap.put('"', "&quot;");
        escapeMap.put('\'', "&#x27;");
        escapeMap.put('/', "&#x2F;");
    }

    public static String escapeHTML(String input) {
        if (input == null) {
            return null;
        }
        StringBuilder escaped = new StringBuilder();
        for (char c : input.toCharArray()) {
            String replacement = escapeMap.get(c);
            if (replacement != null) {
                escaped.append(replacement);
            } else {
                escaped.append(c);
            }
        }
        return escaped.toString();
    }
}
