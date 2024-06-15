<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection, net.bookscape.model.Cliente, net.bookscape.model.Product" %>
<%@ page import="net.bookscape.model.Libro" %>
<%@ page import="net.bookscape.model.Musica" %>
<%@ page import="net.bookscape.model.Gadget" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: auto;
            overflow: hidden;
        }

        h1, h2 {
            color: #333;
        }

        .sezione {
            background: #fff;
            padding: 20px;
            margin: 20px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            padding: 10px 15px;
            margin: 5px;
            border: none;
            background-color: #5cb85c;
            color: white;
            cursor: pointer;
            border-radius: 3px;
        }

        button:hover {
            background-color: #4cae4c;
        }

        .table-container {
            max-height: 400px;
            overflow-y: auto;
            border: 1px solid #ddd;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        thead th {
            position: sticky;
            top: 0;
            background-color: #f2f2f2;
            z-index: 2;
            padding-top: 15px;
        }

        tbody tr:hover {
            background-color: #f5f5f5;
        }
        
        #logout{
            margin-left: 5%;
            padding-bottom: 10px;
            font-size: 18px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
        }

        .form-group select, .form-group input {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group button {
            width: auto;
            margin-top: 10px;
        }

    </style>
</head>
<body>
    <%
    	@SuppressWarnings("unchecked")
        Collection<Cliente> clienti = (Collection<Cliente>) request.getAttribute("clienti");
    
    	@SuppressWarnings("unchecked")
        Collection<String> listaAdmin = (Collection<String>) request.getAttribute("listaAdmin");
    	
    	@SuppressWarnings("unchecked")
        Collection<Product> prodotti = (Collection<Product>) request.getAttribute("prodotti");
        
        if(clienti == null || listaAdmin == null || prodotti == null){
            response.sendRedirect("/BookScape/UserControl");
            return;
        }
    %>

    <%@ include file="/template/navbar.jsp" %>

    <%
        String id = (String) session.getAttribute("cliente");
        if(id != null && !id.equals("")){
    %>
        <a id="logout" href="Logout">Logout</a>
    <%
        }
    %>

    <div class="container">
        <h1>Admin Dashboard</h1>

        <div class="sezione">
            <h2>Manage Products</h2>
 			<form action="ProductControl" method="post">
 				<input type="hidden" name="action" value="viewInsert">
           		<input type="radio" name="type" value="libro" id="libro" checked>
           		<label for="libro">Libro</label>
           		<input type="radio" name="type" value="musica" id="musica">
           		<label for="musica">Musica</label>
           		<input type="radio" name="type" value="gadget" id="gadget">
           		<label for="gadget">Gadget</label>
          		<button type="submit">Aggiungi nuovo prodotto</button>
 			</form>
       
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Nome</th>
                            <th>Prezzo</th>
                            <th>Quantità</th>
                            <th>Azione</th>
                        </tr>
                    </thead>
                    <tbody>
					    <%
					    if (prodotti != null) {
					        for (Product p : prodotti) {
					    %>
					    <tr>
					        <td><%= p.getId() %></td>
					        <td><%= p.getNome() %></td>
					        <td><%= p.getPrezzo() %></td>
					        <td><%= p.getQuantita() %></td>
					        <td>
					            <button onclick="location.href='ProductControl?productId=<%= p.getId() %>&action=viewEdit'">Modifica</button>
					            <button onclick="location.href='ProductControl?productId=<%= p.getId() %>&action=rimuovi'">Elimina</button>
					        </td>
					    </tr>
					    <%
					        }
					    }
					    %>
					</tbody>
                    
                </table>
            </div>
        </div>
        
        <div class="sezione">
            <h2>Manage Users</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Nome</th>
                            <th>Ruolo</th>
                            <th>Azione</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (clienti != null) {
                                int userId = 1;
                                for (Cliente cliente : clienti) {
                        %>
                        <tr>
                            <td><%= userId %></td>
                            <td><%= cliente.getUsername() %></td>
                            <td><%= cliente.getEmail() %></td>
                            <td><%= cliente.getNome() %></td>
                            <td>
                                <%
                                    boolean admin = false;
                                    if(listaAdmin.contains(cliente.getEmail())){
                                        out.print("admin");
                                        admin = true;
                                    } else {
                                        out.print("cliente");
                                    }
                                %>
                            </td>
                            <td>
                                <%
                                    if(admin){
                                %>
                                    <button onclick="location.href='UserManagement?id=<%=cliente.getEmail()%>&action=changeRole&role=cliente'">Riporta a utente</button>
                                <%
                                    } else {
                                %>
                                    <button onclick="location.href='UserManagement?id=<%=cliente.getEmail()%>&action=changeRole&role=admin'">Promuovi ad admin</button>
                                    <button onclick="location.href='UserManagement?id=<%=cliente.getEmail()%>&action=rimuovi'">Elimina</button>
                                <%
                                   	}
                            	%>
                            </td>
                        </tr>
                        <%
                                    userId++;
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <%@ include file="/template/footer.html" %>
</body>
</html>
