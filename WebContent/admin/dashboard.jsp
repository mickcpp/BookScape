<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Collection, net.bookscape.model.Cliente, net.bookscape.model.Product" %>
<%@ page import="net.bookscape.model.Libro, net.bookscape.model.Ordine" %>
<%@ page import="net.bookscape.model.Musica, java.text.SimpleDateFormat" %>
<%@ page import="net.bookscape.model.Gadget, java.util.Date" %>
<%@ page import="utility.EscaperHTML"%>

<!DOCTYPE html>
<html>
	<head>
	    <meta charset="utf-8">
	   	<meta name="viewport" content="width=device-width, initial-scale=1">
	   	<title>Admin Dashboard</title>
	   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link rel="stylesheet" href="css/dashboard.css">
	    <link rel="stylesheet" href="css/feedback.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    <link rel="icon" href="img/logo.png" type="image/x-icon">
	    
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
	    
	        String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 		
	 		session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
	    %>
	    
	    <%@ include file="/template/feedbackSection.jsp" %>
	
	    <div class="container mt-4">
    		<h1 class="text-center mb-3 mb-lg-0">Admin Dashboard</h1>

		    <div class="sezione mb-4">
		        <h2>Manage Products</h2>
		        <form action="ProductControl" method="post">
		            <input type="hidden" name="action" value="viewInsert">
		            <input type="radio" name="type" value="libro" id="libro" checked>
		            <label for="libro">Libro</label>
		            <input type="radio" name="type" value="musica" id="musica">
		            <label for="musica">Musica</label>
		            <input type="radio" name="type" value="gadget" id="gadget">
		            <label for="gadget">Gadget</label>
		            <button type="submit" class="btn btn-success d-none d-lg-inline-block mx-2">Aggiungi nuovo prodotto</button>
					<button type="submit" class="btn btn-success btn-sm d-lg-none mt-1">Aggiungi nuovo prodotto</button>

		        </form>
		        <hr>
		
		        <input type="text" id="searchBar" class="form-control" placeholder="Search for products..." autocomplete="off">
		
		        <div class="table-container mt-3">
		            <table id="productTable" class="table table-striped">
		                <thead class="thead-dark">
		                <tr>
		                    <th>ID</th>
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
		                    <td class="row">
								<button class="btn btn-primary d-none d-lg-inline-block col-auto my-1 my-lg-0 mx-md-1" onclick="location.href='ProductControl?productId=<%= p.getId() %>&action=viewEdit'">Modifica</button>
								<button class="btn btn-primary btn-sm d-lg-none col-auto my-1 my-lg-0 mx-md-1" onclick="location.href='ProductControl?productId=<%= p.getId() %>&action=viewEdit'">Modifica</button>
								<button class="btn btn-danger d-none d-lg-inline-block col-auto my-1 my-lg-0 mx-md-1" onclick="location.href='ProductControl?productId=<%= p.getId() %>&action=rimuovi'">Elimina</button>
								<button class="btn btn-danger btn-sm d-lg-none col-auto my-1 my-lg-0 mx-md-1" onclick="location.href='ProductControl?productId=<%= p.getId() %>&action=rimuovi'">Elimina</button>
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

		    <div class="sezione mb-4">
		        <h2 class="mb-3">Manage Users</h2>
		        <div class="table-container">
		            <table class="table table-striped">
		                <thead class="thead-dark">
		                <tr>
		                    <th>ID</th>
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
		                    <td class="pe-4">
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
		                    <td class="row unpadding">
		                        <%
		                            if(admin){
		                        %>
		                          <button class="btn btn-warning d-none d-lg-inline-block col-auto" onclick="location.href='UserManagement?id=<%=cliente.getEmail()%>&action=changeRole&role=cliente'">Riporta a utente</button>
								  <button class="btn btn-warning btn-sm d-lg-none col-auto" onclick="location.href='UserManagement?id=<%=cliente.getEmail()%>&action=changeRole&role=cliente'">Riporta a utente</button>
		                        <%
		                            } else {
		                        %>
								<button class="btn btn-success d-none d-lg-inline-block col-auto my-1" onclick="location.href='UserManagement?id=<%=cliente.getEmail()%>&action=changeRole&role=admin'">Promuovi ad admin</button>
								<button class="btn btn-success btn-sm d-lg-none col-auto my-1" onclick="location.href='UserManagement?id=<%=cliente.getEmail()%>&action=changeRole&role=admin'">Promuovi ad admin</button>
		                        <form id="formDelete" action="UserManagement" method="post">
		                            <input type="hidden" name="id" value="<%=cliente.getEmail()%>">
		                            <input type="hidden" name="action" value="rimuovi">
									<button type="button" class="btn btn-danger d-none d-lg-inline-block col-auto my-1" id="deleteButton" onclick="openModal()">Elimina</button>
									<button type="button" class="btn btn-danger btn-sm d-lg-none col-auto my-1" id="deleteButton" onclick="openModal()">Elimina</button>
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

		    <div class="sezione mb-4">
		        <h2 class="mb-3">Manage Orders</h2>
		        <div class="table-container">
		            <table class="table table-striped">
		                <thead class="thead-dark">
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
	
	    <%@ include file="/template/footer.jsp"%>
	    
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
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>