package utility;

public interface ValidationUtilsCliente {

	public static String validateInputsLogin(String id, String password) {
		 if (id.contains("@")) {
            if (!ValidationLibraryCliente.validateEmail(id) || password.length() < 8) {
                return "Email o password errata!";
            }
        } else {
            if (!ValidationLibraryCliente.validateUsername(id) || password.length() < 8) {
             	 return "Username o password errata!";
            }
        }
       return null;
	}
	
	public static String validateInputsSignup(String email, String username, String password, String nome, String cognome, String dataNascita, String citta, String via, String CAP) {
        if (!ValidationLibraryCliente.validateEmail(email)) {
            return "Inserisci un'email valida.";
        }
        if (!ValidationLibraryCliente.validateUsername(username)) {
        	if (username.length() > 20) {
        		return "L'username può essere lungo al massimo 20 caratteri";
        	} else if (username.length() < 3) {
                return "L'username deve essere lungo almeno 3 caratteri";
            } else {
                return "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.";
            }
        }
        if (password.length() < 8) {
            return "La password deve essere lunga almeno 8 caratteri.";
        }
        if (!ValidationLibraryCliente.validateName(nome)) {
        	if (nome.length() > 50) {
        		return "Il nome può essere lungo al massimo 50 caratteri";
        	} else if (nome.length() < 3) {
                return "Il nome deve essere lungo almeno 3 caratteri";
            } else {
                return "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)";
            }
        }
        if (!ValidationLibraryCliente.validateAlpha(cognome)) {
        	if (cognome.length() > 50) {
        		return "Il cognome può essere lungo al massimo 50 caratteri";
        	} else {
        		 return "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.";
        	}
        }
        if (!ValidationLibraryCliente.validateDate(dataNascita)) {
            return "Inserisci una data di nascita valida.";
        }
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(citta)) {
        	if (citta.length() > 50) {
        		return "La città può essere lunga al massimo 50 caratteri";
        	} else {
                return "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(via)) {
        	if (via.length() > 50) {
        		return "La via può essere lunga al massimo 50 caratteri";
        	} else {
                return "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        if (!ValidationLibraryCliente.validateCAP(CAP)) {
            return "Inserisci un CAP valido.";
        }
        return null;
    }
	
    public static String validateDatiPersonali(String username, String nome, String cognome, String dataNascita) {
        
        if (!ValidationLibraryCliente.validateUsername(username)) {
        	if (username.length() > 20) {
        		return "L'username può essere lungo al massimo 20 caratteri";
        	} else if (username.length() < 3) {
                return "L'username deve essere lungo almeno 3 caratteri";
            } else {
                return "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.";
            }
        }
      
        if (!ValidationLibraryCliente.validateName(nome)) {
        	if (nome.length() > 50) {
        		return "Il nome può essere lungo al massimo 50 caratteri";
        	} else if (nome.length() < 3) {
                return "Il nome deve essere lungo almeno 3 caratteri";
            } else {
                return "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)";
            }
        }
        if (!ValidationLibraryCliente.validateAlpha(cognome)) {
        	if (cognome.length() > 50) {
        		return "Il cognome può essere lungo al massimo 50 caratteri";
        	} else {
        		 return "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.";
        	}
        }
        if (!ValidationLibraryCliente.validateDate(dataNascita)) {
            return "Inserisci una data di nascita valida.";
        }
        
        return null;
    }
    
    public static String validateIndirizzo(String via, String citta, String CAP) {
    	
    	if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(citta)) {
        	if (citta.length() > 50) {
        		return "La città può essere lunga al massimo 50 caratteri";
        	} else {
                return "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(via)) {
        	if (via.length() > 50) {
        		return "La via può essere lunga al massimo 50 caratteri";
        	} else {
                return "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        if (!ValidationLibraryCliente.validateCAP(CAP)) {
            return "Inserisci un CAP valido.";
        }
        
        return null;
    }
    
    public static String validatePagamento(String nomeCarta, String numeroCarta, String dataScadenza, String cvv) {
    	
    	if (!ValidationLibraryCliente.validateName(nomeCarta)) {
        	return "Inserisci un nome valido.";
        }
        if (!ValidationLibraryCliente.isValidCardNumber(numeroCarta)) {
        	return "Inserisci un numero di carta valido (Visa/Mastercard).";
        }
        if (!ValidationLibraryCliente.validateDataScadenza(dataScadenza)) {
        	return "La carta di credito è scaduta o la data di scadenza non è nel formato corretto.";
        }
        if (!ValidationLibraryCliente.validateCvv(cvv)) {
            return "Inserisci un cvv valido.";
        }
        
        return null;
    }
    
    public static String validateFormShipping(String nome, String cognome, String indirizzo) {
        
    	String[] parti = indirizzo.split(",\\s*");
     	var via = "";
	    var citta = "";
	    var CAP = "";
			
        if (!ValidationLibraryCliente.validateName(nome)) {
        	if (nome.length() > 50) {
        		return "Il nome può essere lungo al massimo 50 caratteri";
        	} else if (nome.length() < 3) {
	        	return "Il nome deve essere lungo almeno 3 caratteri";
        	} else{
        		return "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)";
        	}
        }

        if (!ValidationLibraryCliente.validateAlpha(cognome)) {
        	if (cognome.length() > 50) {
        		return "Il cognome può essere lungo al massimo 50 caratteri";
        	} else{
        		return "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.";
        	}
        }
        
        if(parti.length == 3){
			via = parti[0].trim();
		    citta = parti[1].trim();
		    CAP = parti[2].trim();
		} else {
			return "Inserisci un indirizzo valido, rispettando il formato.";
		}
        
        if (!ValidationLibraryCliente.validateCAP(CAP)) {
            return "Inserisci un CAP valido.";
        }
        
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(citta)) {
        	if (citta.length() > 50) {
	        	return "La città può essere lunga al massimo 50 caratteri";
        	} else{
        		return "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(via)) {
        	if (via.length() > 50) {
	        	return "La via può essere lunga al massimo 50 caratteri";
        	} else{
        		return "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        
        return null;
   	}	
}
