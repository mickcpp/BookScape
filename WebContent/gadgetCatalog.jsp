<%@ page import="java.util.*, net.bookscape.model.Product, net.bookscape.model.Gadget" language="java" contentType="text/html; charset=UTF-8"
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
			Collection<Gadget> gadgets = (Collection<Gadget>)request.getAttribute("gadgets");
			if(gadgets == null || gadgets.isEmpty()) {
				response.sendRedirect("GadgetCatalog");
				return;
			} else {
				for(Gadget g: gadgets) {
		%>
		<div class="product">
			<h2><%= g.getNome() %></h2>
			<p><%= g.getDescrizione() %></p>
			<p>Prezzo: <%= g.getPrezzo() %> EUR</p>
			<p>Quantità disponibile: <%= g.getQuantita() %></p>
			<a href="ProductDetails?productId=<%=g.getId()%>&type=<%=g.getClass().getSimpleName().toLowerCase()%>"><img src="<%=g.getImgURL()%>"></a>
			<form action="CartControl" method="post">
				<input type="hidden" name="productId" value="<%=g.getId() %>">
				<input type="hidden" name="type" value="<%=g.getClass().getSimpleName().toLowerCase()%>">
				<input type="hidden" name="action" value="aggiungi">
				<input type="hidden" name="redirect" value="gadgetCatalog.jsp">
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
