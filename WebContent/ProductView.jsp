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
	    <link rel="stylesheet" href="css/productView.css">
	    <link rel="stylesheet" href="css/feedback.css">
	    <link rel="icon" href="img/logo.png" type="image/x-icon">
	</head>
	<body>
	    <%@ include file="template/navbar.jsp" %>
	    <%
	        String id = (String) session.getAttribute("cliente");
	   
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

	   	<div class="container my-1 my-md-2 my-lg-3 mb-lg-3 product-container">
	    	<br>
	        <div class="row d-md-flex justify-content-md-center mt-1">
	            <div id="productImage" class="col-auto mx-auto mx-sm-0 mb-3 mb-md-2">
	   				<img src="${prodotto.imgURL}" alt="Immagine Prodotto" class="img-fluid rounded product-image">
				</div>
	            <div class="col-auto col-auto-max">
	                <h2>${EscaperHTML.escapeHTML(prodotto.nome)}</h2>
	                <p>${EscaperHTML.escapeHTML(prodotto.descrizione)}</p>
	                <p>Prezzo: ${prodotto.prezzo}</p>
	                <p>Disponibilità: ${prodotto.quantita}</p>
	                <form action="CartControl" method="post" style="display: inline-block">
	                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <input type="hidden" name="action" value="aggiungi">
	                    <input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <button class="btn btn-success me-2">Aggiungi al carrello</button>
	                </form>
	                <hr id="separatorCartWishlist">
	                <form action="WishlistControl" method="post" style="display: inline-block">
	                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <input type="hidden" name="action" value="aggiungi">
	                    <input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <button class="bookmark btn btn-outline-warning" type="submit"><img src="img/bookmark.png" alt="Bookmark">
	                    </button>
	                </form>
	                <hr id="separatorProductReview">
	            </div>
	        </div>
	    </div>
	    
	    <div class="container review-section px-4 py-2 py-sm-4 py-lg-0">
	        <h3>Scrivi una Recensione</h3>
	        <div style="display: block; margin:0" class="error-message"><%=errorMessage == null ? "" : errorMessage%></div>
	        <form action="RecensioneControl" method="post" onsubmit="return validateForm()">
	            <input type="hidden" name="action" value="insert">   
	            <input type="hidden" name="productId" value="${prodotto.getId()}">   
	            <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">         
	            <div class="rating text-start mb-2">
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
	                <div id="ratingError" class="error-message text-danger"></div>
	            </div>
	            <div class="descrizione mb-2">
	                <textarea class="form-control" id="recensione" name="recensione" placeholder="Scrivi qui la tua recensione..." rows="3"></textarea>
	                <div class="error-message text-danger mt-1" style="text-align: left"></div>
	            </div>
	            
	            <button class="btn btn-success" type="submit">Invia Recensione</button>
	        </form>
	    </div>
	    
	   	<div class="container my-4">
	        <div class="card">
	            <div class="card-body">
	            	<a href="RecensioneControl?action=visualizza&productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}" style="float: right; color: black">Vedi tutto</a>
	                <h3 class="card-title mb-3">Recensioni</h3>
	                <%
	                    if (recensioni != null && !recensioni.isEmpty()) {
	                        int num = 0;
	                        for (Recensione recensione : recensioni) {
	                            if (num == 4) break;
	                            String email = recensione.getCliente();
	    	                    String initials = email.substring(0, 1).toUpperCase();
	                %>
	                <div class="card mb-3">
	                    <div class="card-body">
	                        <div class="d-flex align-items-center mb-3">
	                            <div class="avatar me-2" data-email="<%= email %>"><%= initials %></div>
	                            <h5 id="emailRecensione" class="h5 mb-0"><%= email.equals(id) ? "Tu" : EscaperHTML.escapeHTML(email) %></h5>
	                        </div>
	                        <p class="card-text mb-2"><%= EscaperHTML.escapeHTML(recensione.getRecensione()) %></p>
	                        
                            <div class="rating text-start">
                                <% 
                                    for (int i = 0; i < recensione.getValutazione(); i++) { 
                                %>
                                        <i class="fas fa-star"></i>
                                <%
                                    } 
                                %>
                            </div>
	                   		<small class=""><%= formatTimeAgo(recensione.getData()) %></small>
	                        
	                        <% 
	                            if (recensione.getCliente().equals(id)) { // Mostra il pulsante solo se è la recensione del cliente autenticato
	                        %>
	                            <form action="RecensioneControl" method="post" style="float: right">
	                                <input type="hidden" name="action" value="delete">
	                                <input type="hidden" name="productId" value="${prodotto.getId()}">
	                                <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                                <button id="deleteRecensione" type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Elimina Recensione</button>
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
	                <p class="text-muted">Ancora nessuna recensione.</p>
	                <%
	                }
	                %>
	            </div>
	        </div>
    	</div>
    
    <%@ include file="template/footer.jsp"%>
    
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