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
			<a href="ProductDetails?productId=<%=p.getId()%>&type=<%=p.getClass().getSimpleName().toLowerCase()%>"><img src="<%=p.getImgURL()%>"></a>
			<form action="CartControl" method="post">
				<input type="hidden" name="productId" value="<%= p.getId() %>">
				<input type="hidden" name="type" value="<%=p.getClass().getSimpleName().toLowerCase()%>">
				<input type="hidden" name="action" value="aggiungi">
				<input type="hidden" name="redirect" value="index.jsp">
				<input type="submit" value="Aggiungi al carrello">
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
