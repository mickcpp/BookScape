<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FAQ - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    
    
</head>
<body>
    
     <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-5">
        <h1 class="text-center">FAQ - Domande Frequenti</h1>
        <br>
        <br>
        <p class="text-center">Benvenuti nella sezione FAQ di BookScape. Qui trovate le risposte alle domande più comuni.</p>
        
        <div class="accordion" id="faqAccordion">
            <div class="card">
                <div class="card-header" id="faqHeading1">
                    <h2 class="mb-0">
                        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#faq1" aria-expanded="true" aria-controls="faq1">
                            Quali metodi di pagamento accettate?
                        </button>
                    </h2>
                </div>
                <div id="faq1" class="collapse show" aria-labelledby="faqHeading1" data-parent="#faqAccordion">
                    <div class="card-body">
                        Accettiamo i seguenti metodi di pagamento: carte di credito (Visa, MasterCard, American Express), e bonifico bancario.
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="faqHeading2">
                    <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#faq2" aria-expanded="false" aria-controls="faq2">
                            Quanto tempo ci vuole per ricevere il mio ordine?
                        </button>
                    </h2>
                </div>
                <div id="faq2" class="collapse" aria-labelledby="faqHeading2" data-parent="#faqAccordion">
                    <div class="card-body">
                        I tempi di consegna dipendono dal metodo di spedizione scelto. La spedizione standard richiede 5-7 giorni lavorativi, mentre la spedizione express richiede 2-3 giorni lavorativi. Le spedizioni internazionali possono richiedere 10-15 giorni lavorativi.
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="faqHeading3">
                    <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#faq3" aria-expanded="false" aria-controls="faq3">
                            Posso restituire un prodotto?
                        </button>
                    </h2>
                </div>
                <div id="faq3" class="collapse" aria-labelledby="faqHeading3" data-parent="#faqAccordion">
                    <div class="card-body">
                        Sì, accettiamo resi entro 30 giorni dall'acquisto. Il prodotto deve essere restituito nella sua condizione originale e con l'imballaggio originale. Si prega di consultare la nostra <a href="${pageContext.request.contextPath}/refundPolicy.jsp">Politica di Rimborso</a> per ulteriori dettagli.
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="faqHeading4">
                    <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#faq4" aria-expanded="false" aria-controls="faq4">
                            Come posso tracciare il mio ordine?
                        </button>
                    </h2>
                </div>
                <div id="faq4" class="collapse" aria-labelledby="faqHeading4" data-parent="#faqAccordion">
                    <div class="card-body">
                        Una volta che il vostro ordine è stato spedito, riceverete un'email con un numero di tracciamento. Potete utilizzare questo numero per monitorare lo stato della vostra spedizione attraverso il sito del corriere.
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="faqHeading5">
                    <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#faq5" aria-expanded="false" aria-controls="faq5">
                            Come posso contattarvi?
                        </button>
                    </h2>
                </div>
                <div id="faq5" class="collapse" aria-labelledby="faqHeading5" data-parent="#faqAccordion">
                    <div class="card-body">
                        Potete contattarci via email all'indirizzo <a href="mailto:info@bookscape.com">info@bookscape.com</a> o telefonicamente al numero +39 0512113333. Siamo disponibili dal lunedì al venerdì, dalle 9:00 alle 18:00.
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <%@ include file="template/footer.jsp"%>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
