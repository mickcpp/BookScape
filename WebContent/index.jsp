<%@ page import="java.util.*" import="net.bookscape.model.Product" import="net.bookscape.control.HomePage" language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>BookScape</title>
		<link rel="stylesheet" href="css/style.css">
	</head>
	<body>
		<%@ include file="template/navbar.html" %>
		
		<%
			Collection<Product> prodotti = (Collection<Product>) request.getAttribute("prodotti");
			if(prodotti == null){
				response.sendRedirect("HomePage");
				return;
			}
		%>
		
		<%
			for(Product p: prodotti){
				%>
				<p><%= p %></p>
				<%
			}
		%>
		
		<%@ include file="template/footer.html" %>
	</body>
</html>