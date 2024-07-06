<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, net.bookscape.model.CartItem"%>
<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.Cliente, net.bookscape.model.CartaPagamento"%>
<%@ page import="utility.EscaperHTML"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/feedback.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
        }

        .checkout-container {
            width: 60%;
            margin: -5px auto 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            margin-bottom: 20px;
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        table th, table td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        tfoot td {
            font-weight: bold;
        }

        .checkout-customer-info p, .checkout-payment-info p, .checkout-billing-info p {
            margin-bottom: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #45a049;
        }

        .checkout-payment-info {
            margin-top: 30px;
        }

        .checkout-payment-info h2 {
            color: #333;
            margin-bottom: 15px;
        }

		.checkout-payment-info a, .checkout-customer-info a{
            color: #4caf50;
            text-decoration: underline;
        }

        .checkout-payment-info a:hover{
            text-decoration: underline;
        }
        
        .payment-form, #checkout-billing-form, #shipping-form{
            display: none;
            margin-top: 20px;
        }
		
        .payment-form input, #checkout-billing-form input, #shipping-form input {
            display: inline-block;
            width: 100%;
            padding: 9px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 15px;
            box-sizing: border-box;  
        }

        button:disabled {
            background-color: #cccccc; /* Colore di sfondo più chiaro */
            color: #666666; /* Colore del testo più chiaro */
            border: 1px solid #999999; /* Bordo più chiaro */
            cursor: not-allowed; /* Cambio del cursore */
        }
        
        #searchbar-section{
	    	display: none;
	    }
	    
	    .form-group {
            position: relative;
	     }    
	   
	 	.form-group .fa {
            position: absolute;
            right: 13px;
            top: 20px;
            transform: translateY(-50%);
            color: #999;
        }
        
        #payment-form .fa{
    		right: 10px;
        }
        
        .error-message {
            color: #e74c3c;
            font-size: 0.9em;
          	margin: -10px 8px 1.55% auto;
            text-align: left;
            display: none;
        }
        
        .fa-cc-visa, .fa-cc-mastercard{
      		position: absolute;
            right: 8px;
            top: 19px;
            transform: translateY(-50%);
          	font-size: 1.3em;
      	}
    </style>
