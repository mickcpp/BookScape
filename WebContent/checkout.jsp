<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, net.bookscape.model.CartItem, net.bookscape.model.Ordine, net.bookscape.model.Cliente, net.bookscape.model.CartaPagamento" %>
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

        .checkout-customer-info p, .checkout-payment-info p {
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

        .checkout-payment-info a {
            color: #4caf50;
            text-decoration: none;
        }

        .checkout-payment-info a:hover {
            text-decoration: underline;
        }

        .payment-form {
            display: none;
            margin-top: 20px;
        }

        .payment-form input {
            display: block;
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
    <script>
        function togglePaymentForm() {
            var form = document.getElementById('payment-form');
            form.style.display = form.style.display === 'none' ? 'block' : 'none';
        }
    </script>
</head>
<body>
    <%@ include file="template/navbar.html" %>
    
    <%
		Ordine ordine = (Ordine) request.getAttribute("ordine");
		Cliente cliente = (Cliente) request.getAttribute("cliente");
		
		if(ordine == null || cliente == null){
			response.sendRedirect("./");
			return;
		}
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
            <h2>Informazioni Cliente</h2>
            <p>Nome: ${cliente.nome}</p>
            <p>Cognome: ${cliente.cognome}</p>
            <p>Email: ${cliente.email}</p>
            <p>Indirizzo di Spedizione: ${cliente.via}, ${cliente.citta}, ${cliente.CAP}</p>
        </div>
        
        <div class="checkout-payment-info">
            <h2>Metodo di Pagamento</h2>
            <% 
                CartaPagamento carta = cliente.getCarta();
                if (carta == null || carta.getNomeCarta() == null || carta.getNumeroCarta() == null || carta.getDataScadenza() == null) {
            %>
                <p>Aggiungi Metodo di Pagamento: <a href="javascript:void(0);" onclick="togglePaymentForm()">Aggiungi</a></p>
            <% } else { %>
                <p>Carta: <%= carta.getNomeCarta() %> (**** **** **** <%= carta.getNumeroCarta().substring(carta.getNumeroCarta().length() - 4) %>)</p>
                <p>Data Scadenza: <%= carta.getDataScadenza().get(Calendar.MONTH) + 1 %>/<%= carta.getDataScadenza().get(Calendar.YEAR) %></p>
            <% } %>

            <div id="payment-form" class="payment-form">
                <form action="UserControl?action=updatePagamento" method="post">
                    <input type="text" name="nomeCarta" placeholder="Nome sulla Carta" required>
                    <input type="text" name="numeroCarta" placeholder="Numero della Carta" required>
                    <input type="text" name="dataScadenza" placeholder="Data di Scadenza (MM/YY)" required>
                    <input type="text" name="cvv" placeholder="CVV" required>
                    <button type="submit">Salva Metodo di Pagamento</button>
                </form>
            </div>
        </div>
        
        <form style="text-align: center" action="confermaAcquisto.jsp" method="post">
            <button type="submit">Conferma Acquisto</button>
        </form>
    </div>
    
    <%@ include file="template/footer.html" %>
</body>
</html>
