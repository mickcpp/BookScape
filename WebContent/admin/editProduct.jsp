<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"%>
<%@ page import="net.bookscape.model.FormatoLibro, net.bookscape.model.FormatoMusica" %>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <title>Modifica prodotto</title>
	    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
	    <link rel="stylesheet" href="css/feedback.css">

	    <style>
	        html, body {
	            margin: 0;
	            padding: 0;
	            height: 100%;
	        }
	
	        body {
	            display: flex;
	            flex-direction: column;
	        }
	
	        .container {
	            flex: 1;
	            display: flex;
	            align-items: center;
	            justify-content: center;
	        }
	
	        .form-container {
	            width: 50%;
	            padding: 20px;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	         	margin: 1% 0;
	        }
	
	        .form-group {
	            margin-bottom: 15px;
	        }
	
	        .form-group label {
	            display: block;
	            margin-bottom: 5px;
	        }
	
	        .form-group input[type="text"],
	        .form-group input[type="number"],
	        .form-group select {
	            width: calc(100% - 10px);
	            padding: 5px;
	            border: 1px solid #ccc;
	            border-radius: 3px;
	        }
	
	        .form-group textarea {
	            width: calc(100% - 10px);
	            padding: 5px;
	            border: 1px solid #ccc;
	            border-radius: 3px;
	            resize: vertical;
	        }
	
	        .form-group button {
	            padding: 8px 15px;
	            background-color: #007bff;
	            color: #fff;
	            border: none;
	            border-radius: 3px;
	            cursor: pointer;
	        }
	        
       		#logout {
	            position: absolute;
	            margin-left: 3%;
	            top: 130px;
	            margin-bottom: 20px;
	            font-size: 18px;
	        }
	        
	   		.error-message {
	            color: #e74c3c;
	            font-size: 0.9em;
	            margin-top: 0.4%;
	            margin-bottom: 1.55%;
	            text-align: left;
	            display: none;
	        }
	    </style>
	</head>
	<body>

		<%@ include file="/template/navbar.jsp" %>
	
<%
		String id = (String) session.getAttribute("cliente");
		    if(id != null && !id.equals("")){
%>
				<a id="logout" href="Logout">Logout</a>
<%
		    }
