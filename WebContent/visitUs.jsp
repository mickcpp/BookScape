<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Visita il Nostro Negozio - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
    <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-5">
        <h1 class="text-center">Visita il Nostro Negozio - BookScape</h1>
        <p class="text-center">Vieni a trovarci nel nostro negozio fisico per esplorare la nostra vasta collezione di libri e gadget. Saremo felici di accoglierti!</p>
        
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <h5 class="card-title">Indirizzo del Negozio</h5>
                        <p class="card-text">Ci trovi all'indirizzo:</p>
                        <p class="h5"><i class="fas fa-map-marker-alt"></i> Via Tenente Nastri, 14, 84084 Lancusi (SA), Italia</p>
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-body text-center">
                        <h5 class="card-title">Orari di Apertura</h5>
                        <ul class="list-unstyled">
                            <li>Lunedì - Venerdì: 9:00 - 18:00</li>
                            <li>Sabato: 10:00 - 14:00</li>
                            <li>Domenica: Chiuso</li>
                        </ul>
                    </div>
                </div>
                
                <div class="card">
                    <div class="card-body text-center">
                        <h5 class="card-title">Mappa</h5>
                        <div class="embed-responsive embed-responsive-16by9">
                            <iframe class="embed-responsive-item" src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3151.835434509364!2d144.9537363155894!3d-37.81627944202198!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6ad65d43f1f1f1f1%3A0x1f1f1f1f1f1f1f1f!2sVia+Tenente+Nastri%2C+14%2C+84084+Lancusi+SA%2C+Italy!5e0!3m2!1sen!2sus!4v1614611234567!5m2!1sen!2sus" allowfullscreen></iframe>
                        </div>
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
