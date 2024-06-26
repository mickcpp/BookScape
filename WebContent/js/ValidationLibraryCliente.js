   	function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(String(email).toLowerCase());
    }
   	
   	function validateUsername(username) {
        const re = /^[a-zA-Z0-9_.]{3,20}$/;
        return re.test(String(username));
    }

    function validateDate(date) {
        const currentDate = new Date();
        const inputDate = new Date(date);
        return inputDate < currentDate;
    }

    function validateCAP(cap) {
        const re = /^\d{5}$/;
        return re.test(String(cap));
    }

    function validateAlpha(input) {
	    const re = /^[a-zA-Z']{3,50}$/;
	    return re.test(String(input));
	}

    function validateName(input) {
        const trimInput = input.trim();
        const numeroSpazi = trimInput.split(' ').length - 1;

        if (numeroSpazi === 0) {
            return trimInput.length >= 3 && trimInput.length <= 50 && /^[a-zA-Z']+$/.test(trimInput);
            
        } else if (numeroSpazi === 1) {
        	
            const parole = trimInput.split(' ');
            const lunghezzaParola1 = parole[0].length;
            const lunghezzaParola2 = parole[1].length;

            // Verifica che entrambe le parole abbiano almeno 3 caratteri
            return lunghezzaParola1 >= 3 && lunghezzaParola2 >= 3 && trimInput.length <= 50 && /^[a-zA-Z'\s]+$/.test(trimInput);
        } else {
            return false;
        }
    }
    
    function validateAlphaNumericWithSpaces(input) {
        const re = /^[a-zA-Z0-9'\s]{3,50}$/;  // Accetta lettere, numeri e spazi, lunghezza minima 3
        const containsLetter = /[a-zA-Z]/.test(input);  // Verifica se c'è almeno una lettera
        return containsLetter && re.test(String(input));
    }
	
    function isValidCardNumber(input) {
        // Rimuove gli spazi dal numero della carta di credito
        let cleanedNumber = input.replace(/\s+/g, '');

        // Verifica che il numero abbia 16 cifre
        if (!/^\d{16}$/.test(cleanedNumber)) {
            return false;
        }
        
     	// Verifica se tutti i numeri sono uguali (es. "0000000000000000")
        if (/^(\d)\1{15}$/.test(cleanedNumber)) {
            return false;
        }	
        
        if (detectCreditCardType(cleanedNumber) == "unknown"){
            return false;
        }
/*
        // Applica l'algoritmo di Luhn
        let sum = 0;
        let shouldDouble = false;
        for (let i = cleanedNumber.length - 1; i >= 0; i--) {
            let digit = parseInt(cleanedNumber.charAt(i), 10);

            if (shouldDouble) {
                if ((digit *= 2) > 9) digit -= 9;
            }

            sum += digit;
            shouldDouble = !shouldDouble;
        }

        // Il numero è valido se la somma totale è un multiplo di 10
        return (sum % 10 === 0);
*/		
		return true;
    }

    function validateDataScadenza(input) {
        // Verifica che l'input abbia il formato corretto "YYYY-MM"
        if (!/^\d{4}-\d{2}$/.test(input)) {
            return false;
        }

        // Ottiene l'anno e il mese dall'input
        let parts = input.split('-');
        let year = parseInt(parts[0], 10);
        let month = parseInt(parts[1], 10) - 1; // Sottrae 1 per il mese, dato che JavaScript usa un indice base 0

        // Crea una data di scadenza usando il mese successivo al valore inserito
        let expiryDate = new Date(year, month + 1);
        
        let currentDate = new Date();
        
        return expiryDate > currentDate;
    }
    
    function validateCvv(input) {
        return /^\d{3}$/.test(input);
    }
    