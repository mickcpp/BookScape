package utility;

public interface ValidationUtilsProduct {
	
	public static String validateForm(String nome, String descrizione, String prezzo, String quantita) {
		
        if (!ValidationLibraryProduct.validateName(nome)) {
        	return "Il nome deve essere lungo minimo 2 e massimo 40 caratteri.";
        }

        if (!ValidationLibraryProduct.validateDescription(descrizione)) {
        	return "La descrizione deve essere lunga minimo 5 e massimo 500 caratteri.";
        }
        
        if (!ValidationLibraryProduct.validatePrice(prezzo)) {
            return "Il prezzo deve essere un numero positivo (massimo due decimali).";
        }
        
        if (!ValidationLibraryProduct.validateQuantity(quantita)) {
        	return "La quantità deve essere un numero intero positivo.";
        }
        
        return null;
   	}	
    
    public static String validateLibro(String nome, String descrizione, String prezzo, String quantita, String genere, String formato, String anno, String isbn, String autore, String numeroPagine) {
		
    	String errore = validateForm(nome, descrizione, prezzo, quantita);
    	if(errore != null) return errore;
    	
    	if (!ValidationLibraryProduct.validateGenre(genere)) {
    		if(genere.length() < 3 || genere.length() > 50) {
    			return "Il genere deve essere lungo minimo 3 e massimo 50 caratteri.";
    		} else {
    			return "Il genere può contenere solo lettere e apostrofi.";
    		}
        }

        if (!ValidationLibraryProduct.validateFormatoBook(formato)) {
        	return "Il formato può essere solo 'Cartaceo' o 'Digitale'.";
        }
        
        if (!ValidationLibraryProduct.validateYear(anno)) {
            return "L'anno deve essere un numero valido e non superiore all'anno corrente.";
        }
        
        if (!ValidationLibraryProduct.validateISBN(isbn)) {
        	return "L'ISBN deve essere nel formato 978-1234567890.";
        }
        
        if (!ValidationLibraryProduct.validateAuthor(autore)) {
    		if(autore.length() < 5 || autore.length() > 50) {
    			return "L'autore deve essere lungo minimo 5 e massimo 50 caratteri.";
    		} else {
    			return "L'autore può contenere solo lettere, apostrofi e punti.";
    		}
        }
        
        if (!ValidationLibraryProduct.validatePageNumber(numeroPagine)) {
        	return "Il numero di pagine deve essere un numero intero positivo.";
        }
        
        return null;
   	}
    
    public static String validateMusica(String nome, String descrizione, String prezzo, String quantita, String genere, String formato, String anno, String artista, String numeroTracce) {
		
    	String errore = validateForm(nome, descrizione, prezzo, quantita);
    	if(errore != null) return errore;
    	
    	if (!ValidationLibraryProduct.validateGenre(genere)) {
    		if(genere.length() < 3 || genere.length() > 50) {
    			return "Il genere deve essere lungo minimo 3 e massimo 50 caratteri.";
    		} else {
    			return "Il genere può contenere solo lettere e apostrofi.";
    		}
        }

        if (!ValidationLibraryProduct.validateFormatoMusic(formato)) {
        	return "Il formato può essere solo 'Vinile' o 'CD'.";
        }
        
        if (!ValidationLibraryProduct.validateAuthor(artista)) {
    		if(artista.length() < 5 || artista.length() > 50) {
    			return "L'artista deve essere lungo minimo 5 e massimo 50 caratteri.";
    		} else {
    			return "L'artista può contenere solo lettere, apostrofi e punti.";
    		}
        }
        
        if (!ValidationLibraryProduct.validateYear(anno)) {
            return "L'anno deve essere un numero valido e non superiore all'anno corrente.";
        }
        
        if (!ValidationLibraryProduct.validateTrackNumber(numeroTracce)) {
        	return "Il numero di tracce deve essere un numero intero positivo.";
        }
        
        return null;
   	}
    
   public static String validateGadget(String nome, String descrizione, String prezzo, String quantita, String materiale, String altezza, String lunghezza, String larghezza) {
		
    	String errore = validateForm(nome, descrizione, prezzo, quantita);
    	if(errore != null) return errore;
    	
    	if (!ValidationLibraryProduct.validateMaterial(materiale)) {
    		if(materiale.length() < 5 || materiale.length() > 50) {
    			return "Il materiale deve essere lungo minimo 4 e massimo 50 caratteri.";
    		} else {
    			return "Il materiale può contenere solo lettere.";
    		}
        }

        if (!ValidationLibraryProduct.validateDimension(altezza)) {
        	return "L'altezza deve essere un numero positivo (massimo due decimali).";
        }
        
        if (!ValidationLibraryProduct.validateDimension(lunghezza)) {
        	return "La lunghezza deve essere un numero positivo (massimo due decimali).";
        }
        
        if (!ValidationLibraryProduct.validateDimension(larghezza)) {
        	return "La larghezza deve essere un numero positivo (massimo due decimali).";
        }
        
        return null;
   	}
}
