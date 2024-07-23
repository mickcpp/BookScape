<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, net.bookscape.model.CartItem"%>
<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.Cliente, net.bookscape.model.CartaPagamento"%>
<%@ page import="utility.EscaperHTML, java.util.UUID"%>

<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Checkout</title>
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link rel="stylesheet" href="css/checkout.css">
	    <link rel="stylesheet" href="css/feedback.css">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	    <link rel="icon" href="img/logo.png" type="image/x-icon">
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
	
		<div class="container mt-3 mt-md-5">
		    <!-- Riepilogo ordine  -->
		    <div class="row mb-4">
		        <div class="col-lg-8">
		            <h2 class="mb-4">Riepilogo dell'ordine</h2>
		            <div class="card">
		                <div class="card-body">
		                    <table class="table table-bordered">
		                        <thead>
		                            <tr>
		                                <th>Prodotto</th>
		                                <th>Quantità</th>
		                                <th>Prezzo (IVA inclusa)</th>
		                            </tr>
		                        </thead>
		                        <tbody>
		                            <% for (CartItem item : ordine.getProdotti()) { %>
		                                <tr>
		                                    <td><%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %></td>
		                                    <td><%= item.getNumElementi() %></td>
		                                    <td><%= Math.round(item.getProduct().getPrezzo() * 1000.0) / 1000.0%></td>
		                                </tr>
		                            <% } %>
		                        </tbody>
		                        <tfoot>
		                            <tr>
		                                <td colspan="2" class="text-end"><strong>Totale:</strong></td>
		                                <td><%= Math.round(ordine.getPrezzoTotale() * 100.0) / 100.0%></td>
		                            </tr>
		                        </tfoot>
		                    </table>
		                </div>
		            </div>
		        </div>
		
		        <!-- Informazioni di fatturazione -->
		        <div class="col-lg-4 mb-1 mt-4 mt-lg-0">
		            <h2 class="mb-4">Informazioni di fatturazione</h2>
		            <div class="card">
		                <div class="card-body">
		                    <p id="nomeCliente"><strong>Nome:</strong> <%= EscaperHTML.escapeHTML(clienteOrder.getNome()) %></p>
		                    <p id="cognomeCliente"><strong>Cognome:</strong> <%= EscaperHTML.escapeHTML(clienteOrder.getCognome()) %></p>
		                    <p><strong>Email:</strong> <%= EscaperHTML.escapeHTML(clienteOrder.getEmail()) %></p>
		                    <p id="indirizzoCliente"><strong>Indirizzo di fatturazione:</strong> <%= EscaperHTML.escapeHTML(clienteOrder.getVia()) %>, <%= EscaperHTML.escapeHTML(clienteOrder.getCitta()) %>, <%= EscaperHTML.escapeHTML(clienteOrder.getCAP()) %></p>
		                </div>
		            </div>
		        </div>
		    </div>
		
		    <!-- Informazioni di spedizione -->
		    <div class="row mb-4 mt-4 mt-md-0 checkout-billing-info">
		        <div class="col-lg-8">
		            <h2 class="mb-4">Dati di spedizione</h2>
		            <div class="card">
		                <div class="card-body">
		                    <form action="OrderControl" method="POST" class="mb-4">
		                        <input type="hidden" name="action" value="checkout">
		                        <div class="form-check">
		                            <input type="checkbox" class="form-check-input" id="useShippingForBilling" onchange="toggleBillingForm()" <% if (fatturazioneCheckbox == null) { %> checked <% } %>>
		                            <label class="form-check-label" for="useShippingForBilling">Utilizza indirizzo di fatturazione per la spedizione</label>
		                        </div>
		                    </form>
		                    <p id="nomeConsegna"><strong>Nome:</strong> <%= EscaperHTML.escapeHTML(ordine.getNomeConsegna()) %></p>
		                    <p id="cognomeConsegna"><strong>Cognome:</strong> <%= EscaperHTML.escapeHTML(ordine.getCognomeConsegna()) %></p>
		                    <p id="indirizzoConsegna"><strong>Indirizzo di Spedizione:</strong> <%= EscaperHTML.escapeHTML(ordine.getVia()) %>, <%= EscaperHTML.escapeHTML(ordine.getCitta()) %>, <%= EscaperHTML.escapeHTML(ordine.getCAP()) %></p>
		                </div>
		            </div>
		        </div>
		
		        <!-- Form dati di spedizione -->
		        <div class="col-lg-4 mt-4 mt-lg-0" id="checkout-billing-form">
		            <h2 class="mb-4">Inserisci Dati di Spedizione</h2>
		            <div class="alert alert-danger <% if (errorMessage == null) { %> d-none <% } %>">
		                <%= errorMessage == null ? "" : errorMessage %>
		            </div>
		            <form action="OrderControl" method="post" onsubmit="return validateFormShipping()">
		                <input type="hidden" name="action" value="checkout">
		                <input type="hidden" name="option" value="updateSpedizione">
		                <div class="form-group mb-2">
		                    <input type="text" class="form-control" id="nomeSpedizione" name="nomeSpedizione" placeholder="Nome" required>
			                <i class="fa fa-id-card"></i>
			                <div class="error-message"></div>
		                </div>
		                <div class="form-group mb-2">
		                    <input type="text" class="form-control" id="cognomeSpedizione" name="cognomeSpedizione" placeholder="Cognome" required>
		                	 <i class="fa fa-id-card"></i>
			                <div class="error-message"></div>
		                </div>
		                <div class="form-group mb-3">
		                    <input type="text" class="form-control" id="indirizzoSpedizione" name="indirizzoSpedizione" placeholder="Via, Città, CAP" required>
		                	<i class="fa fa-city"></i>
			                <div class="error-message"></div>
		                </div>
		                <button type="submit" class="btn btn-primary">Salva dati di spedizione</button>
		            </form>
		        </div>
		    </div>
		
		    <!--  Informazioni di pagamento -->
		    <div class="row mb-4 mt-4 mt-md-0">
		        <div class="col-lg-8">
		            <h2 class="mb-4">Metodo di Pagamento</h2>
		            <div class="card">
		                <div class="card-body">
		                    <% if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) { %>
		                        <p>Aggiungi Metodo di Pagamento: <a href="javascript:void(0);" onclick="togglePaymentForm()">Aggiungi</a></p>
		                    <% } else { %>
		                        <p><strong>Carta:</strong> <%= EscaperHTML.escapeHTML(carta.getNomeCarta()) %> (<%= EscaperHTML.escapeHTML("**** **** **** " + carta.getNumeroCarta().substring(carta.getNumeroCarta().length() - 4)) %>)</p>
		                        <p><strong>Data Scadenza:</strong> <%= EscaperHTML.escapeHTML((carta.getDataScadenza().get(Calendar.MONTH) + 1) + "/" + carta.getDataScadenza().get(Calendar.YEAR)) %></p>
		                        <p><strong>Modifica Metodo di Pagamento:</strong> <a href="javascript:void(0);" onclick="togglePaymentForm()">Modifica</a></p>
		                    <% } %>
		                </div>
		            </div>
		      	<%
		            String csrfToken = UUID.randomUUID().toString();
                	session.setAttribute("csrfToken", csrfToken);
               	%>
		            <!--  Pulsante conferma acquisto -->
				    <div class="mt-3 mb-5">
				 		<form action="OrderControl" method="post" style="position: relative">
				            <input type="hidden" name="action" value="acquista">
				            <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
				            <input type="hidden" name="nomeConsegna" value="<%= EscaperHTML.escapeHTML(ordine.getNomeConsegna()) %>">
				            <input type="hidden" name="cognomeConsegna" value="<%= EscaperHTML.escapeHTML(ordine.getCognomeConsegna()) %>">
				            <input type="hidden" name="viaConsegna" value="<%= EscaperHTML.escapeHTML(ordine.getVia()) %>">
				            <input type="hidden" name="cittaConsegna" value="<%= EscaperHTML.escapeHTML(ordine.getCitta()) %>">
				            <input type="hidden" name="capConsegna" value="<%= EscaperHTML.escapeHTML(ordine.getCAP()) %>">
				            <button style="position: absolute" type="submit" class="btn btn-success <% if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) { %> disabled <% } %>">Conferma Acquisto</button>
				        </form>
				    </div>
		        </div>
		
		       	<div id="payment-form" class="payment-form col-lg-4 mt-4 mt-lg-0">
		       		<h2 class="mb-4">Inserisci Dati di Pagamento</h2>
		            <div class="alert alert-danger <% if (errorMessage == null) { %> d-none <% } %>">
		                <%= errorMessage == null ? "" : errorMessage %>
		            </div>
			        <form action="UpdateUser" method="post" onsubmit="return validateFormPayment()">
			            <input type="hidden" name="action" value="updatePagamento">
			            <input type="hidden" name="redirect" value="OrderControl?action=checkout">
			            <div class="form-group mb-2">
			                <input type="text" class="form-control" id="nomeCarta" name="nomeCarta" placeholder="Nome sulla Carta" required>
			            	<i class="fa fa-id-card"></i>
				        	<div class="error-message"></div>
			            </div>
			            <div class="form-group mb-2">
			                <input type="text" class="form-control" id="numeroCarta" name="numeroCarta" maxlength="19" autocomplete="cc-number" placeholder="Numero della carta" required>
			            	<i id="cardLogo" class="fa fa-credit-card"></i>
				        	<div class="error-message"></div>
			            </div>
			            <div class="form-group mb-2">
			                <input type="month" class="form-control" id="dataScadenza" name="dataScadenza" required>
			                 <div class="error-message"></div>
			            </div>
			            <div class="form-group mb-3">
			                <input type="text" class="form-control" id="cvv" name="cvv" placeholder="CVV" maxlength="3" required>
			            	<i class="fa fa-lock" style="right: 15px"></i>
				          	<div class="error-message"></div>
			            </div>
			            <button type="submit" class="btn btn-primary">Salva Metodo di Pagamento</button>
			        </form>
			 	</div>
		    </div>
		</div>
	        
	    <%@ include file="template/footer.jsp"%>
	    
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
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>
