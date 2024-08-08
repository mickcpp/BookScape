package utility;

import java.util.regex.Pattern;

public interface ValidationLibraryProduct {

    public static boolean validateName(String name) {
        String regex = "^.{2,40}$";
        return Pattern.matches(regex, name);
    }

    public static boolean validateDescription(String description) {
        String regex = "^.{5,500}$";
        return Pattern.matches(regex, description);
    }

    public static boolean validatePrice(String price) {
        String regex = "^[0-9]+(\\.[0-9]{1,2})?$";
        return Pattern.matches(regex, price);
    }

    public static boolean validateQuantity(String quantity) {
        String regex = "^[0-9]+$";
        return Pattern.matches(regex, quantity);
    }

    public static boolean validateGenre(String genre) {
        String regex = "^[a-zA-Z\\s'’/]{3,50}$";
        return Pattern.matches(regex, genre);
    }

    public static boolean validateFormatoBook(String formato) {
        String[] formatiValidi = {"Cartaceo", "Digitale"};
        for (String validFormat : formatiValidi) {
            if (validFormat.equals(formato)) {
                return true;
            }
        }
        return false;
    }

    public static boolean validateFormatoMusic(String formato) {
        String[] formatiValidi = {"Vinile", "CD"};
        for (String validFormat : formatiValidi) {
            if (validFormat.equals(formato)) {
                return true;
            }
        }
        return false;
    }

    public static boolean validateYear(String year) {
        int currentYear = java.time.Year.now().getValue();
        String regex = "^[0-9]{2,4}$";
        return Pattern.matches(regex, year) && Integer.parseInt(year) <= currentYear;
    }

    public static boolean validateISBN(String ISBN) {
        String regex = "^(97(8|9))?\\d{9}(\\d|X)$";
        return Pattern.matches(regex, ISBN);
    }

    public static boolean validateAuthor(String author) {
        String regex = "^[a-zA-Z\\s'’.]{5,50}$";
        return Pattern.matches(regex, author);
    }

    public static boolean validatePageNumber(String pageNumber) {
        String regex = "^[0-9]+$";
        return Pattern.matches(regex, pageNumber);
    }

    public static boolean validateTrackNumber(String trackNumber) {
        String regex = "^[0-9]+$";
        return Pattern.matches(regex, trackNumber);
    }

    public static boolean validateMaterial(String material) {
        String regex = "^[a-zA-Z\\s]{4,50}$";
        return Pattern.matches(regex, material);
    }

    public static boolean validateDimension(String dimension) {
        String regex = "^[0-9]+(\\.[0-9]{1,2})?$";
        return Pattern.matches(regex, dimension);
    }
}
