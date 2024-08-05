<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contattaci Telefonicamente - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="img/logo.png" type="image/x-icon">
    <jsp:include page="header.jsp" />
</head>
<body>
     <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-4">
        <h2 class="text-center mb-lg-3">Contattaci Telefonicamente - BookScape</h2>
        <p class="text">Se hai domande o necessiti di assistenza, non esitare a contattarci telefonicamente. Il nostro team di supporto è disponibile per aiutarti con qualsiasi richiesta.</p>
        
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Numero di Telefono</h5>
                        <p class="card-text">Puoi contattarci al seguente numero:</p>
                        <p class="h4"><a href="tel:+391234567890" class="text-dark"><i class="fas fa-phone-alt"></i> +39 123 456 7890</a></p>
                        <p class="card-text mt-4">Orari di disponibilità:</p>
                        <ul class="list-unstyled">
                            <li>Lunedì - Venerdì: 9:00 - 18:00</li>
                            <li>Sabato: 10:00 - 14:00</li>
                            <li>Domenica: Chiuso</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </main>
    
     <%@ include file="template/footer.jsp"%>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
