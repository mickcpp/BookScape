<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Servlet error</title>
		
		<base href="${pageContext.request.contextPath}/">
		<link rel="stylesheet" href="css/style.css">
		<link rel="stylesheet" href="css/navStyle.css">
		<link rel="stylesheet" href="css/footerStyle.css">
		
		<style>
			p{
				padding-left: 20px;
				width: 80%;
				margin-top: 0;
				padding-bottom: 40px;
			}
		</style>
	</head>
	<body>
		<%@ include file="/template/navbar.jsp" %>
		<h1 style="text-align: center;">Errore!</h1>
		<%
		  if(exception != null) {
		      out.println("<p>Exception: " + exception.getMessage());
		      out.println("<br><br>");
		      StackTraceElement[] st = exception.getStackTrace();
		      for(StackTraceElement e: st){
		          out.println(e.toString() + "<br>");
		      }
		      out.println("</p>");
		  }
		%>
		<%@ include file="/template/footer.jsp" %>
	</body>
</html>