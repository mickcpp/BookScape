<%@ page import="java.util.Collection" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Date, java.util.Calendar"%>
<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.CartItem, net.bookscape.model.Cliente, net.bookscape.model.CartaPagamento"%>
<%@ page import="utility.EscaperHTML, java.util.UUID"%>

<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>Area Personale</title>
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
	    <link rel="stylesheet" href="css/personalArea.css">
	    <link rel="stylesheet" href="css/feedback.css">
	   	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	   	<link rel="icon" href="img/logo.png" type="image/x-icon">
	</head>
	<body>
	    <%@ include file="template/navbar.jsp" %>
	   	<%
		   	String clienteId = (String) request.getSession().getAttribute("cliente");
		    if(clienteId == null){
		        response.sendRedirect("login-form.jsp");
		        return;
		    }
	    
	        Cliente cliente = (Cliente) request.getAttribute("cliente");
	        if(cliente == null){
	            response.sendRedirect("UserControl");
	            return;
	        }
	        
	     	Boolean admin = (Boolean) request.getSession().getAttribute("adminRole");
		    
	        @SuppressWarnings("unchecked")
			Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
			if(ordini == null){
				response.sendRedirect("UserControl");
				return;
			}
		%>
		
		<%
	        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy/MM/dd");
	    	String redirectUrl = admin != null && admin ? "UserControl?personalAreaAdmin=true" : "UserControl"; 
	    	
	    	String errorMessage = (String) session.getAttribute("errorMessage");
	    	String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 		
	 		session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
			session.removeAttribute("errorMessage");
			
			session.removeAttribute("csrfToken");
            String csrfToken = UUID.randomUUID().toString();
            session.setAttribute("csrfToken", csrfToken);
	    %>
	    
	    <%@ include file="template/feedbackSection.jsp" %>
	    
	   	<div class="container profileContainer mt-2 mt-lg-0">
		    <h1 class="mt-2 mt-lg-1 mb-3 mb-md-2 text-center">Profilo Cliente</h1>
		    <div class="mb-3 mb-md-4">
		        <h2 class="mb-2 pt-1">Dati Personali</h2>
		        <p class="mb-2"><strong>Email:</strong> ${EscaperHTML.escapeHTML(cliente.getEmail())}</p>
		        <p class="mb-2"><strong>Username:</strong> ${EscaperHTML.escapeHTML(cliente.getUsername())}</p>
		        <p class="mb-2"><strong>Nome:</strong> ${EscaperHTML.escapeHTML(cliente.getNome())}</p>
		        <p class="mb-2"><strong>Cognome:</strong> ${EscaperHTML.escapeHTML(cliente.getCognome())}</p>
		        <p class="mb-2"><strong>Data di Nascita:</strong> <%= EscaperHTML.escapeHTML(dateFormatter.format(cliente.getDataNascita().getTime())) %></p>
		    	
		    	<div class="container" style="position: relative">
		    		 <a id="buttonAcquisti" class="btn btn-outline-success" href="OrderControl?action=visualizza">I miei acquisti</a>
		    	</div>
		
		        <hr>
		        <p><b>Modifica Dati Personali: </b><a class="btn btn-outline-primary mx-2" href="javascript:void(0);" onclick="toggleEditFormData()">Modifica</a></p>
		    </div>
		
		    <div id="edit-form" style="display: none;">
		        <h2>Modifica Dati Personali</h2>
		        <div class="error-message" role="alert"><%=errorMessage == null ? "" : errorMessage%></div>
		        <form action="UpdateUser" method="post" onsubmit="return validateFormPersonalData()">
		   			<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
		            <input type="hidden" name="action" value="updateDatiPersonali">
		            <input type="hidden" name="redirect" value="<%=redirectUrl%>">
		            <div class="form-group mb-2">
		                <label for="username">Username:</label>
		                <input type="text" id="username" name="username" class="form-control" value="${EscaperHTML.escapeHTML(cliente.getUsername())}" required>
		                <i class="fa fa-user" style="right: 14px"></i>
		                <div class="error-message"></div>
		            </div>
		            <div class="form-group mb-2">
		                <label for="nome">Nome:</label>
		                <input type="text" id="nome" name="nome" class="form-control" value="${EscaperHTML.escapeHTML(cliente.getNome())}" required>
		                <i class="fa fa-id-card"></i>
		                <div class="error-message"></div>
		            </div>
		            <div class="form-group mb-2">
		                <label for="cognome">Cognome:</label>
		                <input type="text" id="cognome" name="cognome" class="form-control" value="${EscaperHTML.escapeHTML(cliente.getCognome())}" required>
		                <i class="fa fa-id-card"></i>
		                <div class="error-message"></div>
		            </div>
		            <%
		                GregorianCalendar dataNascita = cliente.getDataNascita();
		                int year = dataNascita.get(Calendar.YEAR);
		                int month = dataNascita.get(Calendar.MONTH) + 1;
		                int day = dataNascita.get(Calendar.DAY_OF_MONTH);
		                String formattedDate = String.format("%04d-%02d-%02d", year, month, day);
		            %>
		            <div class="form-group mb-3">
		                <label for="dataNascita">Data di Nascita:</label>
		                <input type="date" id="dataNascita" name="dataNascita" class="form-control" value="<%= EscaperHTML.escapeHTML(formattedDate) %>" required>
		                <div class="error-message"></div>
		            </div>
		            <button type="submit" class="btn btn-primary mb-5">Salva Modifiche</button>
		        </form>
		    </div>
		
		    <div class="mb-3 mb-md-4">
		        <h2 class="mb-2">Indirizzo</h2>
		        <p class="mb-2"><strong>Città:</strong> ${EscaperHTML.escapeHTML(cliente.getCitta())}</p>
		        <p class="mb-2"><strong>Via:</strong> ${EscaperHTML.escapeHTML(cliente.getVia())}</p>
		        <p class="mb-2"><strong>CAP:</strong> ${EscaperHTML.escapeHTML(cliente.getCAP())}</p>
		        <hr>
		        <p><b>Modifica Indirizzo: </b><a class="btn btn-outline-primary mx-2" href="javascript:void(0);" onclick="toggleEditAddress()">Modifica</a></p>
		    </div>
		
		    <div id="edit-form-address" style="display: none;">
		        <h2 class="mb-2">Modifica Indirizzo</h2>
		        <div class="error-message" role="alert"><%=errorMessage == null ? "" : errorMessage%></div>
		        <form action="UpdateUser" method="post" onsubmit="return validateFormAddress()">
		        	<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
		            <input type="hidden" name="action" value="updateIndirizzo">
		            <input type="hidden" name="redirect" value="<%=redirectUrl%>">
		            <div class="form-group mb-3">
		                <input type="text" id="indirizzo" name="indirizzo" class="form-control" placeholder="Via, Città, CAP" required>
		                <div class="error-message"></div>
		            </div>
		            <button type="submit" class="btn btn-primary mb-5">Salva</button>
		        </form>
		    </div>
		
		    <div class="checkout-payment-info mb-4">
		        <h2 class="mb-2">Metodo di Pagamento</h2>
		        <% 
		            CartaPagamento carta = cliente.getCarta();
		            if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) {
		        %>
		            <p>Aggiungi Metodo di Pagamento: <a class="btn btn-outline-primary mx-2" href="javascript:void(0);" onclick="togglePaymentForm()">Aggiungi</a></p>
		        <% } else { %>
		            <p class="mb-2">Carta: <%= EscaperHTML.escapeHTML(carta.getNomeCarta()) %> (**** **** **** <%= EscaperHTML.escapeHTML(carta.getNumeroCarta().substring(carta.getNumeroCarta().length() - 4)) %>)</p>
		            <p class="mb-2">Data Scadenza: <%= carta.getDataScadenza().get(Calendar.MONTH) + 1 %>/<%= carta.getDataScadenza().get(Calendar.YEAR) %></p>
		            <p id="editCardParagrafo"><b>Modifica Metodo di Pagamento: </b><a class="btn btn-outline-primary my-2 my-sm-0 mx-sm-2" href="javascript:void(0);" onclick="togglePaymentForm()">Modifica</a></p>
		            <form id="deleteCardForm" action="UpdateUser" method="POST">
		            	<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
		                <input type="hidden" name="action" value="eliminaPagamento">
		                <input type="hidden" name="redirect" value="<%=redirectUrl%>">
		                <button id="eliminaCarta" type="submit" class="btn btn-danger">Elimina</button>
		            </form>
		        <% } %>
		        <div id="payment-form" class="payment-form" onsubmit="return validateFormPayment()" style="display: none">
		            <div class="error-message" role="alert"><%=errorMessage == null ? "" : errorMessage%></div>
		            <form action="UpdateUser" method="post">
		            	<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
		                <input type="hidden" name="action" value="updatePagamento">
		                <input type="hidden" name="redirect" value="<%=redirectUrl%>">
		                <div class="form-group mb-2">
		                    <input type="text" id="nomeCarta" name="nomeCarta" class="form-control" placeholder="Nome sulla Carta" required>
		                    <i class="fa fa-id-card"></i>
		                    <div class="error-message" style="text-align: left"></div>
		                </div>
		                <div class="form-group mb-2">
		                    <input type="text" id="numeroCarta" name="numeroCarta" class="form-control" maxlength="19" autocomplete="cc-number" placeholder="Numero della carta" required>
		                    <i id="cardLogo" class="fa fa-credit-card"></i>
		                    <div class="error-message" style="text-align: left"></div>
		                </div>
		                <div class="form-group mb-2">
		                    <input type="month" id="dataScadenza" name="dataScadenza" class="form-control" required>
		                    <div class="error-message" style="text-align: left"></div>
		                </div>
		                <div class="form-group mb-3">
		                    <input type="text" id="cvv" name="cvv" class="form-control" placeholder="CVV" maxlength="3" required>
		                    <i class="fa fa-lock" style="right: 15px"></i>
		                    <div class="error-message" style="text-align: left"></div>
		                </div>
		                <button type="submit" class="btn btn-primary">Salva Metodo di Pagamento</button>
		            </form>
		        </div>
		    </div>
		
		    <hr>
		
		    <form id="formDelete" action="DeleteUser" method="post">
		  		<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
		        <button type="button" id="deleteButton" class="btn btn-danger" onclick="openModal()">Elimina account</button>
		    </form>
		
		    <hr>
		
		    <div class="table-responsive mb-4">
		        <table class="table table-striped table-bordered" style="caption-side: top">
		            <caption>Order Details</caption>
		            <thead>
		                <tr>
		                    <th>ID</th>
		                    <th>Data Ordine</th>
		                    <th>Data Consegna</th>
		                    <th>Città</th>
		                    <th>Via</th>
		                    <th>CAP</th>
		                    <th>Prezzo Totale</th>
		                    <th>Fattura</th>
		                </tr>
		            </thead>
		            <tbody>
		                <% int i = 1; for (Ordine ordine : ordini) { %>
		                <tr>
		                    <td><%= i %></td>
		                    <td><%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataOrdine().getTime())) %></td>
		                    <td><%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataConsegna().getTime())) %></td>
		                    <td><%= EscaperHTML.escapeHTML(ordine.getCitta()) %></td>
		                    <td><%= EscaperHTML.escapeHTML(ordine.getVia()) %></td>
		                    <td><%= EscaperHTML.escapeHTML(ordine.getCAP()) %></td>
		                    <td><%= ordine.getPrezzoTotale() %></td>
		                    <td><a class="btn btn-outline-success" href="" onclick="submitFormInNewPage(<%= i %>, event)">scarica</a></td>
		                </tr>
		                <% i++; } %>
		            </tbody>
		        </table>
		    </div>

			<div id="deleteModal" class="deleteModal align-content-center">
			    <div class="modal-content-delete col-10 col-md-6" style="position: relative; bottom: 24px;">
			        <span class="close" onclick="closeModal()">&times;</span>
			        <p>Per favore, inserisci "ELIMINA" nel campo di testo per confermare l'eliminazione dell'account:</p>
			 
			   		<div class="row d-flex justify-content-center">
			   			<input class="col-7 col-md-8 me-2" type="text" id="deleteConfirmationInput" autocomplete="off">
			   			<button class="col-4 col-md-3" onclick="deleteAccount()">Conferma</button>
			   		</div>
			    </div>
			</div>
		</div>

	    
	    <%@ include file="template/footer.jsp"%>
	    
	    <script>    
	        function toggleEditFormData() {
	            const form = document.getElementById('edit-form');
	            form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
	        }
	        function toggleEditAddress() {
	            const form = document.getElementById('edit-form-address');
	            form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
	        }
	        function togglePaymentForm() {
	            const form = document.getElementById('payment-form');
	            form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
	        }
	        
	        function submitFormInNewPage(i) {
	            event.preventDefault(); // Previene il comportamento di default del link
	
	            var newWindow = window.open('acquisti.jsp', '_blank', 'width=1,height=1');
	         
	            // Attende che la nuova pagina sia caricata e inviare il modulo
	            newWindow.onload = function() {
	                newWindow.document.getElementsByTagName('html')[0].style.display = 'none';
	                newWindow.document.getElementById('scaricaFattura' + i).submit();
	                setTimeout(function() {
	                    newWindow.close();
	                }, 80);
	            };
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
		    
		    // Funzione per aprire il modal di eliminazione account
		    function openModal() {
		        var modal = document.getElementById('deleteModal');
		        modal.style.display = 'block';
		    }

		    // Funzione per chiudere il modal di eliminazione account
		    function closeModal() {
		        var modal = document.getElementById('deleteModal');
		        modal.style.display = 'none';
		    }

		    // Funzione per eliminare l'account
		    function deleteAccount() {
		        var userInput = document.getElementById('deleteConfirmationInput').value.trim();
		        if (userInput === 'ELIMINA') {
		            document.getElementById('formDelete').submit(); // Invia il modulo per eliminare l'account
		        } else {
		            alert('Inserisci correttamente "ELIMINA" per confermare la cancellazione.');
		        }
		    }
	    </script>
	    
	    <script src="js/ValidationUtilsCliente.js"></script>
	    <script src="js/ValidationLibraryCliente.js"></script>
	    <script src="js/cardPaymentDetect.js"></script>
	    <script src="js/scriptFeedback.js"></script>
	   	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>