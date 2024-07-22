<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
     <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-4">
        <h1 class="text-center">FAQ - Domande Frequenti</h1>
        <br>
        <p class="text-center">Benvenuti nella sezione FAQ di BookScape. Qui trovate le risposte alle domande più comuni.</p>
        
        <div class="accordion" id="faqAccordion">
            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading1">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1" aria-expanded="true" aria-controls="faq1">
                        Quali metodi di pagamento accettate?
                    </button>
                </h2>
                <div id="faq1" class="accordion-collapse collapse show" aria-labelledby="faqHeading1" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Accettiamo i seguenti metodi di pagamento: carte di credito (Visa, MasterCard).
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading2">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2" aria-expanded="false" aria-controls="faq2">
                        Quanto tempo ci vuole per ricevere il mio ordine?
                    </button>
                </h2>
                <div id="faq2" class="accordion-collapse collapse" aria-labelledby="faqHeading2" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        I tempi di consegna dipendono dal metodo di spedizione scelto. La spedizione standard richiede 5-7 giorni lavorativi, mentre la spedizione express richiede 2-3 giorni lavorativi. Le spedizioni internazionali possono richiedere 10-15 giorni lavorativi.
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading3">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3" aria-expanded="false" aria-controls="faq3">
                        Posso restituire un prodotto?
                    </button>
                </h2>
                <div id="faq3" class="accordion-collapse collapse" aria-labelledby="faqHeading3" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Sì, accettiamo resi entro 30 giorni dall'acquisto. Il prodotto deve essere restituito nella sua condizione originale e con l'imballaggio originale. Si prega di consultare la nostra <a href="${pageContext.request.contextPath}/refundPolicy.jsp">Politica di Rimborso</a> per ulteriori dettagli.
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading4">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4" aria-expanded="false" aria-controls="faq4">
                        Come posso tracciare il mio ordine?
                    </button>
                </h2>
                <div id="faq4" class="accordion-collapse collapse" aria-labelledby="faqHeading4" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Una volta che il vostro ordine è stato spedito, riceverete un'email con un numero di tracciamento. Potete utilizzare questo numero per monitorare lo stato della vostra spedizione attraverso il sito del corriere.
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header" id="faqHeading5">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq5" aria-expanded="false" aria-controls="faq5">
                        Come posso contattarvi?
                    </button>
                </h2>
                <div id="faq5" class="accordion-collapse collapse" aria-labelledby="faqHeading5" data-bs-parent="#faqAccordion">
                    <div class="accordion-body">
                        Potete contattarci via email all'indirizzo <a href="mailto:info@bookscape.com">info@bookscape.com</a> o telefonicamente al numero +39 0512113333. Siamo disponibili dal lunedì al venerdì, dalle 9:00 alle 18:00.
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <%@ include file="template/footer.jsp"%>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
