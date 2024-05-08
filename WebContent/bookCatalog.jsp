<%@ page import="java.util.*" import="net.bookscape.model.Libro, net.bookscape.control.BookCatalog" language="java" contentType="text/html; charset=UTF-8"
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
			Collection<Libro> libri = (Collection<Libro>) request.getAttribute("libri");
			if(libri == null){
				response.sendRedirect("BookCatalog");
				return;
			}
		%>
		
		<%
			for(Libro l: libri){
				%>
				<p><%= l %></p>
				<%
			}
		%>
		
		<%@ include file="template/footer.html" %>
	</body>
</html>