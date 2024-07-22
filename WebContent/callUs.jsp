<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contattaci Telefonicamente - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
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
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
