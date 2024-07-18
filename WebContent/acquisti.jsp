<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.CartItem, java.util.Collection, java.text.SimpleDateFormat" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.util.ListIterator, java.util.UUID"%>
<%@ page import="utility.EscaperHTML" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="utf-8">
   	<meta name="viewport" content="width=device-width, initial-scale=1">
   	<title>I miei Acquisti</title>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  	<link rel="stylesheet" href="css/style.css">
  	<link rel="stylesheet" href="css/feedback.css">
  	
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .acquistiContainer {
            width: 80%;
            margin: 27px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 7px;
        }
        
        .section-menu{
        	display: none;
        }
        
        h1 {
            text-align: center;
            color: #333;
            margin: 0.8% 1% 0% 1%;
        }

        .ordine {
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
            margin-bottom: 10px;
        }

        .ordine h2 {
            color: #333;
        }

        .ordine p {
            color: #666;
        }

        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            margin-right: 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        li p {
            margin: 0;
            color: #333;
        }
        
        #logout {
            position: absolute;
            margin-left: 4%;
            top: 138px;
            padding-bottom: 10px;
            font-size: 18px;
        }
    </style>
</head>
<body>
	
	<%@ include file="template/navbar.jsp" %>
	<%
        String id = (String) session.getAttribute("cliente");
        if(id != null && !id.equals("")) {
    %>
    	<a id="logout" href="Logout">Logout</a>
    <%
        }
        
        String feedback = (String) session.getAttribute("feedback");
 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
 		
 		session.removeAttribute("feedback");
		session.removeAttribute("feedback-negative");
    %>
    
    <%@ include file="template/feedbackSection.jsp" %>
    
    <div class="container acquistiContainer">
        <h1>I Miei Acquisti</h1>
        <%
        	@SuppressWarnings("unchecked")
            Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
        
 			if(ordini == null){
 				response.sendRedirect("OrderControl?action=visualizza");
 				return;
 			}
 			
            if (ordini.size() != 0) {
                SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
                
                List<Ordine> ordiniList = new ArrayList<Ordine>(ordini);
				ListIterator<Ordine> listIterator = ordiniList.listIterator(ordini.size());
	
				int index = ordini.size();
				
				String csrfToken = UUID.randomUUID().toString();
				session.setAttribute("csrfToken", csrfToken);
				
                while (listIterator.hasPrevious()) {
                	Ordine ordine = listIterator.previous();
        %>
            <div class="ordine">
                <h2 style="margin-bottom: 0.5%">Ordine ID: <%= index %></h2>
           		<form id="scaricaFattura<%= index %>" method="post" action="FatturaDownload">
           			<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
        			<input type="hidden" name="orderId" value="<%= ordine.getId() %>">
        			<input type="hidden" name="fatturaId" value="<%= index %>">
           			<input type="hidden" name="dataAcquisto" value="<%= dateFormatter.format(ordine.getDataOrdine().getTime())%>">
           			<input type="hidden" name="nomeCompletoConsegna" value="<%= ordine.getNomeConsegna() + " " + ordine.getCognomeConsegna()%>">
           			<input type="hidden" name="viaConsegna" value="<%= ordine.getVia()%>">
					<input type="hidden" name="cittaConsegna" value="<%= ordine.getCitta()%>">
           			<input type="hidden" name="capConsegna" value="<%= ordine.getCAP()%>">
           			<input type="hidden" name="numeroProdotti" value="<%= ordine.getProdotti().size()%>">
           			<%
           			
           				int i = 1;
           				for(CartItem item : ordine.getProdotti()){
           					%>
           						<input type="hidden" name="tipo<%= i %>" value="<%= item.getProduct().getClass().getSimpleName()%>">
           						<input type="hidden" name="nome<%= i %>" value="<%= item.getProduct().getNome()%>">
           						<input type="hidden" name="quantita<%= i %>" value="<%= item.getNumElementi()%>">
           						<input type="hidden" name="prezzo<%= i %>" value="<%= item.getProduct().getPrezzo()%>">
           					<%
           					i++;
           				}
           			%>
           			<input type="hidden" name="prezzoTotale" value="<%= ordine.getPrezzoTotale()%>">
           			<input type="submit" value="Scarica fattura" onclick="submitFormAndRefresh('scaricaFattura<%= index%>'); return false;">
           		</form>
           		
        		<% index--; %>
        		
                <p>Data Ordine: <%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataOrdine().getTime())) %></p>
                <p>Prezzo Totale: € <%= ordine.getPrezzoTotale() %></p>
                <h3>Prodotti:</h3>
                <ul>
                    <%
                        Collection<CartItem> prodotti = ordine.getProdotti();
                        if (prodotti != null) {
                            for (CartItem item : prodotti) {
                    %>
                        <li>
                            <img src="<%= item.getProduct().getImgURL() %>" alt="<%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %>" class="product-img">
                            <p><%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %> - Quantità: <%= item.getNumElementi() %> - Prezzo: € <%= item.getProduct().getPrezzo() %></p>
                        </li>
                    <%
                            }
                        }
                    %>
                </ul>
            </div>
        <%
                }
            } else{
            	%>
            		<p style="text-align: center">Non hai effettuato nessun acquisto!</p>
            		<p style="text-align: center; padding-bottom: 21%"><a href="./">Torna al catalogo</a></p>
            	<%
            }
        %>
    </div>
    
    <%@ include file="template/footer.jsp"%>
    
    <script>
	    // Funzione per gestire il submit del form
	    function submitFormAndRefresh(formId) {
		    var form = document.getElementById(formId);
		    form.submit();
		    
		    setTimeout(function() {
		        location.reload();
		    }, 90); // 90 millisecondi di ritardo prima di aggiornare la pagina
		}
	</script>
    
    <script src="js/scriptFeedback.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
