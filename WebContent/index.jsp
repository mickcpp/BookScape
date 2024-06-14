<%@ page import="java.util.*, net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>BookScape</title>
		<link rel="stylesheet" href="css/style.css">
		
		<style>
			div#contenuto{
				display: flex;
				flex-direction: row;
				flex-wrap: wrap;
				justify-content: center;
			}
			
			div.product{
				padding: 20px;
				width: 20%;
				border: 2px solid black;
				border-collapse: separate;
			}
			
			#logout{
				margin-left: 5%;
				padding-bottom: 10px;
				font-size: 18px;
			}
			.product img#productImage{
	            width: 50%;
	            border-radius: 8px;
	        }
		     .product {
	            margin: 20px;
	            padding: 20px;
	            background-color: #fff;
	            border-radius: 8px;
	            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	            width: 200px;
	        }
		</style>
	</head>
	<body>
		<%@ include file="template/navbar.html" %>
		
		<%
			String id = (String) session.getAttribute("cliente");
			if(id != null && !id.equals("")){
				%>
				<a id="logout" href="Logout">Logout</a>
				<%
			}
		%>
		
		<%!String nomeTabella = "";%>
		
		<div id="contenuto">
		<%
			@SuppressWarnings("unchecked")
			Collection<Product> prodotti = (Collection<Product>) request.getAttribute("prodotti");
		
			if(prodotti == null || prodotti.isEmpty()) {
				response.sendRedirect("HomePage");
				return;
			} else {
				for(Product p: prodotti) {
		%>
					<div class="product">
						<h2><%= p.getNome() %></h2>
						<p><%= p.getDescrizione() %></p>
						<p>Prezzo: <%= p.getPrezzo() %> EUR</p>
						<p>Quantità disponibile: <%= p.getQuantita() %></p>
						<a href="ProductDetails?productId=<%=p.getId()%>&type=<%=p.getClass().getSimpleName().toLowerCase()%>"><img id="productImage" src="<%=p.getImgURL()%>"></a>
						<form action="CartControl" method="post">
							<input type="hidden" name="productId" value="<%= p.getId() %>">
							<input type="hidden" name="type" value="<%=p.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="index.jsp">
							<input type="submit" value="Aggiungi al carrello">
						</form>
						<hr>
						<form action="WishlistControl" method="post">
							<input type="hidden" name="productId" value="<%= p.getId() %>">
							<input type="hidden" name="type" value="<%=p.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="index.jsp">
							<button class="bookmark" type=submit><img src="img/bookmark.png"></button>
						</form>
					</div>
		<%
				}
			}
		%>
		</div>
		
		<%@ include file="template/footer.html" %>
	</body>
</html>
