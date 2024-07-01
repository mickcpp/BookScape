<%@ page import="java.util.Collection" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.GregorianCalendar, java.util.Date, java.util.Calendar"%>
<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.CartItem, net.bookscape.model.Cliente, net.bookscape.model.CartaPagamento"%>
<%@ page import="utility.EscaperHTML"%>

<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
	    <link rel="stylesheet" href="css/style.css">
	   	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	 
	    <title>Profilo Cliente</title>
	    
	    <style>
	        body {
	            font-family: Arial, sans-serif;
		        background-color: #f8f8f8;
	            margin: 0;
	            padding: 0;
	        }
	        .container {
	            width: 60%;
	            margin: -12px auto 40px auto;
	            
	            padding: 30px;
	            background-color: #ffffff;
	            border-radius: 10px;
	            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	        }
	        h1 {
	            text-align: center;
	            color: #333;
	            margin-bottom: 20px;
	            font-size: 2em;
	        }
	        h2 {
	            margin-top: 28px;
	            color: #333;
	            border-bottom: 2px solid #eee;
	            padding-bottom: 10px;
	            font-size: 1.5em;
	        }
	        p {
	            margin: 10px 0;
	            color: #555;
	        }
	        strong {
	            font-weight: bold;
	            color: #333;
	        }
	        #logout {
	            position: absolute;
	            margin-left: 5%;
	            top: 138px;
	            padding-bottom: 10px;
	            font-size: 18px;
	        }
	        .checkout-payment-info {
	            margin-top: 40px;
	        }
	        
	        .checkout-payment-info h2 {
	            color: #333;
	            margin-bottom: 15px;
	            font-size: 1.5em;
	        }
	        
	        .checkout-payment-info p {
	            color: #555;
	        }
	      	
	      	.greenlink{
	            color: #4caf50;
	            text-decoration: none;
	        }
	        
	        .greenlinkunderline{
	        	color: #4caf50;
	            text-decoration: underline;
	        }
	        
	       	div a:hover {
	            text-decoration: underline;
	        }
	        .payment-form {
	            display: none;
	            margin-top: 20px;
	        }
	        .payment-form input, #edit-form input{
	            display: inline-block;
	            width: calc(100% - 150px);
	            padding: 12px;
	            margin-bottom: 15px;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	            font-size: 15px;
	            box-sizing: border-box;  
	        }
	        
	        .payment-form input{
	        	width: 100%;
	        }
	        
	        .payment-form label,
	        #edit-form label,
	        #edit-form-address label {
	            display: inline-block;
	            width: 130px; /* Larghezza fissa per le label */
	            text-align: right; /* Allinea il testo delle label a destra */
	            margin-right: 10px; /* Aggiunge un margine a destra per separare la label dal campo input */
	        }
	        
	        #edit-form-address input{
	            display: inline-block;
	            width: calc(100% - 70px);
	            padding: 10px;
	            margin-bottom: 15px;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	            font-size: 15px;
	            box-sizing: border-box;  
	        }
	        
	      	button {
	            background-color: #28a745;
	            color: #ffffff;
	            padding: 7px 14px;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            font-size: 15px;
	            transition: background-color 0.3s ease;
	        }
	       
	        #edit-form-address button{
	           padding: 10px 12px;
	        }
	        button:hover {
	            background-color: #218838;
	        }
	        #deleteButton{
	        	background-color: red;
	        	color: white;
	        }
	         
	       	hr {
			    border: none; /* Rimuove il bordo predefinito */
			    height: 1px; /* Altezza desiderata dell'hr */
			    background-color: rgba(0, 0, 0, 0.1); /* Colore con trasparenza */
			}
			
			#searchbar-section{
		    	display: none;
		    }
		    
		   	/* General table styling */
			table {
			    width: 100%;
			    border-collapse: collapse;
			    font-family: 'Helvetica Neue', Arial, sans-serif;
			    margin: 20px 0;
			    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
			    border-radius: 8px;
			    overflow: hidden;
			}
			
			/* Table headers */
			th {
			    background-color: #3e4a52;
			    color: #f0f0f0;
			    text-align: left;
			    padding: 12px;
			    font-size: 14px;
			    text-transform: uppercase;
			    letter-spacing: 0.5px;
			}
			
			/* Table cells */
			td {
			    padding: 12px;
			    border-bottom: 1px solid #dcdcdc;
			    font-size: 13px;
			    color: #333;
			}
			
			/* Zebra striping for rows */
			tr:nth-child(even) {
			    background-color: #f8f8f8;
			}
			
			/* Hover effect for rows */
			tr:hover {
			    background-color: #ececec;
			}
			
			/* Styling the unordered list within the cells */
			table ul {
			    list-style-type: none;
			    padding: 0;
			    margin: 0;
			}
			
			table li {
			    background: #e9f0f4;
			    margin: 4px 0;
			    padding: 8px;
			    border-radius: 4px;
			    font-size: 13px;
			    color: #555;
			}
			
			/* Styling for the table caption */
			caption {
			    font-size: 18px;
			    font-weight: bold;
			    margin-bottom: 10px;
			    color: #444;
			}
			
			.form-group {
	            position: relative;
		     }    
		   
		 	.form-group .fa {
	            position: absolute;
	            right: 18px;
	            top: 23px;
	            transform: translateY(-50%);
	            color: #999;
	        }
	        
		    .payment-form .fa{
	        	right: 14px;
	        } 
	        
	      	.fa-cc-visa, .fa-cc-mastercard{
	      		position: absolute;
	            right: 12px;
	            top: 23px;
	            transform: translateY(-50%);
	          	font-size: 1.3em;
	      	}
	      	
		    .error-message {
	            color: #e74c3c;
	            font-size: 0.9em;
	          	margin: -10px 8px 1.55% auto;
	            text-align: right;
	            display: none;
	        }
	        #formDelete{
	        	text-align : right;
	        }
		
			/* Responsive table */
			@media screen and (max-width: 600px) {
			    table, th, td {
			        width: 100%;
			        display: block;
			    }
			
			    th, td {
			        box-sizing: border-box;
			    }
			
			    th {
			        text-align: center;
			    }
			
			    tr {
			        display: block;
			        margin-bottom: 15px;
			    }
			}
		   			  
	    </style>
	</head>
	<body>
	    <%@ include file="template/navbar.jsp" %>
	    <%
	        String id = (String) session.getAttribute("cliente");
	        if(id != null && !id.equals("")) {
	    %>
	    <a id="logout" href="Logout">Logout</a>
	    <%
	        }
	    %>
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
	        
	        @SuppressWarnings("unchecked")
			Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
			if(ordini == null){
				response.sendRedirect("UserControl");
				return;
			}
		%>
		
		<%
	        SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy/MM/dd");
	    %>
	    
	    <div class="container">
	        <h1>Profilo Cliente</h1>
	       	<h3 style="float: right"><a class="greenlinkunderline" href="OrderControl?action=visualizza">I miei acquisti</a></h3>
	        <div>
	            <h2>Dati Personali</h2>
	            <p><strong>Email:</strong> ${EscaperHTML.escapeHTML(cliente.getEmail())}</p>
	            <p><strong>Username:</strong> ${EscaperHTML.escapeHTML(cliente.getUsername())}</p>
	            <p><strong>Nome:</strong> ${EscaperHTML.escapeHTML(cliente.getNome())}</p>
	            <p><strong>Cognome:</strong> ${EscaperHTML.escapeHTML(cliente.getCognome())}</p>
	            <p><strong>Data di Nascita:</strong> <%= EscaperHTML.escapeHTML(dateFormatter.format(cliente.getDataNascita().getTime())) %></p>         
	 			<hr>
	            <p><b>Modifica Dati Personali: </b><a class="greenlink" href="javascript:void(0);" onclick="toggleEditFormData()">Modifica</a></p>
	        </div>
	        <div id="edit-form" style="display: none;">
	            <h2>Modifica Dati Personali</h2>
	            <form action="UpdateUser" method="post" onsubmit="return validateFormPersonalData()">
	                <input type="hidden" name="action" value="updateDatiPersonali">
	                <input type="hidden" name="redirect" value="UserControl">
	                
	                <div class="form-group">
	                	<label for="username">Username:</label>
		                <input type="text" id="username" name="username" value="${cliente.getUsername()}" required>
		                <i class="fa fa-user"></i>
		                <div class="error-message"></div>
	                </div>
	                
	                <div class="form-group">
	                	<label for="nome">Nome:</label>
	                	<input type="text" id="nome" name="nome" value="${cliente.getNome()}" required><br>
		                <i class="fa fa-id-card"></i>
		                <div class="error-message"></div>
	                </div>
	                
	            	<div class="form-group">
	                	<label for="cognome">Cognome:</label>
	                	<input type="text" id="cognome" name="cognome" value="${cliente.getCognome()}" required><br>
		                <i class="fa fa-id-card"></i>
		                <div class="error-message"></div>
	                </div>
	                
	               <%
		               GregorianCalendar dataNascita = cliente.getDataNascita();
		
		               // Ottieni l'anno, il mese e il giorno
		               int year = dataNascita.get(Calendar.YEAR);
		               int month = dataNascita.get(Calendar.MONTH) + 1; // I mesi sono indicizzati a partire da 0
		               int day = dataNascita.get(Calendar.DAY_OF_MONTH);
		
		               // Formatta la data nel formato YYYY-MM-DD
		               String formattedDate = String.format("%04d-%02d-%02d", year, month, day);
	               %>
	                
	                <div class="form-group">
	                	<label for="dataNascita">Data di Nascita:</label>
	                	<input type="date" id="dataNascita" name="dataNascita" value="<%= formattedDate %>"required><br>
		                <div class="error-message"></div>
	                </div>
	                
	                <button type="submit">Salva Modifiche</button>
	            </form>
	        </div>
	        <div>
	            <h2>Indirizzo</h2>
	            <p><strong>Città:</strong> ${EscaperHTML.escapeHTML(cliente.getCitta())}</p>
	            <p><strong>Via:</strong> ${EscaperHTML.escapeHTML(cliente.getVia())}</p>
	            <p><strong>CAP:</strong> ${EscaperHTML.escapeHTML(cliente.getCAP())}</p>
	            <hr>
	            <p><b>Modifica Indirizzo: </b><a class="greenlink" href="javascript:void(0);" onclick="toggleEditAddress()">Modifica</a></p>
	        </div>
	         
	        <div id="edit-form-address" style="display: none">
	            <h2>Modifica Indirizzo</h2>
	            <form action="UpdateUser" method="post" onsubmit="return validateFormAddress()">
	             	<input type="hidden" name="action" value="updateIndirizzo">
	                <input type="hidden" name="redirect" value="UserControl">
	                
	                <div class="form-group">
	                	<input type="text" id="indirizzo" name="indirizzo" placeholder="Via, Città, CAP" required>
	                	<button type="submit">Salva</button>
		                <div class="error-message" style="text-align: left"></div>
	                </div>
	            </form>
	        </div>
	        <div class="checkout-payment-info">
	            <h2>Metodo di Pagamento</h2>
	            <% 
	                CartaPagamento carta = cliente.getCarta();
	                if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) {
	            %>
	                <p>Aggiungi Metodo di Pagamento: <a class="greenlink" href="javascript:void(0);" onclick="togglePaymentForm()">Aggiungi</a></p>
	            <% } else { %>
	                <p>Carta: <%= EscaperHTML.escapeHTML(carta.getNomeCarta()) %> (**** **** **** <%= EscaperHTML.escapeHTML(carta.getNumeroCarta().substring(carta.getNumeroCarta().length() - 4)) %>)</p>
	                <p>Data Scadenza: <%= carta.getDataScadenza().get(Calendar.MONTH) + 1 %>/<%= carta.getDataScadenza().get(Calendar.YEAR) %></p>
	                <p><b>Modifica Metodo di Pagamento: </b><a class="greenlink" href="javascript:void(0);" onclick="togglePaymentForm()">Modifica</a></p>
	                <form action="UpdateUser" method="POST">
	                    <input type="hidden" name="action" value="eliminaPagamento">
	                    <input type="hidden" name="redirect" value="UserControl">
	                    <button id="eliminaCarta" type="submit">Elimina</button>
	                </form>
	            <% } %>
	            <div id="payment-form" class="payment-form" onsubmit="return validateFormPayment()">
	                <form action="UpdateUser" method="post">
	                    <input type="hidden" name="action" value="updatePagamento">
	                    <input type="hidden" name="redirect" value="UserControl">
	                    <div class="form-group">
		                	<input type="text" id="nomeCarta" name="nomeCarta" placeholder="Nome sulla Carta" required>
			                <i class="fa fa-id-card"></i>
			                <div class="error-message" style="text-align: left"></div>
	                	</div>
	                	<div class="form-group">
		                	<input type="text" id="numeroCarta" name="numeroCarta" maxlength="19" autocomplete="cc-number" placeholder="Numero della carta" required>
			                <i id="cardLogo" class="fa fa-credit-card"></i>
			                <div class="error-message" style="text-align: left"></div>
	                	</div>
	                	<div class="form-group">
		                	<input type="month" id="dataScadenza" name="dataScadenza" required>
			                <div class="error-message" style="text-align: left"></div>
	                	</div>
	                	<div class="form-group">
		                	<input type="text" id="cvv" name="cvv" placeholder="CVV" maxlength="3" required>
			                <i class="fa fa-lock"></i>
			                <div class="error-message" style="text-align: left"></div>
	                	</div>
	                   
	                    <button type="submit">Salva Metodo di Pagamento</button>
	                </form>
	            </div>
	        </div>
	        
	       	<hr>
	       	
	       	<form id = "formDelete" method ="post" action ="DeleteUser" >
	       		<button type="submit" id="deleteButton"> Elimina account </button>
	       	</form>
	       	
       		<hr>
		    
		    <table border="1">
		        <caption>Order Details</caption>
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
		        <%
		       	int i = 1;
		        for (Ordine ordine : ordini) { %>
		        <tr>
		        	<td><%= i %></td>
		            <td><%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataOrdine().getTime())) %></td>
		            <td><%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataConsegna().getTime())) %></td>
		            <td><%= EscaperHTML.escapeHTML(ordine.getCitta()) %></td>
		            <td><%= EscaperHTML.escapeHTML(ordine.getVia()) %></td>
		            <td><%= EscaperHTML.escapeHTML(ordine.getCAP()) %></td>
		            <td><%= ordine.getPrezzoTotale() %></td>
		            <td>
		          		<a class="greenlinkunderline" href="" onclick="submitFormInNewPage(<%= i %>, event)">scarica</a>
		            </td>
		        </tr>
		        <%
		        	i++;
		        }
		        
		        %>
		    </table>
	    </div>
	    
	    <%@ include file="template/footer.html" %>
	    
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
	    </script>
	    
	    <script src="js/ValidationUtilsCliente.js"></script>
	    <script src="js/ValidationLibraryCliente.js"></script>
	    <script src="js/cardPaymentDetect.js"></script>
	</body>
</html>