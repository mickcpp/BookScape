function detectCreditCardType(cardNumber) {
    var cardTypes = {
        visa: /^4/,
        mastercard: /^5[1-5]/
    };

    // Scansiona attraverso i tipi di carta e determina il tipo
    for (var type in cardTypes) {
        if (cardTypes[type].test(cardNumber)) {
            return type;
        }
    }
    return 'unknown'; // Se non corrisponde a nessun tipo noto
}