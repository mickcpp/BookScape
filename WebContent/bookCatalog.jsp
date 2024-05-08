<%@ page import="java.util.*, net.bookscape.model.Product, net.bookscape.model.Libro" language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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
		</style>
	</head>
	<body>
		<%@ include file="template/navbar.html" %>
		
		<%!String nomeTabella = "";%>
		
		<div id="contenuto">
		<%
			Collection<Libro> libri = (Collection<Libro>)request.getAttribute("libri");
			if(libri == null || libri.isEmpty()) {
				response.sendRedirect("BookCatalog");
				return;
			} else {
				for(Libro l: libri) {
		%>
		<div class="product">
			<h2><%= l.getNome() %></h2>
			<p><%= l.getDescrizione() %></p>
			<p>Prezzo: <%= l.getPrezzo() %> EUR</p>
			<p>Quantità disponibile: <%= l.getQuantita() %></p>
			<form action="CartControl" method="post">
				<input type="hidden" name="productId" value="<%= l.getId() %>">
				<input type="hidden" name="type" value="<%=l.getClass().getSimpleName().toLowerCase()%>">
				<input type="hidden" name="action" value="aggiungi">
				<input type="hidden" name="redirect" value="bookCatalog.jsp">
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
