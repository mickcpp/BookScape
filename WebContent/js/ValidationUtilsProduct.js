
	function validateLibro() {
		let isValid = validateForm();
		
	    const genere = document.getElementById('genere');
	    var formato = document.getElementById('formato');
	   	const anno = document.getElementById('anno');
	   	const ISBN = document.getElementById('ISBN');
	   	const autore = document.getElementById('autore');
	   	const numeroPagine = document.getElementById('numeroPagine');
	    
	    if (genere && !validateGenre(genere.value)) {
	    	if(genere.value.length < 3 || genere.value.length > 50) {
	    		showError(genere, "Il genere deve essere lungo minimo 3 e massimo 50 caratteri.");
		        isValid = false;
	    	} else{
				showError(genere, "Il genere può contenere solo lettere e apostrofi.");
		        isValid = false;
	    	}
	    }
	   
		if (!validateFormatoBook(formato.value)) {
		    showError(formato, "Il formato può essere solo 'Cartaceo' o 'Digitale'.");
	        isValid = false;
		}
		
	    if (anno && !validateYear(anno.value)) {
	        showError(anno, "L'anno deve essere un numero valido e non superiore all'anno corrente.");
	        isValid = false;
	    }
	
	    if (ISBN && !validateISBN(ISBN.value)) {
	        showError(ISBN, "L'ISBN deve essere nel formato 978-1234567890.");
	        isValid = false;
	    }
	    
	    if (autore && !validateAuthor(autore.value)) {
	    	if(autore.value.length < 5 || autore.value.length > 50) {
	    		showError(autore, "L'autore deve essere lungo minimo 5 e massimo 50 caratteri.");
	            isValid = false;
	    	} else{
	    		showError(autore, "L'autore può contenere solo lettere, apostrofi e punti.");
	            isValid = false;
	    	}
	    }
	    
	    if (numeroPagine && !validatePageNumber(numeroPagine.value)) {
	        showError(numeroPagine, "Il numero di pagine deve essere un numero intero positivo.");
	        isValid = false;
	    }
	
	    return isValid;
	}
	
	
	function validateMusica() {
		let isValid = validateForm();
		
	    const genere = document.getElementById('genere');
	    var formato = document.getElementById('formato');
	    const anno = document.getElementById('anno');
	    const artista = document.getElementById('artista');
	    const numeroTracce = document.getElementById('numeroTracce');
	    
	    if (genere && !validateGenre(genere.value)) {
	    	if(genere.value.length < 3 || genere.value.length > 50) {
	    		showError(genere, "Il genere deve essere lungo minimo 3 e massimo 50 caratteri.");
		        isValid = false;
	    	} else{
				showError(genere, "Il genere può contenere solo lettere e apostrofi.");
		        isValid = false;
	    	}
	    }
	    
		if (!validateFormatoMusic(formato.value)) {
		    showError(formato, "Il formato può essere solo 'Vinile' o 'CD'.");
	        isValid = false;
		}
		
	    if (anno && !validateYear(anno.value)) {
	        showError(anno, "L'anno deve essere un numero valido e non superiore all'anno corrente.");
	        isValid = false;
	    }
	    
	    if (artista && !validateAuthor(artista.value)) {
	    	if(artista.value.length < 5 || artista.value.length > 50) {
	    		showError(artista, "L'artista deve essere lungo minimo 5 e massimo 50 caratteri.");
	            isValid = false;
	    	} else{
	    		showError(artista, "L'artista può contenere solo lettere, apostrofi e punti.");
	            isValid = false;
	    	}
	    }
	    
	    if (numeroTracce && !validateTrackNumber(numeroTracce.value)) {
	        showError(numeroTracce, "Il numero di tracce deve essere un numero intero positivo.");
	        isValid = false;
	    }
	
	    return isValid;
	}
	
	function validateGadget() {
		let isValid = validateForm();
		
	    const materiale = document.getElementById('materiale');
	    const altezza = document.getElementById('altezza');
	    const lunghezza = document.getElementById('lunghezza');
	    const larghezza = document.getElementById('larghezza');
	    
	    if (materiale && !validateMaterial(materiale.value)) {
	    	if(materiale.value.length < 4 || materiale.value.length > 50) {
	    		showError(materiale, "Il materiale deve essere lungo minimo 4 e massimo 50 caratteri.");
		        isValid = false;
	    	} else{
				showError(materiale, "Il materiale può contenere solo lettere.");
		        isValid = false;
	    	}
	    }
	    
	    if (altezza && !validateDimension(altezza.value)) {
	        showError(altezza, "L'altezza deve essere un numero positivo (massimo due decimali).");
	        isValid = false;
	    }
	    
	    if (lunghezza && !validateDimension(lunghezza.value)) {
	        showError(lunghezza, "La lunghezza deve essere un numero positivo (massimo due decimali).");
	        isValid = false;
	    }
	    
	    if (larghezza && !validateDimension(larghezza.value)) {
	        showError(larghezza, "La larghezza deve essere un numero positivo (massimo due decimali).");
	        isValid = false;
	    }
	
	    return isValid;
	}
	
	function validateForm() {
        let isValid = true;
		
      	const nome = document.getElementById('nome');
        const descrizione = document.getElementById('descrizione');
        const prezzo = document.getElementById('prezzo');
        const quantita = document.getElementById('quantity');
        
        resetErrors();

        if (!validateName(nome.value)) {
            showError(nome, "Il nome deve essere lungo minimo 2 e massimo 25 caratteri.");
            isValid = false;
        }
        
        if (!validateDescription(descrizione.value)) {
            showError(descrizione, "La descrizione deve essere lunga minimo 5 e massimo 500 caratteri.");
            isValid = false;
        }

        if (!validatePrice(prezzo.value)) {
            showError(prezzo, "Il prezzo deve essere un numero positivo (massimo due decimali).");
            isValid = false;
        }

        if (!validateQuantity(quantita.value)) {
            showError(quantita, "La quantità deve essere un numero intero positivo.");
            isValid = false;
        }

        return isValid;
	}
	