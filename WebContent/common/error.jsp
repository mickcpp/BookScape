<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Servlet error</title>
		<link rel="stylesheet" href="css/style.css">
	</head>
	<body>
		<%@ include file="/template/navbar.html" %>
		<h1 style="text-align: center; margin-top: 110px;">Errore!</h1>
		<%
		  if(exception != null) {
		      out.println("Exception: "+exception.getMessage());
		      out.println("<br><br>");
		      StackTraceElement[] st = exception.getStackTrace();
		      for(StackTraceElement e: st){
		          out.println(e.toString()+"<br>");
		      }
		
		  }
		%>
		<div style="margin-top: 270px"></div>
		<%@ include file="/template/footer.html" %>
	</body>
</html>