<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection, net.bookscape.model.Cliente, net.bookscape.model.Product" %>
<%@ page import="net.bookscape.model.Libro, net.bookscape.model.Ordine" %>
<%@ page import="net.bookscape.model.Musica, java.text.SimpleDateFormat" %>
<%@ page import="net.bookscape.model.Gadget, java.util.Date" %>
<%@ page import="utility.EscaperHTML"%>

<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <title>Admin Dashboard</title>
	    <link rel="stylesheet" href="css/style.css">
	    <link rel="stylesheet" href="css/feedback.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    
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
	         	z-index: 998;
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
	        
	        #logout {
	            position: absolute;
	            margin-left: 3%;
	            top: 130px;
	            margin-bottom: 20px;
	            font-size: 18px;
	        }
	
	        #searchBar {
	            margin-bottom: 20px;
	        }
	        
	    	.deleteModal {
		        display: none; /* Modal nascosto di default */
		        position: fixed;
		        z-index: 1;
		        left: 0;
		        top: 0;
		        width: 100%;
		        height: 100%;
		        overflow: auto;
		        background-color: rgba(0,0,0,0.5); /* Sfondo semitrasparente */
		     	z-index: 999;
		    }
		
		    .modal-content-delete {
		        background-color: #fefefe;
		        margin: 15% auto;
		        padding: 20px;
		        border: 1px solid #888;
		        width: 50%;
		        border-radius: 10px;
		        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
		        position: relative;
		    }
		
		    .close {
		        color: #aaa;
		        float: right;
		        font-size: 28px;
		        font-weight: bold;
		     	margin-right: 3%;
		    }
		
		    .close:hover,
		    .close:focus {
		        color: black;
		        text-decoration: none;
		        cursor: pointer;
		    }
		
		    /* Stili per il campo di input nel modal */
		    .modal-content-delete input[type=text] {
		        width: 84%;;
		        padding: 10px 18px;
		        box-sizing: border-box;
		        border: 1px solid #ccc;
		        border-radius: 4px;
		    }
		
		    /* Stili per il bottone nel modal */
		    .modal-content-delete button {
		        background-color: #4CAF50;
		        color: white;
		        padding: 10px 18px;
		        border: none;
		        border-radius: 4px;
		        cursor: pointer;
		     	width: 14%;
		     	box-sizing: border-box;
		    }
		
		    .modal-content-delete button:hover {
		        background-color: #45a049;
		    }	  
		    
		    #formDelete{
	      		display: inline-block;
	        }
	    </style>
	    
	    <script>
	        $(document).ready(function(){
	            $("#searchBar").on("keyup", function() {
	                var value = $(this).val().toLowerCase();
	                $.ajax({
	                    url: 'ProductSearchAdmin',
	                    type: 'GET',
	                    data: { query: value },
	                    success: function(data) {
	                        $("#productTable tbody").html(data);
	                    }
	                });
	            });
	        });
	    </script>
	</head>
	<body>
	    <%
	        @SuppressWarnings("unchecked")
	        Collection<Cliente> clienti = (Collection<Cliente>) request.getAttribute("clienti");
	    
	        @SuppressWarnings("unchecked")
	        Collection<String> listaAdmin = (Collection<String>) request.getAttribute("listaAdmin");
	        
	        @SuppressWarnings("unchecked")
	        Collection<Product> prodotti = (Collection<Product>) request.getAttribute("prodotti");
	        
	        @SuppressWarnings("unchecked")
	        Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
	        
	        if(clienti == null || listaAdmin == null || prodotti == null || ordini == null){
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
	        
	        String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 		
	 		session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
	    %>
	    
	    <%@ include file="/template/feedbackSection.jsp" %>
	
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
	            <hr>
	            <br>
	            
	            <input type="text" id="searchBar" placeholder="Search for products...">
	
	            <div class="table-container">
	                <table id="productTable">
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
	                            <td><%= EscaperHTML.escapeHTML(p.getNome()) %></td>
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
	                            <td><%= EscaperHTML.escapeHTML(cliente.getUsername()) %></td>
	                            <td><%= EscaperHTML.escapeHTML(cliente.getEmail()) %></td>
	                            <td><%= EscaperHTML.escapeHTML(cliente.getNome()) %></td>
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
	                                    <form id="formDelete" action="UserManagement" method="post">
	                               			<input type="hidden" name="id" value="<%=cliente.getEmail()%>">
	                               			<input type="hidden" name="action" value="rimuovi">
								    		<button type="button" id="deleteButton" onclick="openModal()">Elimina</button>
								     	</form>
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
	        
	        <div class="sezione">
	            <h2>Manage Orders</h2>
	            <div class="table-container">
	                <table>
	                    <thead>
	                        <tr>
	                 	       	<th>ID</th>
	                 	       	<th>Cliente</th>
	                 	       	<th>Nome</th>
	                 	       	<th>Cognome</th>
					            <th>Data Ordine</th>
					            <th>Data Consegna</th>
					            <th>Città</th>
					            <th>Via</th>
					            <th>CAP</th>
					            <th>Prezzo Totale</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <%
	                            if (ordini != null) {
	                            	SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy/MM/dd");
	                                for (Ordine ordine : ordini) {
	                        %>
	    					<tr>
	                            <td><%= ordine.getId() %></td>
	                            <td><%= EscaperHTML.escapeHTML(ordine.getCliente()) %></td>
	                            <td><%= EscaperHTML.escapeHTML(ordine.getNomeConsegna()) %></td>
	                            <td><%= EscaperHTML.escapeHTML(ordine.getCognomeConsegna()) %></td>
	                            <td><%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataOrdine().getTime())) %></td>
		            			<td><%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataConsegna().getTime())) %></td>
	                            <td><%= EscaperHTML.escapeHTML(ordine.getCitta())%></td>
	                            <td><%= EscaperHTML.escapeHTML(ordine.getVia())%></td>
	                            <td><%= EscaperHTML.escapeHTML(ordine.getCAP())%></td>
	                            <td><%= ordine.getPrezzoTotale()%></td>
	                        </tr>
	         
	                        <%
	                                }
	                            }
	                        %>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	        
	        <!-- Modal -->
			<div id="deleteModal" class="deleteModal">
			    <div class="modal-content-delete">
			        <span class="close" onclick="closeModal()">&times;</span>
			        <p>Per favore, inserisci "ELIMINA" nel campo di testo per confermare l'eliminazione dell'account:</p>
			        <input type="text" id="deleteConfirmationInput" autocomplete="off">
			        <button onclick="deleteAccount()">Conferma</button>
			    </div>
			</div>
	    </div>
	
	    <%@ include file="/template/footer.html" %>
	    
	    <script>
		    // Funzione per aprire il modal di eliminazione account
		    function openModal() {
		    	document.getElementById("zona_utente").style.zIndex = "998";
		        var modal = document.getElementById('deleteModal');
		        modal.style.display = 'block';
		    }
	
		    // Funzione per chiudere il modal di eliminazione account
		    function closeModal() {
		        var modal = document.getElementById('deleteModal');
		        modal.style.display = 'none';
		        document.getElementById("zona_utente").style.zIndex = "1000";
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
	    
	    <script src="js/scriptFeedback.js"></script>
	</body>
</html>