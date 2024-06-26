	
	function validateSignupForm() {
	    let isValid = true;
	
	    const email = document.getElementById('email');
	    const username = document.getElementById('username');
	    const password = document.getElementById('password');
	    const nome = document.getElementById('nome');
	    const cognome = document.getElementById('cognome');
	    const dataNascita = document.getElementById('dataNascita');
	    const citta = document.getElementById('citta');
	    const via = document.getElementById('via');
	    const CAP = document.getElementById('CAP');
	    
	    resetErrors();
	
	    if (!validateEmail(email.value)) {
	        showError(email, "Inserisci un'email valida.");
	        isValid = false;
	    }
	    
	    if (!validateUsername(username.value)) {
	    	if (username.value.length > 20) {
	        	showError(username, "L'username può essere lungo al massimo 20 caratteri");
	            isValid = false;
	    	} else if (username.value.length < 3) {
	        	showError(username, "L'username deve essere lungo almeno 3 caratteri");
	            isValid = false;
	    	} else{
	    		showError(username, "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.");
	            isValid = false;
	    	}
	    }
	
	    if (password.value.length < 8) {
	        showError(password, "La password deve essere lunga almeno 8 caratteri.");
	        isValid = false;
	    }
	
	    if (!validateName(nome.value)) {
	    	if (nome.value.length > 50) {
	        	showError(nome, "Il nome può essere lungo al massimo 50 caratteri");
	            isValid = false;
	    	} else if (nome.value.length < 3) {
	        	showError(nome, "Il nome deve essere lungo almeno 3 caratteri");
	            isValid = false;
	    	} else{
	    		showError(nome, "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)");
	            isValid = false;
	    	}
	    }
	
	    if (!validateAlpha(cognome.value)) {
	    	if (cognome.value.length > 50) {
	        	showError(cognome, "Il cognome può essere lungo al massimo 50 caratteri");
	            isValid = false;
	    	} else{
	    		showError(cognome, "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.");
		        isValid = false;
	    	}
	    }
	
	    if (!validateDate(dataNascita.value)) {
	        showError(dataNascita, "Inserisci una data di nascita valida.");
	        isValid = false;
	    }
	
	    if (!validateAlphaNumericWithSpaces(citta.value)) {
	    	if (citta.value.length > 50) {
	        	showError(citta, "La città può essere lunga al massimo 50 caratteri");
	            isValid = false;
	    	} else{
	    		showError(citta, "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
	            isValid = false;
	    	}
	    }
	    
	    if (!validateAlphaNumericWithSpaces(via.value)) {
	    	if (via.value.length > 50) {
	        	showError(via, "La via può essere lunga al massimo 50 caratteri");
	            isValid = false;
	    	} else{
	    		showError(via, "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
	            isValid = false;
	    	}
	    }
	
	    if (!validateCAP(CAP.value)) {
	        showError(CAP, "Inserisci un CAP valido.");
	        isValid = false;
	    }
	
	    return isValid;
	}
	
	function validateLoginForm() {
        let isValid = true;
        const id = document.getElementById('login-id');
        const password = document.getElementById('login-password');

        resetErrors();

        if (id.value.includes('@')) {
            if (!validateEmail(id.value) || password.value.length < 8) {
                showError("Email o password errate!");
                isValid = false;
            }
        } else {
            if (!validateUsername(id.value) || password.value.length < 8) {
                showError("Username o password errati!");
                isValid = false;
            }
        }
        return isValid;
   	}	
   	
   	function validateFormPayment() {
        let isValid = true;
     
     	const nomeCarta = document.getElementById('nomeCarta');
     	const numeroCarta = document.getElementById('numeroCarta');
     	const dataScadenza = document.getElementById('dataScadenza');
     	const cvv = document.getElementById('cvv');
     	
        resetErrors();
        
        if (!validateName(nomeCarta.value)) {
            showError(nomeCarta, "Inserisci un nome valido.");
            isValid = false;
        }
        
        if (!isValidCardNumber(numeroCarta.value)) {
        	showError(numeroCarta, "Inserisci un numero di carta valido (Visa/Mastercard).");
            isValid = false;
        }
        
        if (!validateDataScadenza(dataScadenza.value)) {
        	showError(dataScadenza, "La carta di credito è scaduta o la data di scadenza non è nel formato corretto.");
            isValid = false;
        }
        
        if (!validateCvv(cvv.value)) {
        	showError(cvv, "Inserisci un cvv valido.");
            isValid = false;
        }

        return isValid;
   	}	
   	
   	function validateFormPersonalData() {
        let isValid = true;
        
        const username = document.getElementById('username');
        const nome = document.getElementById('nome');
        const cognome = document.getElementById('cognome');
        const dataNascita = document.getElementById('dataNascita');
        
        resetErrors();
        
        if (!validateUsername(username.value)) {
        	if (username.value.length > 20) {
	        	showError(username, "L'username può essere lungo al massimo 20 caratteri");
	            isValid = false;
        	} else if (username.value.length < 3) {
	        	showError(username, "L'username deve essere lungo almeno 3 caratteri");
	            isValid = false;
        	} else{
        		showError(username, "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.");
	            isValid = false;
        	}
        }

        if (!validateName(nome.value)) {
        	if (nome.value.length > 50) {
	        	showError(nome, "Il nome può essere lungo al massimo 50 caratteri");
	            isValid = false;
        	} else if (nome.value.length < 3) {
	        	showError(nome, "Il nome deve essere lungo almeno 3 caratteri");
	            isValid = false;
        	} else{
        		showError(nome, "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)");
	            isValid = false;
        	}
        }

        if (!validateAlpha(cognome.value)) {
        	if (cognome.value.length > 50) {
	        	showError(cognome, "Il cognome può essere lungo al massimo 50 caratteri");
	            isValid = false;
        	} else{
        		showError(cognome, "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.");
		        isValid = false;
        	}
        }

        if (!validateDate(dataNascita.value)) {
            showError(dataNascita, "Inserisci una data di nascita valida.");
            isValid = false;
        }

        return isValid;
   	}
   	
   	function validateFormAddress() {
        let isValid = true;
     
     	const indirizzo = document.getElementById('indirizzo');
     	const parti = indirizzo.value.split(',');
     	
     	if(parti.length != 3){
     		showError(indirizzo, "Inserisci un indirizzo valido, rispettando il formato.");
            isValid = false;
            return isValid;
		}
     	
	    const via = parti[0].trim();
	    const citta = parti[1].trim();
	    const CAP = parti[2].trim();
        
        resetErrors();
        
        if (!validateCAP(CAP)) {
            showError(indirizzo, "Inserisci un CAP valido.");
            isValid = false;
        }
        
        if (!validateAlphaNumericWithSpaces(citta)) {
        	if (citta.length > 50) {
	        	showError(indirizzo, "La città può essere lunga al massimo 50 caratteri");
	            isValid = false;
        	} else{
        		showError(indirizzo, "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
	            isValid = false;
        	}
        }
        
        if (!validateAlphaNumericWithSpaces(via)) {
        	if (via.length > 50) {
	        	showError(indirizzo, "La via può essere lunga al massimo 50 caratteri");
	            isValid = false;
        	} else{
        		showError(indirizzo, "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
	            isValid = false;
        	}
        }
        return isValid;
   	}	
   	
   	function validateFormShipping() {
        let isValid = true;
     
        const nome = document.getElementById('nomeSpedizione');
        const cognome = document.getElementById('cognomeSpedizione');
     	const indirizzo = document.getElementById('indirizzoSpedizione');
     	const parti = indirizzo.value.split(',');
     	var via = "";
	    var citta = "";
	    var CAP = "";
        
        resetErrors();
			
        if (!validateName(nome.value)) {
        	if (nome.value.length > 50) {
	        	showError(nome, "Il nome può essere lungo al massimo 50 caratteri");
	            isValid = false;
        	} else if (nome.value.length < 3) {
	        	showError(nome, "Il nome deve essere lungo almeno 3 caratteri");
	            isValid = false;
        	} else{
        		showError(nome, "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)");
	            isValid = false;
        	}
        }

        if (!validateAlpha(cognome.value)) {
        	if (cognome.value.length > 50) {
	        	showError(cognome, "Il cognome può essere lungo al massimo 50 caratteri");
	            isValid = false;
        	} else{
        		showError(cognome, "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.");
		        isValid = false;
        	}
        }
        
        if(parti.length == 3){
			via = parti[0].trim();
		    citta = parti[1].trim();
		    CAP = parti[2].trim();
		} else {
			showError(indirizzo, "Inserisci un indirizzo valido, rispettando il formato.");
            isValid = false;
            return isValid;
		}
        
        if (!validateCAP(CAP)) {
            showError(indirizzo, "Inserisci un CAP valido.");
            isValid = false;
        }
        
        if (!validateAlphaNumericWithSpaces(citta)) {
        	if (citta.length > 50) {
	        	showError(indirizzo, "La città può essere lunga al massimo 50 caratteri");
	            isValid = false;
        	} else{
        		showError(indirizzo, "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
	            isValid = false;
        	}
        }
        
        if (!validateAlphaNumericWithSpaces(via)) {
        	if (via.length > 50) {
	        	showError(indirizzo, "La via può essere lunga al massimo 50 caratteri");
	            isValid = false;
        	} else{
        		showError(indirizzo, "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
	            isValid = false;
        	}
        }
        return isValid;
   	}	
	