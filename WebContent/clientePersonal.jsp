<%@ page import="net.bookscape.model.Cliente" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <title>Profilo Cliente</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 8px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 4%;
        }
        h1 {
            text-align: center;
            margin-bottom: 30px;
        }
        h2 {
            margin-top: 40px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 10px;
        }
        p {
            margin: 10px 0;
        }
        strong {
            font-weight: bold;
        }
        #logout{
        	position: absolute;
			top: 20%;
			left: 22px;
			font-size: 18px;
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
            <!-- Aggiungi qui altri dettagli personali se necessario -->
        </div>
        <div>
            <h2>Indirizzo</h2>
            <p><strong>Città:</strong> ${cliente.getCitta()}</p>
            <p><strong>Via:</strong> ${cliente.getVia()}</p>
            <p><strong>CAP:</strong> ${cliente.getCAP()}</p>
        </div>
    </div>
    
    <%@ include file="template/footer.html" %>
</body>
</html>
