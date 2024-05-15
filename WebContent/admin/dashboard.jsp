<%@page import="net.bookscape.model.Amministratore"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection, net.bookscape.model.Cliente, net.bookscape.model.Product" %>
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
            z-index: 2; /* Incrementato per garantire che l'intestazione sia sempre sopra il contenuto */
            padding-top: 15px;
        }

        tbody tr:hover {
            background-color: #f5f5f5;
        }
    </style>
</head>
<body>
    <%
        // Assuming "clienti" attribute contains a collection of Cliente objects
        Collection<Cliente> clienti = (Collection<Cliente>) request.getAttribute("clienti");
        Collection<String> listaAdmin = (Collection<String>) request.getAttribute("listaAdmin");
        Collection<Product> prodotti = (Collection<Product>) request.getAttribute("prodotti");
        if(clienti == null || listaAdmin == null || prodotti == null){
            response.sendRedirect("/BookScape/UserControl");
            return;
        }
    %>

    <%@ include file="/template/navbar.html" %>

    <div class="container">
        <h1>Admin Dashboard</h1>

        <div class="sezione">
            <h2>Manage Products</h2>
            <button onclick="location.href='ProductControl'">Aggiungi nuovo prodotto</button>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Nome</th>
                            <th>Prezzo</th>
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
                            <td>
                                <button onclick="location.href='ProductControl'">Modifica</button>
                                <button onclick="location.href='ProductControl'">Elimina</button>
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
                                    <button onclick="changeUserRole?id=<%=cliente.getEmail()%>&role=cliente">Riporta a utente</button>
                                <%
                                    } else {
                                %>
                                    <button onclick="changeUserRole?id=<%=cliente.getEmail()%>&role=admin">Promuovi ad admin</button>
                                <%
                                    }
                                %>
                                <button onclick="DeleteUser?id=<%=cliente.getEmail()%>)">Elimina</button>
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

<script>
    function deleteProduct(productId) {
        if(confirm('Are you sure you want to delete this product?')) {
            // Logic to delete product
            alert('Product ' + productId + ' deleted.');
        }
    }

    function deleteUser(userId) {
        if(confirm('Are you sure you want to delete this user?')) {
            // Logic to delete user
            alert('User ' + userId + ' deleted.');
        }
    }

    function changeUserRole(userId, role) {
        // Logic to change user role
        alert('User ' + userId + ' role changed to ' + role + '.');
    }
</script>
