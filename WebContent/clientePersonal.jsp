<%@ page import="net.bookscape.model.Cliente, net.bookscape.model.CartaPagamento, java.util.Calendar" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap">
    <link rel="stylesheet" href="css/style.css">
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
            margin: 40px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
            font-size: 2.3em;
        }
        h2 {
            margin-top: 30px;
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
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }
        .payment-form button {
            background-color: #28a745;
            color: #ffffff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .payment-form button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
    <%@ include file="template/navbar.html" %>
    <%
        String id = (String) session.getAttribute("cliente");
        if(id != null && !id.equals("")){
            %>
            <a id="logout" href="Logout">Logout</a>
            <%
        }
    %>
    <%
        Cliente cliente = (Cliente) request.getAttribute("cliente");
        if(cliente == null){
            response.sendRedirect("login-form.jsp");
            return;
        }
    %>
    <div class="container">
        <h1>Profilo Cliente</h1>
        <div>
            <h2>Dati Personali</h2>
            <p><strong>Email:</strong> ${cliente.getEmail()}</p>
            <p><strong>Username:</strong> ${cliente.getUsername()}</p>
            <p><strong>Nome:</strong> ${cliente.getNome()}</p>
            <p><strong>Cognome:</strong> ${cliente.getCognome()}</p>
            <p><strong>Data di Nascita:</strong> ${cliente.getDataNascita().time}</p>
        </div>
        <div>
            <h2>Indirizzo</h2>
            <p><strong>Città:</strong> ${cliente.getCitta()}</p>
            <p><strong>Via:</strong> ${cliente.getVia()}</p>
            <p><strong>CAP:</strong> ${cliente.getCAP()}</p>
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
                <p><b>Modifica Metodo di Pagamento: </b><a href="javascript:void(0);" onclick="togglePaymentForm()">Modifica</a></p>
            <% } %>
            <div id="payment-form" class="payment-form">
                <form action="UpdateUser" method="post">
                    <input type="hidden" name="action" value="updatePagamento">
                    <input type="hidden" name="redirect" value="UserControl">
                    <input type="text" name="nomeCarta" placeholder="Nome sulla Carta" required>
                    <input type="text" name="numeroCarta" placeholder="Numero della Carta" required>
                    <input type="month" name="dataScadenza" required>
                    <input type="text" name="cvv" placeholder="CVV" required>
                    <button type="submit">Salva Metodo di Pagamento</button>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="template/footer.html" %>
    <script>
        function togglePaymentForm() {
            const form = document.getElementById('payment-form');
            form.style.display = form.style.display === 'none' || form.style.display === '' ? 'block' : 'none';
        }
    </script>
</body>
</html>
