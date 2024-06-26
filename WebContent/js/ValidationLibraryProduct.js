	function validateName(name) {
	    const re = /^.{2,25}$/;
	    return re.test(String(name));
	}
	
	function validateDescription(description) {
	    const re = /^.{5,500}$/;
	    return re.test(String(description));
	}
	
	function validatePrice(price) {
	    const re = /^[0-9]+(\.[0-9]{1,2})?$/;
	    return re.test(String(price));
	}
	
	function validateQuantity(quantity) {
	    const re = /^[0-9]+$/;
	    return re.test(String(quantity));
	}
	
	function validateGenre(genre) {
	    const re = /^[a-zA-Z\s']{5,50}$/;
	    return re.test(String(genre));
	}
	
	function validateFormatoBook(formato) {
	    var formatiValidi = ["Cartaceo", "Digitale"];   
	    return formatiValidi.includes(formato);
	}
	
	function validateFormatoMusic(formato) {
	    var formatiValidi = ["Vinile", "CD"];   
	    return formatiValidi.includes(formato);
	}

	function validateYear(year) {
	    const currentYear = new Date().getFullYear();
	    const re = /^[0-9]{2,4}$/;
	    return re.test(String(year)) && year <= currentYear;
	}
	
	function validateISBN(ISBN) {
	    const re = /^(97(8|9))?\d{9}(\d|X)$/;
	    return re.test(String(ISBN));
	}
	
	function validateAuthor(author) {
	    const re = /^[a-zA-Z\s'.]{5,50}$/;
	    return re.test(String(author));
	}
	
	function validatePageNumber(pageNumber) {
	    const re = /^[0-9]+$/;
	    return re.test(String(pageNumber));
	}
	
	function validateTrackNumber(trackNumber) {
	    const re = /^[0-9]+$/;
	    return re.test(String(trackNumber));
	}
	
 	function validateMaterial(material) {
	    const re = /^[a-zA-Z\s]{4,50}$/;
	    return re.test(String(material));
	}
	
	function validateDimension(dimension) {
	    const re = /^[0-9]+(\.[0-9]{1,2})?$/;
	    return re.test(String(dimension));
	}
	