%>
	
	<%
	    Product prodotto = (Product) request.getAttribute("prodotto");
	    if(prodotto == null){
	    	System.out.println("prodotto nullo");
	        response.sendRedirect("./");
	        return;
	    }
	    
	  	String action = (String) request.getAttribute("action");
	  	if(action != null){
	  		if(action.equalsIgnoreCase("insert")) action = "inserisci";
	  		else if(action.equalsIgnoreCase("edit")) action = "modifica";
	  	} else{
	  		response.sendRedirect("admin/dashboard.jsp");
	  		return;
	  	}
	  	
	  	String feedback = (String) request.getAttribute("feedback");
 		String feedbackNegativo = (String) request.getAttribute("feedback-negative");
	%>
	
		<%@ include file="/template/feedbackSection.jsp" %>
		
		<div class="container">
		
			<div class="form-container">
			
		        <h2><%=action.equals("modifica") ? "Modifica" : "Inserisci"%> prodotto</h2>
		        
	<% 			String serverError = (String) request.getAttribute("errorMessage");
	     		if(serverError != null){
	     			%>
	     				<div class="error-message" style="display: block; margin: 4% auto; margin: -1% auto 2% auto"><%= serverError %></div>
	     			<%
	     		}
	%>
		        <form action="FileUpload" method="post" enctype="multipart/form-data" onsubmit="<%= (prodotto instanceof Libro) ? "return validateLibro()" : (prodotto instanceof Musica) ? "return validateMusica()" : "return validateGadget()" %>">
		            <input type="hidden" name="action" value="<%=action%>">
		            <input type="hidden" name="productId" id="productId" value="<%= prodotto.getId() %>">
		            <input type="hidden" name="productImageURL" id="productImageURL" value="<%= prodotto.getImgURL() %>">
		
		            <div class="form-group">
		                <label for="nome">Nome:</label>
		                <input type="text" id="nome" name="nome" value="${prodotto.getNome()}" required>
		                <div class="error-message"></div>
		            </div>
		            
		            <div class="form-group">
		                <label for="descrizione">Descrizione:</label>
		                <textarea id="descrizione" rows="5" cols="25" name="descrizione" required>${prodotto.getDescrizione()}</textarea>
		                <div class="error-message"></div>
		            </div>
		            
		            <div class="form-group">
		                <label for="prezzo">Prezzo:</label>
		                <input type="number" id="prezzo" name="prezzo" value="${prodotto.getPrezzo()}" step="any" required>
		                <div class="error-message"></div>
		            </div>
		
		            <div class="form-group">
		                <label for="quantity">Quantità:</label>
		                <input type="number" id="quantity" name="quantity" value="${prodotto.getQuantita()}" required>
		                <div class="error-message"></div>
		            </div>
		
		            <div class="form-group">
		                <label for="immagine">Immagine:</label>
		                <input type="file" id="immagine" name="immagine" accept=".jpg, .jpeg, .png">
		            </div>
			
				<%	if (prodotto instanceof Libro) {
							
						Libro l = (Libro) prodotto;
		        %>
	                	<input type="hidden" name="type" id="libro" value="libro">
	                	
	                    <div class="form-group">
	                        <label for="genere">Genere:</label>
	                        <input type="text" id="genere" name="genere" value="<%= l.getGenere()%>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	              		<%
						    FormatoLibro formato = l.getFormato();
						    String formatoName = (formato != null) ? formato.name() : ""; // Gestione del caso in cui il formato è null
						%>
						
	                    <div class="form-group">
						    <label for="formato">Formato:</label>
						    <select id="formato" name="formato" required>
						        <option value="Cartaceo" <% if (formatoName.equals("Cartaceo")) { %>selected<% } %>>Cartaceo</option>
						        <option value="Digitale" <% if (formatoName.equals("Digitale")) { %>selected<% } %>>Digitale</option>
						    </select>
						    <div class="error-message"></div>
						</div>
						
	                    <div class="form-group">
	                        <label for="anno">Anno:</label>
	                        <input type="number" id="anno" name="anno" value="<%=l.getAnno() %>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="ISBN">ISBN:</label>
	                        <input type="text" id="ISBN" name="ISBN" value="<%=l.getISBN()%>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="autore">Autore:</label>
	                        <input type="text" id="autore" name="autore" value="<%=l.getAutore()%>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="numeroPagine">Numero pagine:</label>
	                        <input type="number" id="numeroPagine" name="numeroPagine" value="<%=l.getNumeroPagine()%>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
				<%  } else if (prodotto instanceof Musica) {
						Musica m = (Musica) prodotto;
		     	%>
	            		<input type="hidden" name="type" id="musica" value="musica">
	            		
	                    <div class="form-group">
	                        <label for="genere">Genere:</label>
	                        <input type="text" id="genere" name="genere" value="<%=m.getGenere()%>" required>
	                        <div class="error-message"></div>
	                    </div>
		                  	
	                  	<%
						    FormatoMusica formato = m.getFormato();
						    String formatoName = (formato != null) ? formato.name() : ""; // Gestione del caso in cui il formato è null
						%>
						
	                    <div class="form-group">
						    <label for="formato">Formato:</label>
						    <select id="formato" name="formato" required>
						        <option value="Vinile" <% if (formatoName.equals("Vinile")) { %>selected<% } %>>Vinile</option>
						        <option value="CD" <% if (formatoName.equals("CD")) { %>selected<% } %>>CD</option>
						    </select>
						    <div class="error-message"></div>
						</div>
						
	                    <div class="form-group">
	                        <label for="artista">Artista:</label>
	                        <input type="text" id="artista" name="artista" value="<%=m.getArtista() %>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="anno">Anno:</label>
	                        <input type="number" id="anno" name="anno" value="<%=m.getAnno()%>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="numeroTracce">Numero tracce:</label>
	                        <input type="number" id="numeroTracce" name="numeroTracce" value="<%=m.getNumeroTracce()%>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
				<%  } else if (prodotto instanceof Gadget) { 
						Gadget g = (Gadget) prodotto;
				%>
						<input type="hidden" name="type" id="gadget" value="gadget">
						
	                    <div class="form-group">
	                        <label for="materiale">Materiale:</label>
	                        <input type="text" id="materiale" name="materiale" value="<%=g.getMateriale()%>" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="altezza">Altezza:</label>
	                        <input type="number" id="altezza" name="altezza" value="<%=g.getAltezza()%>" step="any" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="lunghezza">Lunghezza:</label>
	                        <input type="number" id="lunghezza" name="lunghezza" value="<%=g.getLunghezza()%>" step="any" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label for="larghezza">Larghezza:</label>
	                        <input type="number" id="larghezza" name="larghezza" value="<%=g.getLarghezza()%>" step="any" required>
	                        <div class="error-message"></div>
	                    </div>
	                    
		 		<% } %>
		            
		            <button type="submit"><%=action.equals("modifica") ? "Modifica" : "Inserisci"%></button>
		        </form>
		    </div>
		</div>
		
		<%@ include file="/template/footer.jsp" %>
		
		<script>
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
		</script>
		
		<script src="js/ValidationUtilsProduct.js"></script>
		<script src="js/ValidationLibraryProduct.js"></script>
		<script src="js/scriptFeedback.js"></script>
	</body>
</html>
					        
