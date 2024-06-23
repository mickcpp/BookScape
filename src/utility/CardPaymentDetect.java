package utility;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public interface CardPaymentDetect {
	
	public static String detectCreditCardType(String cardNumber) {
        Map<String, Pattern> cardTypes = new HashMap<>();
        cardTypes.put("visa", Pattern.compile("^4"));
        cardTypes.put("mastercard", Pattern.compile("^5[1-5]"));

        // Scansiona attraverso i tipi di carta e determina il tipo
        for (Map.Entry<String, Pattern> entry : cardTypes.entrySet()) {
            String type = entry.getKey();
            Pattern pattern = entry.getValue();
            if (pattern.matcher(cardNumber).find()) {
                return type;
            }
        }
        
        return "unknown"; // Se non corrisponde a nessun tipo noto
    }
	
}
