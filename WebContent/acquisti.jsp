<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.CartItem, java.util.Collection, java.text.SimpleDateFormat" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.util.ListIterator, java.util.UUID"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>I Miei Acquisti</title>
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
            margin: 27px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 7px;
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
    %>
    <div class="container">
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
                <h2 style="margin-bottom: 0.5%">Ordine ID: <%= index-- %></h2>
           		<form id="scaricaFattura" method="post" action="FatturaDownload">
           			<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
        			<input type="hidden" name="orderId" value="<%= ordine.getId() %>">
           			<input type="hidden" name="dataAcquisto" value="<%= dateFormatter.format(ordine.getDataOrdine().getTime())%>">
           			<input type="hidden" value="">
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
           			<input type="submit" value="Scarica fattura">
           		</form>
                <p>Data Ordine: <%= dateFormatter.format(ordine.getDataOrdine().getTime()) %></p>
                <p>Prezzo Totale: € <%= ordine.getPrezzoTotale() %></p>
                <h3>Prodotti:</h3>
                <ul>
                    <%
                        Collection<CartItem> prodotti = ordine.getProdotti();
                        if (prodotti != null) {
                            for (CartItem item : prodotti) {
                    %>
                        <li>
                            <img src="<%= item.getProduct().getImgURL() %>" alt="<%= item.getProduct().getNome() %>" class="product-img">
                            <p><%= item.getProduct().getNome() %> - Quantità: <%= item.getNumElementi() %> - Prezzo: € <%= item.getProduct().getPrezzo() %></p>
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
    
    <%@ include file="template/footer.html" %>
</body>
</html>
