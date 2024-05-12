<%@ page import="java.util.*, net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget" %>
<%@ page import="java.util.Collection, net.bookscape.model.CartItem" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="net.bookscape.model.Cart" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Carrello</title>
    <link rel="stylesheet" href="css/style.css">
    
    <style>
		div#contenuto{
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			justify-content: center;
		}
		div.product{
			padding: 50px;
			width: 20%;
			border: 2px solid black;
			border-collapse: separate;
			}
		h1{
			text-align: center;
		}
		#logout{
				margin-left: 5%;
				padding-bottom: 10px;
				font-size: 18px;
		}
	</style>
</head>
<body>
	<%@ include file="template/navbar.html" %>
	<%
		String id = (String) session.getAttribute("cliente");
		if(id != null && !id.equals("")){
			Cart cart = (Cart)request.getSession().getAttribute("cart");
			if(cart == null){
				response.sendRedirect("CartControl?redirect=Cart.jsp");
				return;
			}
			%>
			<a id="logout" href="Logout">Logout</a>
			<%
		}
	%>
	
	<h1>Prodotti nel Carrello</h1>
	<div id="contenuto">

<%
    // Ottieni l'oggetto "cart" dalla richiesta
 	Cart carrello = (Cart)request.getSession().getAttribute("cart");
	if(carrello != null){
		
		Collection<CartItem> items = carrello.getItems();
		
	    if (items != null && !items.isEmpty()) {
	        // Mostra i prodotti presenti nel carrello
	        Iterator<CartItem> iterator = items.iterator();
	        while (iterator.hasNext()) {
	        	CartItem item = iterator.next();
	%>
	            <div class="product">
	                <p>Nome Prodotto: <%= item.getProduct().getNome() %></p>
	                <p>Prezzo: <%= item.getProduct().getPrezzo() %></p>
	                <p>Quantità: <%= item.getNumElementi()%></p>
	                <hr>
	                <p>Prezzo totale: <%=item.getTotalCost()%></p>
	                <hr>
	                <a href="ProductDetails?productId=<%=item.getProduct().getId()%>&type=<%=item.getProduct().getClass().getSimpleName().toLowerCase()%>"><img src="<%=item.getProduct().getImgURL()%>"></a>
	                
	                <form action="CartControl" method="post">
	                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
	                    <input type="hidden" name="type" value="<%=item.getProduct().getClass().getSimpleName().toLowerCase()%>">
	                    <br>
	                    <input type="hidden" name="redirect" value="Cart.jsp">
	                    <input type="number" name="quantity" value="<%=item.getNumElementi()%>" min="1" max="10">
   						<input type="submit" name="action" value="Aggiorna">
   						<hr>
   						<input type="submit" name="action" value="Rimuovi">
	                </form>
	            </div>
	<%	
	        }
 
	    } else {
%>
	        <p>Il carrello è vuoto.</p>
<%
	    }
	}else{ 
%>
   	 	<p>Il carrello è vuoto.</p>
<%
	}
%>
	</div>
	<%@ include file="template/footer.html" %>
</body>
</html>
