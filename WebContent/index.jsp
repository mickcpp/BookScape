<%@ page import="java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"%>
<%@ page import="utility.EscaperHTML"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>BookScape</title>
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/feedback.css">
		
		<style>
			div#contenuto{
				display: flex;
				flex-direction: row;
				flex-wrap: wrap;
				justify-content: center;
			}
			
			#contenuto div.product{
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
	            width: 160px;
	            height: 225px;
	            border-radius: 8px;
	        }
		</style>
	</head>
	<body>
		<%@ include file="template/navbar.jsp" %>
		
		<%
			String id = (String) session.getAttribute("cliente");
			if(id != null && !id.equals("")){
				%>
				<a id="logout" href="Logout">Logout</a>
				<%
			}
			
			String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 	
			session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
		%>
		
		<%!String nomeTabella = "";%>
		
		<%@ include file="template/feedbackSection.jsp" %>
		
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
						<h2><%= EscaperHTML.escapeHTML(p.getNome()) %></h2>
						<p><%= EscaperHTML.escapeHTML(p.getDescrizione()) %></p>
						<p>Prezzo: <%= p.getPrezzo() %> EUR</p>
						<p>Quantità disponibile: <%= p.getQuantita() %></p>
						<a href="ProductDetails?productId=<%=p.getId()%>&type=<%=p.getClass().getSimpleName().toLowerCase()%>"><img id="productImage" src="<%=p.getImgURL()%>"></a>
						<form action="CartControl" method="post">
							<input type="hidden" name="productId" value="<%= p.getId() %>">
							<input type="hidden" name="type" value="<%=p.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="HomePage">
							<input type="submit" value="Aggiungi al carrello">
						</form>
						<hr>
						<form action="WishlistControl" method="post">
							<input type="hidden" name="productId" value="<%= p.getId() %>">
							<input type="hidden" name="type" value="<%=p.getClass().getSimpleName().toLowerCase()%>">
							<input type="hidden" name="action" value="aggiungi">
							<input type="hidden" name="redirect" value="HomePage">
							<button class="bookmark" type=submit><img src="img/bookmark.png"></button>
						</form>
					</div>
		<%
				}
			}
		%>
		</div>
		
		<%@ include file="template/footer.html" %>
		
		<script src="js/scriptFeedback.js"></script>
	</body>
</html>
