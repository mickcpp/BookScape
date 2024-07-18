<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="utility.EscaperHTML"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.concurrent.TimeUnit"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>Dettagli Prodotto</title>
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	    <link rel="stylesheet" href="css/style.css">
	    <link rel="stylesheet" href="css/feedback.css">
	    <style>
		 	body {
	            font-family: Arial, sans-serif;
	            background-color: #f9f9f9;
	            margin: 0;
	            padding: 0;
	        }
	        .container {
	            display: flex;
	            justify-content: center;
	            align-items: center;
	            
	            background-color: #f9f9f9;
	            padding: 20px;
	        }
	        .product-container {
	            display: flex;
	            align-items: center;
	            background-color: #fff;
	            border-radius: 10px;
	            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	            width: 80%;
	            max-width: 800px;
	            overflow: hidden;
	        }
	        .product-image {
	            flex: 1;
	            max-width: 30%;
	            height: auto;
	            border-radius: 10px 0 0 10px;
	            object-fit: cover;
	        }
	        .product-info {
	            flex: 1;
	            padding: 30px;
	            text-align: left;
	        }
	        .product-info h2 {
	            color: #333;
	            margin-top: 0;
	            font-size: 26px;
	            margin-bottom: 20px;
	        }
	        .product-info p {
	            margin: 8px 0;
	            color: #666;
	        }
	        .btn {
	            padding: 10px 20px;
	            background-color: #4CAF50;
	            color: white;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            margin-right: 10px;
	            transition: background-color 0.3s;
	            font-size: 14px;
	        }
	        .btn:hover {
	            background-color: #45a049;
	        }
	        .bookmark {
	            background: none;
	            border: none;
	            cursor: pointer;
	            transition: color 0.3s;
	            font-size: 14px;
	        }
	        .bookmark:hover {
	            color: #f44336;
	        }
	        #logout {
	            position: absolute;
	            margin-left: 3%;
	            top: 130px;
	            margin-bottom: 20px;
	            font-size: 18px;
	        }
	        .review-section {
	            width: 80%;
	            max-width: 800px;
	            background-color: #fff;
	            padding: 20px;
	            border-radius: 10px;
	            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	            margin: 20px auto;
	            text-align: left;
	        }
	        .review-section h3 {
	            margin-top: 0;
	            color: #333;
	            font-size: 24px;
	        }
	        .review-section textarea {
	            box-sizing: border-box;
	            width: 100%;
	            height: 100px;
	            padding: 10px;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	            margin-bottom: 10px;
	            font-family: Arial, sans-serif;
	            resize: vertical;
	            min-height: 35px;
	        }
	        .review-section .rating {
	            margin-bottom: 15px;
	            direction: rtl;
	        }
	        .review-section .rating input {
	            display: none;
	        }
	        .review-section .rating label {
	            color: #ddd;
	            font-size: 20px;
	            cursor: pointer;
	            transition: color 0.2s;
	        }
	        .review-section .rating input:checked ~ label,
	        .review-section .rating label:hover,
	        .review-section .rating label:hover ~ label {
	            color: #f5a623;
	        }
	        .review-section button {
	            padding: 10px 20px;
	            background-color: #4CAF50;
	            color: white;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            font-size: 16px;
	            transition: background-color 0.3s;
	        }
	        .review-section button:hover {
	            background-color: #45a049;
	        }
	        .review-display {
	            width: 80%;
	            max-width: 800px;
	            background-color: #fff;
	            padding: 20px;
	            border-radius: 10px;
	            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	            margin: 20px auto;
	            text-align: left;
	        }
	        .review-display .review {
	            display: flex;
	            align-items: center;
	            border-bottom: 1px solid #eee;
	            padding: 10px 0;
	        }
	        .review-display .review:last-child {
	            border-bottom: none;
	        }
	        .review-display .avatar {
	            width: 40px;
	            height: 40px;
	            border-radius: 50%;
	            display: flex;
	            align-items: center;
	            justify-content: center;
	            color: white;
	            font-size: 18px;
	            margin-right: 15px;
	            text-transform: uppercase;
	        }
	        .review-display .review-content {
	            flex: 1;
	        }
	        .review-display .review-content h4 {
	            margin: 0 0 5px;
	            font-size: 20px;
	            color: #333;
	        }
	        .review-display .review-content p {
	            margin: 5px 0;
	            color: #666;
	        }
	        .review-display .review-content .rating {
	            color: #f5a623;
	            font-size: 18px;
	        }
	        .error-message {
	            color: #e74c3c;
	            font-size: 0.9em;
	          	margin: -10px 8px 1.55% auto;
	            text-align: right;
	            display: none;
	        }
	        .review-display .review-content small {
		        color: #999;
		        font-size: 14px;
		        margin-top: 5px;
		        display: inline-block;
		    }
	    </style>
	</head>
	<body>
	    <%@ include file="template/navbar.jsp" %>
	    <%
	        String id = (String) session.getAttribute("cliente");
	        if(id != null && !id.equals("")){
	    %>
	        <a id="logout" href="Logout">Logout</a>
	    <%
	        }
	    %>
	    <%
	   
	    	Product prodotto = (Product) request.getAttribute("prodotto");
	    
	        if(prodotto == null){
	            response.sendRedirect("./");
	            return;
	        }
	    
	 		String errorMessage = (String) session.getAttribute("errorMessage");
	 		String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 		
	 		session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
			session.removeAttribute("errorMessage");
	    
	        @SuppressWarnings("unchecked")
	        List<Recensione> recensioni = (List<Recensione>) request.getAttribute("recensioni");
	        
	        // Se il cliente è autenticato, ordino le recensioni mettendo quella del cliente in cima
	        if (id != null && !id.isEmpty()) {
	            // Trovo la recensione del cliente e la sposto in cima alla lista
	            Recensione clienteReview = null;
	            Iterator<Recensione> iter = recensioni.iterator();
	            while (iter.hasNext()) {
	                Recensione recensione = iter.next();
	                if (recensione.getCliente().equals(id)) {
	                    clienteReview = recensione;
	                    iter.remove(); // Rimuovo la recensione dal suo posto originale
	                    break;
	                }
	            }
	            if (clienteReview != null) {
	                recensioni.add(0, clienteReview); // Aggiungo la recensione del cliente in cima
	            }
	        }
	    %>
	    
	 	<%!
		 // funzione per formattare la data
	    	String formatTimeAgo(Calendar date) {
		        long durationInMillis = new Date().getTime() - date.getTimeInMillis();
		        long minutes = TimeUnit.MILLISECONDS.toMinutes(durationInMillis);
		        long hours = TimeUnit.MILLISECONDS.toHours(durationInMillis);
		        long days = TimeUnit.MILLISECONDS.toDays(durationInMillis);
		        
		        if (minutes < 60) {
		        	if(minutes == 1){
		        		return minutes + " minuto fa";
		        	}
		            return minutes + " minuti fa";
		        } else if (hours < 24) {
		        	if(hours == 1){
		        		return hours + " ora fa";
		        	}
		            return hours + " ore fa";
		        } else if (days < 7) {
		        	if(days == 1){
		        		return days + " giorno fa";
		        	}
		            return days + " giorni fa";
		        } else {
		            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		            return sdf.format(date.getTime());
		        }
		    }
	 	%>
	 
	 	<%@ include file="template/feedbackSection.jsp" %>

	    <div class="container">
	        <div class="product-container">
	            <img src="${prodotto.imgURL}" alt="Immagine Prodotto" class="product-image">
	            <div class="product-info">
	                <h2>${EscaperHTML.escapeHTML(prodotto.nome)}</h2>
	                <p>${EscaperHTML.escapeHTML(prodotto.descrizione)}</p>
	                <p>Prezzo: ${prodotto.prezzo}</p>
	                <p>Disponibilità: ${prodotto.quantita}</p>
	                <form action="CartControl" method="post">
	                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <input type="hidden" name="action" value="aggiungi">
	                    <input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <button class="btn">Aggiungi al carrello</button>
	                </form>
	                <hr>
	                <form action="WishlistControl" method="post">
	                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <input type="hidden" name="action" value="aggiungi">
	                    <input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <button class="bookmark" type="submit"><i class="far fa-bookmark"></i> Aggiungi alla lista desideri</button>
	                </form>
	            </div>
	        </div>
	    </div>
	    <div class="review-section">
	        <h3>Scrivi una Recensione</h3>
	        <div style="display: block; margin:0" class="error-message"><%=errorMessage == null ? "" : errorMessage%></div>
	        <form action="RecensioneControl" method="post" onsubmit="return validateForm()">
	            <input type="hidden" name="action" value="insert">   
	            <input type="hidden" name="productId" value="${prodotto.getId()}">   
	            <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">         
	            <div class="rating">
	                <input type="radio" name="rating" id="star5" value="5">
	                <label for="star5" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star4" value="4">
	                <label for="star4" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star3" value="3">
	                <label for="star3" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star2" value="2">
	                <label for="star2" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star1" value="1">
	                <label for="star1" class="fas fa-star"></label>
	                <div class="error-message"></div>
	            </div>
	            <div class="descrizione">
	                <textarea id="recensione" name="recensione" placeholder="Scrivi qui la tua recensione..."></textarea>
	                <div class="error-message" style="text-align: left"></div>
	            </div>
	            
	            <button type="submit">Invia Recensione</button>
	        </form>
	    </div>
	    <div class="review-display">
	        <a href="RecensioneControl?action=visualizza&productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}" style="float: right">Vedi tutto</a>
	        <h2>Recensioni dei Clienti</h2>
	        <%
	            if (recensioni != null && !recensioni.isEmpty()) {
	            	int num = 0;
	                for (Recensione recensione : recensioni) {
	                	if(num == 4) break;
	                    String email = recensione.getCliente();
	                    String initials = email.substring(0, 1).toUpperCase();
	        %>
	                    <div class="review">
	                        <div class="avatar" data-email="<%= email %>"><%= initials %></div>
	                        <div class="review-content">
	                            <h4><%= email.equals(id) ? "Tu" : EscaperHTML.escapeHTML(email) %></h4>
	                            <div class="rating">
	                                <% 
	                                    for (int i = 0; i < recensione.getValutazione(); i++) { 
	                                %>
	                                        <i class="fas fa-star"></i>
	                                <%
	                                    } 
	                                %>
	                            </div>
	                            <p><%= EscaperHTML.escapeHTML(recensione.getRecensione()) %></p>
	                            <small><%= formatTimeAgo(recensione.getData()) %></small>
	                            <% 
	                                if (email.equals(id)) { // Mostra il pulsante solo se è la recensione del cliente autenticato
	                            %>
	                                <form action="RecensioneControl" method="post" style="float: right">
	                                    <input type="hidden" name="action" value="delete">
	                                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                                    <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Elimina Recensione</button>
	                                </form>
                       	<%
                                }
                      	%>
                        </div>
                    </div>
        <%
        			num++;
                }
            } else {
        %>
                <p>Nessuna recensione disponibile.</p>
        <%
            }
        %>
    </div>
    <%@ include file="template/footer.html" %>
    <script>
        function stringToColor(str) {
            let hash = 0;
            for (let i = 0; i < str.length; i++) {
                hash = str.charCodeAt(i) + ((hash << 5) - hash);
            }
            let color = '#';
            for (let i = 0; i < 3; i++) {
                let value = (hash >> (i * 8)) & 0xFF;
                color += ('00' + value.toString(16)).substr(-2);
        	}
            return color;
        }
        
        document.querySelectorAll('.avatar').forEach(function(avatar) {
            let email = avatar.getAttribute('data-email');
            let color = stringToColor(email);
            avatar.style.backgroundColor = color;
        });
        
        function validateForm() {
      		let isValid = true;
            let ratingChecked = document.querySelector('.rating input:checked');
           	let recensione = document.querySelector('#recensione');
           	
            resetErrors();
          
            if (!ratingChecked) {
            	showError(document.querySelector('.rating input'), "Per favore, seleziona almeno una valutazione");
                isValid = false;
            }
            
         	if(recensione.value.length > 1000){
         		showError(recensione, "Puoi inserire al massimo 1000 caratteri.");
         		isValid = false;
         	}
            return isValid;
        }
        
        function showError(input, message) {
            const errorElement = input.parentElement.querySelector('.error-message');
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
        
	    function resetErrors() {
	        const errorMessages = document.querySelectorAll('.error-message');
	        errorMessages.forEach(function (error) {
	            error.style.display = 'none';
	            error.textContent = '';
	        });
	    }
    </script>
    
  	<script src="js/scriptFeedback.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>