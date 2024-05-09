<%@ page import="java.util.*, net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget" %>
<%@ page import="java.util.Collection" %>
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
	</style>
</head>
<body>
	<%@ include file="template/navbar.html" %>
	
	<h1>Prodotti nel Carrello</h1>
	<div id="contenuto">

<%
    // Ottieni l'oggetto "cart" dalla richiesta
 	Cart carrello = (Cart)request.getSession().getAttribute("cart");
	if(carrello != null){
		
		Collection<Product> prodotti = carrello.getProducts();
		
	    if (prodotti != null && !prodotti.isEmpty()) {
	        // Mostra i prodotti presenti nel carrello
	        Iterator<Product> iterator = prodotti.iterator();
	        while (iterator.hasNext()) {
	        	Product prodotto = iterator.next();
	%>
	            <div class="product">
	                <p>Nome Prodotto: <%= prodotto.getNome() %></p>
	                <p>Prezzo: <%= prodotto.getPrezzo() %></p>
	                <a href="ProductDetails?productId=<%=prodotto.getId()%>&type=<%=prodotto.getClass().getSimpleName().toLowerCase()%>"><img src="<%=prodotto.getImgURL()%>"></a>
	                
	                <form action="CartControl" method="post">
	                    <input type="hidden" name="productId" value="<%= prodotto.getId() %>">
	                    <input type="hidden" name="type" value="<%=prodotto.getClass().getSimpleName().toLowerCase()%>">
	                    <input type="hidden" name="action" value="rimuovi"> 
	                    <input type="hidden" name="redirect" value="Cart.jsp">
	                    <input type="submit" value="Rimuovi">
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
