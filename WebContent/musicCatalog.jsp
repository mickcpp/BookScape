<%@ page import="java.util.*" import="net.bookscape.model.Musica, net.bookscape.control.MusicCatalog" language="java" contentType="text/html; charset=UTF-8"
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
			Collection<Musica> musics = (Collection<Musica>) request.getAttribute("musics");
			if(musics == null){
				response.sendRedirect("MusicCatalog");
				return;
			}
		%>
		
		<%
			for(Musica m: musics){
				%>
				<p><%= m %></p>
				<%
			}
		%>
		
		<%@ include file="template/footer.html" %>
	</body>
</html>