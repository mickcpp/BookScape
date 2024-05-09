<%@ page import="java.util.*, net.bookscape.model.Product, net.bookscape.model.Musica" language="java" contentType="text/html; charset=UTF-8"
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
			Collection<Musica> musics = (Collection<Musica>)request.getAttribute("musics");
			if(musics == null || musics.isEmpty()) {
				response.sendRedirect("MusicCatalog");
				return;
			} else {
				for(Musica m: musics) {
		%>
		<div class="product">
			<h2><%= m.getNome() %></h2>
			<p><%= m.getDescrizione() %></p>
			<p>Prezzo: <%= m.getPrezzo() %> EUR</p>
			<p>Quantità disponibile: <%= m.getQuantita() %></p>
			<img src="<%=m.getImgURL()%>">
			<form action="CartControl" method="post">
				<input type="hidden" name="productId" value="<%=m.getId() %>">
				<input type="hidden" name="type" value="<%=m.getClass().getSimpleName().toLowerCase()%>">
				<input type="hidden" name="action" value="aggiungi">
				<input type="hidden" name="redirect" value="musicCatalog.jsp">
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
