<%@ page import="java.util.Collection, net.bookscape.model.Gadget" language="java" contentType="text/html; charset=UTF-8"
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
				border: 1px solid black;
				border-collapse: separate;
				box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
				margin: 15px;
				border-radius: 8px;
				box-sizing: border-box;
			}
			
			#logout {
	            position: absolute;
	            margin-left: 3%;
	            top: 130px;
	            margin-bottom: 20px;
	            font-size: 18px;
	        }
			
			.product img#productImage{
	            width: 180px;
	            height: 180px;
	            border-radius: 8px;
	        }
	       
		</style>
	</head>
	<body>
		<%@ include file="template/navbar.jsp" %>
		
		<%!String nomeTabella = "";%>
		
		<%
			String id = (String) session.getAttribute("cliente");
			if(id != null && !id.equals("")){
				%>
				<a id="logout" href="Logout">Logout</a>
				<%
			}
		%>
		
		<div id="contenuto">
		<%
			@SuppressWarnings("unchecked")
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
						<a href="ProductDetails?productId=<%=g.getId()%>&type=<%=g.getClass().getSimpleName().toLowerCase()%>"><img id="productImage" src="<%=g.getImgURL()%>"></a>
						<form action="CartControl" method="post">
							<input type="hidden" name="productId" value="<%=g.getId() %>">
							<input type="hidden" name="type" value="<%=g.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="gadgetCatalog.jsp">
							<input type="submit" value="Aggiungi al carrello">
						</form>
						<hr>
						<form action="WishlistControl" method="post">
							<input type="hidden" name="productId" value="<%= g.getId() %>">
							<input type="hidden" name="type" value="<%=g.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="gadgetCatalog.jsp">
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
