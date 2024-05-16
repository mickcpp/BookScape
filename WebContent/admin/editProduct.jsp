<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"%>
<%@ page import="net.bookscape.model.FormatoLibro, net.bookscape.model.FormatoMusica" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifica prodotto</title>
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="../css/navStyle.css">
    <link rel="stylesheet" href="../css/footerStyle.css">
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
        
         #logout{
            margin-left: 5%;
            padding-bottom: 10px;
            font-size: 18px;
        }
    </style>
</head>
<body>
	<%@ include file="/template/navbar.html" %>

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
        response.sendRedirect("../");
        return;
    }
    
  	String action = (String) request.getAttribute("action");
  	if(action != null){
  		if(action.equalsIgnoreCase("insert")) action = "inserisci";
  		else action = "modifica";
  	}
%>
<!-- Form to edit product -->
<div class="container">
    <div class="form-container">
        <h2><%=action.equals("modifica") ? "Modifica" : "Inserisci"%> prodotto</h2>
        <form action="ProductControl" method="post">
            <input type="hidden" name="action" value="<%=action%>">
            <input type="hidden" name="productId" id="productId" value="<%= prodotto.getId() %>">

            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" value="${prodotto.getNome()}">
            </div>
            <div class="form-group">
                <label for="descrizione">Descrizione:</label>
                <textarea id="descrizione" rows="5" cols="25" name="descrizione">${prodotto.getDescrizione()}</textarea>
            </div>
            <div class="form-group">
                <label for="prezzo">Prezzo:</label>
                <input type="number" id="prezzo" name="prezzo" value="${prodotto.getPrezzo()}" step="any">
            </div>

            <div class="form-group">
                <label for="quantity">Quantità:</label>
                <input type="number" id="quantity" name="quantity" value="${prodotto.getQuantita()}">
            </div>

            <div class="form-group">
                <label for="immagine">Immagine:</label>
                <input type="text" id="immagine" name="immagine" value="${prodotto.getImgURL()}">
            </div>

            <!-- Specific fields for different product types -->
            <% 
                if (prodotto instanceof Libro) { 
               		Libro l = (Libro) prodotto;
                %>
                	<input type="hidden" name="type" id="libro" value="libro">
                	
                    <div class="form-group">
                        <label for="genere">Genere:</label>
                        <input type="text" id="genere" name="genere" value="<%= l.getGenere()%>">
                    </div>
              		<%
					    FormatoLibro formato = l.getFormato();
					    String formatoName = (formato != null) ? formato.name() : ""; // Gestione del caso in cui il formato è null
					%>
                    <div class="form-group">
					    <label for="formato">Formato:</label>
					    <select id="formato" name="formato">
					        <option value="Cartaceo" <% if (formatoName.equals("Cartaceo")) { %>selected<% } %>>Cartaceo</option>
					        <option value="Digitale" <% if (formatoName.equals("Digitale")) { %>selected<% } %>>Digitale</option>
					    </select>
					</div>
                    <div class="form-group">
                        <label for="anno">Anno:</label>
                        <input type="number" id="anno" name="anno" value="<%=l.getAnno() %>">
                    </div>
                    <div class="form-group">
                        <label for="ISBN">ISBN:</label>
                        <input type="text" id="ISBN" name="ISBN" value="<%=l.getISBN()%>">
                    </div>
                    <div class="form-group">
                        <label for="autore">Autore:</label>
                        <input type="text" id="autore" name="autore" value="<%=l.getAutore()%>">
                    </div>
                    <div class="form-group">
                        <label for="numeroPagine">Numero pagine:</label>
                        <input type="number" id="numeroPagine" name="numeroPagine" value="<%=l.getNumeroPagine()%>">
                    </div>
            <%  } else if (prodotto instanceof Musica) {
            			Musica m = (Musica) prodotto;
            %>
            		<input type="hidden" name="type" id="musica" value="musica">
            		
                    <div class="form-group">
                        <label for="genere">Genere:</label>
                        <input type="text" id="genere" name="genere" value="<%=m.getGenere()%>">
                    </div>
                  	
                  	<%
					    FormatoMusica formato = m.getFormato();
					    String formatoName = (formato != null) ? formato.name() : ""; // Gestione del caso in cui il formato è null
					%>
					
                    <div class="form-group">
					    <label for="formato">Formato:</label>
					    <select id="formato" name="formato">
					        <option value="Vinile" <% if (formatoName.equals("Vinile")) { %>selected<% } %>>Vinile</option>
					        <option value="CD" <% if (formatoName.equals("CD")) { %>selected<% } %>>CD</option>
					    </select>
					</div>
                    <div class="form-group">
                        <label for="artista">Artista:</label>
                        <input type="text" id="artista" name="artista" value="<%=m.getArtista() %>">
                    </div>
                    <div class="form-group">
                        <label for="anno">Anno:</label>
                        <input type="number" id="anno" name="anno" value="<%=m.getAnno()%>">
                    </div>
                    <div class="form-group">
                        <label for="numeroTracce">Numero tracce:</label>
                        <input type="number" id="numeroTracce" name="numeroTracce" value="<%=m.getNumeroTracce()%>">
                    </div>
            <%  } else if (prodotto instanceof Gadget) {
						Gadget g = (Gadget) prodotto;
			%>
					<input type="hidden" name="type" id="gadget" value="gadget">
					
                    <div class="form-group">
                        <label for="materiale">Materiale:</label>
                        <input type="text" id="materiale" name="materiale" value="<%=g.getMateriale()%>">
                    </div>
                    <div class="form-group">
                        <label for="altezza">Altezza:</label>
                        <input type="number" id="altezza" name="altezza" value="<%=g.getAltezza()%>" step="any">
                    </div>
                    <div class="form-group">
                        <label for="lunghezza">Lunghezza:</label>
                        <input type="number" id="lunghezza" name="lunghezza" value="<%=g.getLunghezza()%>" step="any">
                    </div>
                    <div class="form-group">
                        <label for="larghezza">Larghezza:</label>
                        <input type="number" id="larghezza" name="larghezza" value="<%=g.getLarghezza()%>" step="any">
                    </div>
            <%  } %>
            
            <button type="submit"><%=request.getAttribute("action") != null && request.getAttribute("action").equals("insert") ? "Inserisci" : "Modifica" %></button>
        </form>
    </div>
</div>
<%@ include file="/template/footer.html" %>
</body>
</html>
					        
