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
      	
      	a{
            color: #4caf50;
            text-decoration: none;
        }
        
       	a:hover {
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
            width: calc(100% - 150px);
            padding: 6.7px;
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
       
        button:hover {
            background-color: #218838;
        }
         
       	hr {
		    border: none; /* Rimuove il bordo predefinito */
		    height: 1px; /* Altezza desiderata dell'hr */
		    background-color: rgba(0, 0, 0, 0.1); /* Colore con trasparenza */
		}
    </style>
</head>
<body>
    <%@ include file="template/navbar.html" %>
    <%
        String id = (String) session.getAttribute("cliente");
        if(id != null && !id.equals("")) {
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
 			<hr>
            <p><b>Modifica Dati Personali: </b><a href="javascript:void(0);" onclick="toggleEditFormData()">Modifica</a></p>
        </div>
        <div id="edit-form" style="display: none;">
            <h2>Modifica Dati Personali</h2>
            <form action="UpdateUser" method="post">
                <input type="hidden" name="action" value="updateDatiPersonali">
                <input type="hidden" name="redirect" value="UserControl">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="${cliente.getEmail()}" required><br>
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="${cliente.getUsername()}" required><br>
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${cliente.getNome()}" required><br>
                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome" value="${cliente.getCognome()}" required><br>
                <label for="dataNascita">Data di Nascita:</label>
                <input type="date" id="dataNascita" name="dataNascita" value="${cliente.getDataNascita()}" required><br>
                <button type="submit">Salva Modifiche</button>
            </form>
        </div>
        <div>
            <h2>Indirizzo</h2>
            <p><strong>Città:</strong> ${cliente.getCitta()}</p>
            <p><strong>Via:</strong> ${cliente.getVia()}</p>
            <p><strong>CAP:</strong> ${cliente.getCAP()}</p>
            <hr>
            <p><b>Modifica Indirizzo: </b><a href="javascript:void(0);" onclick="toggleEditAddress()">Modifica</a></p>
        </div>
         
        <div id="edit-form-address" style="display: none">
            <h2>Modifica Indirizzo</h2>
            <form action="UpdateUser" method="post">
                <input type="text" name="indirizzo" placeholder="Via, Città, CAP" required>
                <button type="submit">Salva</button>
            </form>
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
                <form action="UpdateUser" method="POST">
                    <input type="hidden" name="action" value="eliminaPagamento">
                    <input type="hidden" name="redirect" value="UserControl">
                    <button id="eliminaCarta" type="submit">Elimina</button>
                </form>
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
    </script>
</body>
</html>
