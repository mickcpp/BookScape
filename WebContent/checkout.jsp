<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, net.bookscape.model.CartItem"%>
<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.Cliente, net.bookscape.model.CartaPagamento"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
        }

        .checkout-container {
            width: 60%;
            margin: 20px auto;
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
            display: block;
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
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
    </style>
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
	    
    </script>
</head>
<body>
    <%@ include file="template/navbar.jsp" %>

    <%
        Ordine ordine = (Ordine) request.getAttribute("ordine");
        Cliente cliente = (Cliente) request.getAttribute("cliente");

        if (ordine == null || cliente == null){
            response.sendRedirect("./");
            return;
        }

        CartaPagamento carta = cliente.getCarta();
    %>

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
                            <td><%=item.getProduct().getNome() %></td>
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
                        <td>${ordine.prezzoTotale}</td>
                    </tr>
                </tfoot>
            </table>
        </div>

        <div class="checkout-customer-info">
            <h2>Informazioni di fatturazione</h2>
            <p id="nomeCliente"><strong>Nome: </strong>${cliente.nome}</p>
            <p id="cognomeCliente"><strong>Cognome: </strong>${cliente.cognome}</p>
            <p><strong>Email: </strong>${cliente.email}</p>
            <p id="indirizzoCliente"><strong>Indirizzo di fatturazione: </strong>${cliente.via}, ${cliente.citta}, ${cliente.CAP}</p>
        </div>
        
		<div class="checkout-billing-info">
            <h2>Dati di spedizione</h2>
       		
           	<strong>Utilizza indirizzo di fatturazione per la spedizione: </strong>
          	<form style="display: inline-block" action="OrderControl" method="POST">
          		<input type="hidden" name="action" value="checkout">
          		<input type="checkbox" id="useShippingForBilling" onchange="toggleBillingForm()" <%if(request.getAttribute("fatturazioneCheckbox") == null){ %> checked <% } %>>
       		</form>

       		<p id="nomeConsegna"><strong>Nome: </strong>${ordine.nomeConsegna}</p>
            <p id="cognomeConsegna"><strong>Cognome: </strong>${ordine.cognomeConsegna}</p>
            <p id="indirizzoConsegna"><strong>Indirizzo di Spedizione: </strong>${ordine.via}, ${ordine.citta}, ${ordine.CAP}</p>
        </div>
        
        <div id="checkout-billing-form">
            <h2>Inserisci Dati di Spedizione</h2>
            <form action="OrderControl" method="post">
                <input type="hidden" name="action" value="checkout">
                <input type="hidden" name="option" value="updateSpedizione">
                <input type="text" name="nomeSpedizione" placeholder="Nome" required>
                <input type="text" name="cognomeSpedizione" placeholder="Cognome" required>
                <input type="text" name="indirizzoSpedizione" placeholder="Via, Città, CAP" required>
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
			    <p>Carta: <%= carta.getNomeCarta() %> (<%= cardNumber %>)</p>
			    <p>Data Scadenza: <%= dataScadenza %></p>
			    <p><strong>Modifica Metodo di Pagamento: </strong><a href="javascript:void(0);" onclick="togglePaymentForm()">Modifica</a></p>
			<%
			    }
			%>
			
			<div id="payment-form" class="payment-form">
                <form action="UpdateUser" method="post">
                    <input type="hidden" name="action" value="updatePagamento">
                    <input type="hidden" name="redirect" value="checkout.jsp">
                    <input type="text" name="nomeCarta" placeholder="Nome sulla Carta" required>
                    <input type="text" name="numeroCarta" placeholder="Numero della Carta" required>
                    <input type="month" name="dataScadenza" required>
                    <input type="text" name="cvv" placeholder="CVV" required>
                    <button type="submit">Salva Metodo di Pagamento</button>
                </form>
            </div>
        </div>

        <form style="text-align: center" action="OrderControl" method="post">
            <% if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) { %>
                <button type="submit" disabled>Conferma Acquisto</button>
            <% } else { %>
                <button type="submit">Conferma Acquisto</button>
            <% } %>
        </form>
    </div>

    <%@ include file="template/footer.html" %>
</body>
</html>
