<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Supporto - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
    <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-5">
        <h1 class="text-center">Supporto - BookScape</h1>
        <br>
        <br>
        <p class="text-center">Benvenuti nella sezione di supporto di BookScape. Siamo qui per aiutarti.</p>
        
        <div class="accordion" id="supportAccordion">
            <div class="card">
                <div class="card-header" id="supportHeading1">
                    <h2 class="mb-0">
                        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#support1" aria-expanded="true" aria-controls="support1">
                            Come posso contattare il supporto clienti?
                        </button>
                    </h2>
                </div>
                <div id="support1" class="collapse show" aria-labelledby="supportHeading1" data-parent="#supportAccordion">
                    <div class="card-body">
                        Puoi contattare il nostro supporto clienti via email all'indirizzo <a href="mailto:support@bookscape.com">support@bookscape.com</a> o telefonicamente al numero +39 0512113333. Siamo disponibili dal lunedì al venerdì, dalle 9:00 alle 18:00.
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="supportHeading2">
                    <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#support2" aria-expanded="false" aria-controls="support2">
                            Come posso segnalare un problema con il mio ordine?
                        </button>
                    </h2>
                </div>
                <div id="support2" class="collapse" aria-labelledby="supportHeading2" data-parent="#supportAccordion">
                    <div class="card-body">
                        Se riscontri un problema con il tuo ordine, ti preghiamo di contattarci immediatamente via email all'indirizzo <a href="mailto:support@bookscape.com">support@bookscape.com</a> o chiamarci al numero +39 0512113333. Fornisci il tuo numero d'ordine e una descrizione dettagliata del problema.
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="supportHeading3">
                    <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#support3" aria-expanded="false" aria-controls="support3">
                            Come posso aggiornare le informazioni del mio account?
                        </button>
                    </h2>
                </div>
                <div id="support3" class="collapse" aria-labelledby="supportHeading3" data-parent="#supportAccordion">
                    <div class="card-body">
                        Per aggiornare le informazioni del tuo account, accedi al tuo profilo su BookScape e vai alla sezione "Il mio account". Da lì, puoi aggiornare il tuo indirizzo, il metodo di pagamento e altre informazioni personali.
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header" id="supportHeading4">
                    <h2 class="mb-0">
                        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#support4" aria-expanded="false" aria-controls="support4">
                            Come posso annullare il mio ordine?
                        </button>
                    </h2>
                </div>
                <div id="support4" class="collapse" aria-labelledby="supportHeading4" data-parent="#supportAccordion">
                    <div class="card-body">
                        Se desideri annullare il tuo ordine, contattaci il prima possibile via email all'indirizzo <a href="mailto:support@bookscape.com">support@bookscape.com</a> o chiamaci al numero +39 0512113333. Gli ordini già spediti non possono essere annullati, ma potrai restituirli seguendo la nostra <a href="${pageContext.request.contextPath}/refundPolicy.jsp">Politica di Rimborso</a>.
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
