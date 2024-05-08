<%@ page import="java.util.*" import="net.bookscape.model.Gadget, net.bookscape.control.GadgetCatalog" language="java" contentType="text/html; charset=UTF-8"
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
			Collection<Gadget> gadgets = (Collection<Gadget>) request.getAttribute("gadgets");
			if(gadgets == null){
				response.sendRedirect("GadgetCatalog");
				return;
			}
		%>
		
		<%
			for(Gadget g : gadgets){
				%>
				<p><%= g %></p>
				<%
			}
		%>
		
		<%@ include file="template/footer.html" %>
	</body>
</html>