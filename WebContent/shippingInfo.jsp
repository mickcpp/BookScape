<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Informazioni di Spedizione - BookScape</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    
    <%@ include file="template/navbar.jsp"%>
    
    <main class="container my-4">
        <h1 class="text-center">Informazioni di Spedizione</h1>
        <br>
        <p>Benvenuti alla sezione delle Informazioni di Spedizione di BookScape. Qui troverete tutte le informazioni necessarie sui metodi di spedizione, tempi di consegna e costi.</p>
        
        <div class="my-4">
            <h2>Metodi di Spedizione</h2>
            <p>Offriamo vari metodi di spedizione per soddisfare le vostre esigenze:</p>
            <ul>
                <li><strong>Spedizione Standard:</strong> consegna entro 5-7 giorni lavorativi.</li>
                <li><strong>Spedizione Express:</strong> consegna entro 2-3 giorni lavorativi.</li>
                <li><strong>Spedizione Internazionale:</strong> consegna entro 10-15 giorni lavorativi.</li>
            </ul>
        </div>
        
        <div class="my-4">
            <h2>Tempi di Elaborazione</h2>
            <p>Tutti gli ordini sono elaborati entro 1-2 giorni lavorativi (esclusi i fine settimana e i giorni festivi) dopo aver ricevuto la conferma dell'ordine. Riceverete una notifica via email quando il vostro ordine sarà stato spedito.</p>
        </div>
        
        <div class="my-4">
            <h2>Costi di Spedizione</h2>
            <p>I costi di spedizione sono calcolati in base al peso dell'ordine e alla destinazione. Durante il checkout, potrete vedere il costo esatto della spedizione prima di completare l'acquisto. Ecco una panoramica dei nostri costi di spedizione:</p>
            <ul>
                <li><strong>Spedizione Standard:</strong> €5,99 per ordini fino a 2kg.</li>
                <li><strong>Spedizione Express:</strong> €9,99 per ordini fino a 2kg.</li>
                <li><strong>Spedizione Internazionale:</strong> €19,99 per ordini fino a 2kg.</li>
            </ul>
        </div>
        
        <div class="my-4">
            <h2>Tracciamento della Spedizione</h2>
            <p>Una volta che il vostro ordine è stato spedito, riceverete un'email con un numero di tracciamento. Potete utilizzare questo numero per monitorare lo stato della vostra spedizione attraverso il sito del corriere.</p>
        </div>
        
        <div class="my-4">
            <h2>Problemi di Spedizione</h2>
            <p>Se riscontrate problemi con la spedizione del vostro ordine, vi preghiamo di contattarci all'indirizzo email <a href="mailto:info@bookscape.com">info@bookscape.com</a> o telefonicamente al numero +39 0512113333. Faremo del nostro meglio per risolvere il problema il prima possibile.</p>
        </div>
        
        <div class="my-4">
            <h2>Modifiche alle Informazioni di Spedizione</h2>
            <p>BookScape si riserva il diritto di modificare queste informazioni di spedizione in qualsiasi momento. Qualsiasi modifica sarà pubblicata su questa pagina con una data di revisione aggiornata. Vi invitiamo a rivedere periodicamente questa sezione per rimanere informati sulle nostre politiche di spedizione.</p>
        </div>
        
        <div class="my-4">
            <h2>Contattaci</h2>
            <p>Se avete domande sulle nostre Informazioni di Spedizione, contattateci a:</p>
            <address>
                <strong>BookScape Internet Bookshop S.r.l.</strong><br>
                Via Tenente Nastri, 14<br>
                84084 Lancusi (SA)<br>
                Email: <a href="mailto:info@bookscape.com">info@bookscape.com</a><br>
                Telefono: +39 0512113333
            </address>
        </div>
    </main>
    
    <%@ include file="template/footer.jsp"%>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
