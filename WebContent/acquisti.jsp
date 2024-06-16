<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.CartItem, java.util.Collection, java.text.SimpleDateFormat" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>I Miei Acquisti</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #333;
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
    </style>
</head>
<body>
	
	<%@ include file="template/navbar.jsp" %>
	
    <div class="container">
        <h1>I Miei Acquisti</h1>
        <%
        	@SuppressWarnings("unchecked")
            Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
        
 			if(ordini == null){
 				response.sendRedirect("OrderControl?action=visualizza");
 				return;
 			}
 			
            if (ordini != null) {
                SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy/MM/dd");
                for (Ordine ordine : ordini) {
        %>
            <div class="ordine">
                <h2>Ordine ID: <%= ordine.getId() %></h2>
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
            }
        %>
    </div>
    
    <%@ include file="template/footer.html" %>
</body>
</html>