</head>
<body>
    <%@ include file="template/navbar.jsp" %>

    <%
        Ordine ordine = (Ordine) request.getAttribute("ordine");
        Cliente clienteOrder = (Cliente) request.getAttribute("clienteOrder");

        if (ordine == null || clienteOrder == null){
            response.sendRedirect("OrderControl?action=checkout");
            return;
        }

        CartaPagamento carta = clienteOrder.getCarta();
        
        String errorMessage = (String) session.getAttribute("errorMessage");
        String feedback = (String) session.getAttribute("feedback");
 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
 		Boolean fatturazioneCheckbox = (Boolean) session.getAttribute("fatturazioneCheckbox");
 		
 		session.removeAttribute("feedback");
		session.removeAttribute("feedback-negative");
		session.removeAttribute("errorMessage");
		session.removeAttribute("fatturazioneCheckbox");
    %>

	<%@ include file="template/feedbackSection.jsp" %>
	
    <div class="checkout-container">
        <div class="checkout-summary">
            <h2>Riepilogo dell'ordine</h2>
            <table>
                <thead>
                    <tr>
                        <th>Prodotto</th>
                        <th>Quantità</th>
                        <th>Prezzo (IVA inclusa)</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Itera sui prodotti nell'ordine -->
                    <%
                        for(CartItem item : ordine.getProdotti()){
                    %>
                        <tr>
                            <td><%=EscaperHTML.escapeHTML(item.getProduct().getNome()) %></td>
                            <td><%=item.getNumElementi()%></td>
                            <td><%=item.getProduct().getPrezzo()%></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="2">Totale:</td>
                        <td><%=ordine.getPrezzoTotale()%></td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="checkout-customer-info">
            <h2>Informazioni di fatturazione</h2>
            <p id="nomeCliente"><strong>Nome: </strong><%=EscaperHTML.escapeHTML(clienteOrder.getNome())%></p>
            <p id="cognomeCliente"><strong>Cognome: </strong><%=EscaperHTML.escapeHTML(clienteOrder.getCognome())%></p>
            <p><strong>Email: </strong><%=EscaperHTML.escapeHTML(clienteOrder.getEmail())%></p>
            <p id="indirizzoCliente"><strong>Indirizzo di fatturazione: </strong><%=EscaperHTML.escapeHTML(clienteOrder.getVia())%>, <%=EscaperHTML.escapeHTML(clienteOrder.getCitta())%>, <%=EscaperHTML.escapeHTML(clienteOrder.getCAP())%></p>
        </div>
        
		<div class="checkout-billing-info">
            <h2>Dati di spedizione</h2>
       		
           	<strong>Utilizza indirizzo di fatturazione per la spedizione: </strong>
          	<form style="display: inline-block" action="OrderControl" method="POST">
          		<input type="hidden" name="action" value="checkout">
          		<input type="checkbox" id="useShippingForBilling" onchange="toggleBillingForm()" <%if(fatturazioneCheckbox == null){ %> checked <% } %>>
       		</form>

       		<p id="nomeConsegna"><strong>Nome: </strong><%=EscaperHTML.escapeHTML(ordine.getNomeConsegna())%></p>
            <p id="cognomeConsegna"><strong>Cognome: </strong><%=EscaperHTML.escapeHTML(ordine.getCognomeConsegna())%></p>
            <p id="indirizzoConsegna"><strong>Indirizzo di Spedizione: </strong><%=EscaperHTML.escapeHTML(ordine.getVia())%>, <%=EscaperHTML.escapeHTML(ordine.getCitta())%>, <%=EscaperHTML.escapeHTML(ordine.getCAP())%></p>
        </div>
        
        <div id="checkout-billing-form">
            <h2>Inserisci Dati di Spedizione</h2>
            <div style="display: block" class="error-message"><%=errorMessage == null ? "" : errorMessage%></div>
            
            <form action="OrderControl" method="post" onsubmit="return validateFormShipping()">
                <input type="hidden" name="action" value="checkout">
                <input type="hidden" name="option" value="updateSpedizione">
                
                <div class="form-group">
                	<input type="text" id="nomeSpedizione" name="nomeSpedizione" placeholder="Nome" required><br>
	                <i class="fa fa-id-card"></i>
	                <div class="error-message"></div>
                </div>
                
            	<div class="form-group">
                	<input type="text" id="cognomeSpedizione" name="cognomeSpedizione" placeholder="Cognome" required><br>
	                <i class="fa fa-id-card"></i>
	                <div class="error-message"></div>
                </div>
                
                <div class="form-group">
                	<input type="text" id="indirizzoSpedizione" name="indirizzoSpedizione" placeholder="Via, Città, CAP" required><br>
	                <i class="fa fa-city"></i>
	                <div class="error-message"></div>
                </div>
               	
                <button type="submit">Salva dati di spedizione</button>
            </form>
        </div>
        
        <div class="checkout-payment-info">
        	
        	<h2>Metodo di Pagamento</h2>
			<%
			    if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) {
			%>
			    	<p>Aggiungi Metodo di Pagamento: <a href="javascript:void(0);" onclick="togglePaymentForm()">Aggiungi</a></p>
			<%
			    } else {
			        String cardNumber = "**** **** **** " + carta.getNumeroCarta().substring(carta.getNumeroCarta().length() - 4);
			        String dataScadenza = (carta.getDataScadenza().get(Calendar.MONTH) + 1) + "/" + carta.getDataScadenza().get(Calendar.YEAR);
			%>
			    <p>Carta: <%= EscaperHTML.escapeHTML(carta.getNomeCarta()) %> (<%= EscaperHTML.escapeHTML(cardNumber) %>)</p>
			    <p>Data Scadenza: <%= EscaperHTML.escapeHTML(dataScadenza) %></p>
			    <p><strong>Modifica Metodo di Pagamento: </strong><a href="javascript:void(0);" onclick="togglePaymentForm()">Modifica</a></p>
			<%
			    }
			%>
			
			<div id="payment-form" class="payment-form">
				<div style="display: block" class="error-message"><%=errorMessage == null ? "" : errorMessage%></div>
				
                <form action="UpdateUser" method="post" onsubmit="return validateFormPayment()">
                    <input type="hidden" name="action" value="updatePagamento">
                    <input type="hidden" name="redirect" value="OrderControl?action=checkout">
                   	
                   	<div class="form-group">
	                	<input type="text" id="nomeCarta" name="nomeCarta" placeholder="Nome sulla Carta" required>
		                <i class="fa fa-id-card"></i>
		                <div class="error-message"></div>
                	</div>
                	<div class="form-group">
	                	<input type="text" id="numeroCarta" name="numeroCarta" maxlength="19" autocomplete="cc-number" placeholder="Numero della carta" required>
		                <i id="cardLogo" class="fa fa-credit-card"></i>
		                <div class="error-message"></div>
                	</div>
                	<div class="form-group">
	                	<input type="month" id="dataScadenza" name="dataScadenza" required>
		                <div class="error-message"></div>
                	</div>
                	<div class="form-group">
	                	<input type="text" id="cvv" name="cvv" placeholder="CVV" maxlength="3" required>
		                <i class="fa fa-lock"></i>
		                <div class="error-message"></div>
                	</div>
                	
                    <button type="submit">Salva Metodo di Pagamento</button>
                </form>
            </div>
        </div>

        <form style="text-align: center" action="OrderControl" method="post">
      		<input type="hidden" name="action" value="acquista">
      		<input type="hidden" name="nomeConsegna" value="<%=ordine.getNomeConsegna()%>">
      		<input type="hidden" name="cognomeConsegna" value="<%=ordine.getCognomeConsegna()%>">
      		<input type="hidden" name="viaConsegna" value="<%=ordine.getVia()%>">
      		<input type="hidden" name="cittaConsegna" value="<%=ordine.getCitta()%>">
      		<input type="hidden" name="capConsegna" value="<%=ordine.getCAP()%>">
            <% if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) { %>
                <button type="submit" disabled>Conferma Acquisto</button>
            <% } else { %>
                <button type="submit">Conferma Acquisto</button>
            <% } %>
        </form>
    </div>

    <%@ include file="template/footer.html" %>
    
    <script>
	    function togglePaymentForm() {
	        var form = document.getElementById('payment-form');
	        if (form.style.display === 'none' || form.style.display === '') {
	            form.style.display = 'block';
	        } else {
	            form.style.display = 'none';
	        }
	    }
		
	    function toggleBillingForm() {
	        var checkbox = document.getElementById('useShippingForBilling');
	        var form = document.getElementById('checkout-billing-form');
	        
	        if (checkbox.checked) {
	            form.style.display = 'none';
	         	
	         	var nomeCliente = document.getElementById("nomeCliente").innerHTML;
	         	var nomeConsegna = document.getElementById("nomeConsegna").innerHTML;
	         	var cognomeCliente = document.getElementById("cognomeCliente").innerHTML;
	         	var cognomeConsegna = document.getElementById("cognomeConsegna").innerHTML;
	         	var indirizzoCliente = document.getElementById("indirizzoCliente").textContent.trim().replace(/^Indirizzo di fatturazione:\s*/, '');
	         	var indirizzoConsegna = document.getElementById("indirizzoConsegna").textContent.trim().replace(/^Indirizzo di Spedizione:\s*/, '');
	         	
	            if(nomeCliente != nomeConsegna || cognomeCliente != cognomeConsegna || indirizzoCliente != indirizzoConsegna){
	            	checkbox.form.submit();
	            }
	        } else {
	            form.style.display = 'block';
	        }
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
	    
	    document.getElementById('numeroCarta').addEventListener('input', function (e) {
	        let input = e.target.value;
	        input = input.replace(/\D/g, '');
	        input = input.substring(0, 16);
	        input = input.replace(/(\d{4})(?=\d)/g, '$1 ');
	        e.target.value = input;
	    });
	    
	    document.getElementById('numeroCarta').addEventListener('keyup', function() {
	        var cardNumber = this.value.replace(/\D/g, ''); // Rimuovi caratteri non numerici
	        var cardType = detectCreditCardType(cardNumber.substring(0, 4)); // Controlla solo le prime 4 cifre
	
	        // Ottieni l'elemento del logo della carta di credito
	        var logoElement = document.getElementById('cardLogo');
	
	        // Rimuovi tutte le classi fa-cc-* prima di aggiungere la nuova classe
	        logoElement.className = 'fab';
	
	        if (cardType === 'visa') {
	            logoElement.classList.add('fa-cc-visa');
	        } else if (cardType === 'mastercard') {
	            logoElement.classList.add('fa-cc-mastercard');
	        } else {
	            logoElement.classList.add('fa-credit-card');
	            logoElement.classList.add('fa');
	        }
	    });
    </script>
    
    <script src="js/ValidationUtilsCliente.js"></script>
	<script src="js/ValidationLibraryCliente.js"></script>
    <script src="js/cardPaymentDetect.js"></script>
    <script src="js/scriptFeedback.js"></script>
</body>
</html>
