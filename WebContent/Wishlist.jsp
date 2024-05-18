<%@ page import="net.bookscape.model.Product"%>
<%@ page import="java.util.Collection, java.util.Iterator"%>
<%@ page import="net.bookscape.model.Wishlist" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
	<head>
	    <title>Wishlist</title>
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
			Wishlist wishlist = null;
			
			if(id != null && !id.equals("")){
				wishlist = (Wishlist)request.getSession().getAttribute("wishlist");
				if(wishlist == null){
					response.sendRedirect("WishlistControl");
					return;
				}
				%>
				<a id="logout" href="Logout">Logout</a>
				<%
			} else {
				response.sendRedirect("Login?redirect=Wishlist.jsp");
			}
		%>
		
		<h1>Prodotti nella wishlist</h1>
		<div id="contenuto">
	
	<%
		if(wishlist != null){
			
			Collection<Product> products = wishlist.getItems();
			
		    if (products != null && !products.isEmpty()) {
		        Iterator<Product> iterator = products.iterator();
		        
		        while (iterator.hasNext()) {
		        	Product product = iterator.next();
		%>
		            <div class="product">
		                <p>Nome Prodotto: <%= product.getNome() %></p>
		                <p>Prezzo: <%= product.getPrezzo() %></p>
		                <hr>
		                <a href="ProductDetails?productId=<%=product.getId()%>&type=<%=product.getClass().getSimpleName().toLowerCase()%>"><img src="<%=product.getImgURL()%>"></a>
		                <form action="CartControl" method="post">
							<input type="hidden" name="productId" value="<%= product.getId() %>">
							<input type="hidden" name="type" value="<%=product.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="Wishlist.jsp">
							<input type="submit" value="Aggiungi al carrello">
						</form>
						<hr>
		                <form action="WishlistControl" method="post">
		                    <input type="hidden" name="productId" value="<%= product.getId() %>">
		                    <input type="hidden" name="type" value="<%=product.getClass().getSimpleName().toLowerCase()%>">
		                    <br>
		                    <input type="hidden" name="redirect" value="Wishlist.jsp">
							<hr>
	   						<input type="submit" name="action" value="Rimuovi">
		                </form>
		            </div>
		<%	
		        }
	 
		    } else {
	%>
		        <p>Nessun prodotto nella wishlist.</p>
	<%
		    }
		} else{ 
	%>
	   	 	<p>Nessun prodotto nella wishlist.</p>
	<%
		}
	%>
		</div>
		
		<%@ include file="template/footer.html" %>
	</body>
</html>
