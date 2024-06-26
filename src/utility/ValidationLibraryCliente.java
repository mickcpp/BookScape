package utility;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.regex.Pattern;

public interface ValidationLibraryCliente {
	
	public static boolean validateEmail(String email) {
        String regex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        return Pattern.compile(regex).matcher(email).matches();
    }

	public static boolean validateUsername(String username) {
        String regex = "^[a-zA-Z0-9_.]{3,20}$";
        return Pattern.compile(regex).matcher(username).matches();
    }

	public static boolean validateDate(String date) {
        LocalDate currentDate = LocalDate.now();
        LocalDate inputDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return inputDate.isBefore(currentDate);
    }

	public static boolean validateCAP(String cap) {
        String regex = "^\\d{5}$";
        return Pattern.compile(regex).matcher(cap).matches();
    }

	public static boolean validateAlpha(String input) {
        String regex = "^[a-zA-Z']{3,50}$";
        return Pattern.compile(regex).matcher(input).matches();
    }

    public static boolean validateName(String input) {
        String trimInput = input.trim();
        int numeroSpazi = trimInput.split(" ").length - 1;

        if (numeroSpazi == 0) {
            return trimInput.length() >= 3 && trimInput.length() <= 50 && trimInput.matches("^[a-zA-Z']+$");
        } else if (numeroSpazi == 1) {
            String[] parole = trimInput.split(" ");
            int lunghezzaParola1 = parole[0].length();
            int lunghezzaParola2 = parole[1].length();

            // Verifica che entrambe le parole abbiano almeno 3 caratteri
            return lunghezzaParola1 >= 3 && lunghezzaParola2 >= 3 && trimInput.length() <= 50 && trimInput.matches("^[a-zA-Z'\\s]+$");
        } else {
            return false;
        }
    }

    public static boolean validateAlphaNumericWithSpaces(String input) {
        String regex = "^[a-zA-Z0-9'\\s]{3,50}$";
        boolean containsLetter = Pattern.compile("[a-zA-Z]").matcher(input).find();
        return containsLetter && Pattern.compile(regex).matcher(input).matches();
    }
    
    public static boolean isValidCardNumber(String input) {
        // Rimuove gli spazi dal numero della carta di credito
        String cleanedNumber = input.replaceAll("\\s+", "");

        // Verifica che il numero abbia 16 cifre
        if (!cleanedNumber.matches("^\\d{16}$")) {
            return false;
        }

        // Verifica se tutti i numeri sono uguali (es. "0000000000000000")
        if (cleanedNumber.matches("^(\\d)\\1{15}$")) {
            return false;
        }
        
        if (CardPaymentDetect.detectCreditCardType(cleanedNumber).equalsIgnoreCase("unknown")) {
            return false;
        }
        
        return true;
    }

    public static boolean validateDataScadenza(String input) {
        // Verifica che l'input abbia il formato corretto "YYYY-MM"
        if (!input.matches("^\\d{4}-\\d{2}$")) {
            return false;
        }

        // Ottiene l'anno e il mese dall'input
        String[] parts = input.split("-");
        int year = Integer.parseInt(parts[0]);
        int month = Integer.parseInt(parts[1]) - 1; // Sottrae 1 per il mese, dato che Java usa un indice base 0

        // Crea un oggetto YearMonth per la data di scadenza
        YearMonth expiryYearMonth = YearMonth.of(year, month + 1);

        // Ottiene la data corrente
        LocalDate currentDate = LocalDate.now();

        // Confronta la data di scadenza con la data corrente
        return expiryYearMonth.atEndOfMonth().isAfter(currentDate);
    }

    public static boolean validateCvv(String input) {
        // Verifica che il CVV sia composto da 3 cifre numeriche
        return input.matches("^\\d{3}$");
    }
}
