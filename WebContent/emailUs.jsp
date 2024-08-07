<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contattaci via Email - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link rel="icon" href="img/logo.png" type="image/x-icon">
</head>
<body>
    
     <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-4">
        <h1 class="text-center">Contattaci via Email - BookScape</h1>
        <br>
        <p class="text">Se hai domande o necessiti di assistenza, non esitare a contattarci via email. Compila il modulo sottostante e il nostro team di supporto ti risponderà il prima possibile.</p>
        
        <div class="row justify-content-center">
            <div class="col-md-8">
                <form action="HomePage" method="post">
                    <div class="form-group mb-2">
                        <label for="name">Nome:</label>
                        <input type="text" class="form-control pt-2" id="name" name="name" required>
                    </div>
                    <div class="form-group mb-2">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control pt-2" id="email" name="email" required>
                    </div>
                    <div class="form-group mb-2">
                        <label for="subject">Oggetto:</label>
                        <input type="text" class="form-control pt-2" id="subject" name="subject" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="message">Messaggio:</label>
                        <textarea class="form-control pt-2" id="message" name="message" rows="5" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Invia</button>
                </form>
            </div>
        </div>
    </main>
    
     <%@ include file="template/footer.jsp"%>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
