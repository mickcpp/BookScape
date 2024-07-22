<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supporto - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
    <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-4">
        <h1 class="text-center">Supporto - BookScape</h1>
        <br>
        <p class="text-center">Benvenuti nella sezione di supporto di BookScape. Siamo qui per aiutarti.</p>
        
        <div class="accordion" id="supportAccordion">
            <div class="accordion-item">
                <h2 class="accordion-header" id="supportHeading1">
                    <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#support1" aria-expanded="true" aria-controls="support1">
                        Come posso contattare il supporto clienti?
                    </button>
                </h2>
                <div id="support1" class="accordion-collapse collapse show" aria-labelledby="supportHeading1" data-bs-parent="#supportAccordion">
                    <div class="accordion-body">
                        Puoi contattare il nostro supporto clienti via email all'indirizzo <a href="mailto:support@bookscape.com">support@bookscape.com</a> o telefonicamente al numero +39 0512113333. Siamo disponibili dal lunedì al venerdì, dalle 9:00 alle 18:00.
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header" id="supportHeading2">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#support2" aria-expanded="false" aria-controls="support2">
                        Come posso segnalare un problema con il mio ordine?
                    </button>
                </h2>
                <div id="support2" class="accordion-collapse collapse" aria-labelledby="supportHeading2" data-bs-parent="#supportAccordion">
                    <div class="accordion-body">
                        Se riscontri un problema con il tuo ordine, ti preghiamo di contattarci immediatamente via email all'indirizzo <a href="mailto:support@bookscape.com">support@bookscape.com</a> o chiamarci al numero +39 0512113333. Fornisci il tuo numero d'ordine e una descrizione dettagliata del problema.
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header" id="supportHeading3">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#support3" aria-expanded="false" aria-controls="support3">
                        Come posso aggiornare le informazioni del mio account?
                    </button>
                </h2>
                <div id="support3" class="accordion-collapse collapse" aria-labelledby="supportHeading3" data-bs-parent="#supportAccordion">
                    <div class="accordion-body">
                        Per aggiornare le informazioni del tuo account, accedi al tuo profilo su BookScape e vai alla sezione "Il mio account". Da lì, puoi aggiornare il tuo indirizzo, il metodo di pagamento e altre informazioni personali.
                    </div>
                </div>
            </div>

            <div class="accordion-item">
                <h2 class="accordion-header" id="supportHeading4">
                    <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#support4" aria-expanded="false" aria-controls="support4">
                        Come posso annullare il mio ordine?
                    </button>
                </h2>
                <div id="support4" class="accordion-collapse collapse" aria-labelledby="supportHeading4" data-bs-parent="#supportAccordion">
                    <div class="accordion-body">
                        Se desideri annullare il tuo ordine, contattaci il prima possibile via email all'indirizzo <a href="mailto:support@bookscape.com">support@bookscape.com</a> o chiamaci al numero +39 0512113333. Gli ordini già spediti non possono essere annullati, ma potrai restituirli seguendo la nostra <a href="${pageContext.request.contextPath}/refundPolicy.jsp">Politica di Rimborso</a>.
                    </div>
                </div>
            </div>
        </div>
    </main>
    
    <%@ include file="template/footer.jsp"%>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>