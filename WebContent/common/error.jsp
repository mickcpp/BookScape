<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>Servlet Error</title>
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		
		<base href="${pageContext.request.contextPath}/">
		<link rel="stylesheet" href="css/style.css">
		<jsp:include page="/header.jsp" />
		
		<style>
			#paragrafoErrore{
				font-size: 20px;
				color: #5E5B58;
				margin-top: 0;
				padding-bottom: 220px;
				text-align: center;
			}
			.section-menu{
				display: none;
			}
			h1{
				margin-top: 20px;
			}
		</style>
	</head>
	<body>
		<%@ include file="/template/navbar.jsp" %>
		<h1 style="text-align: center;">Errore!</h1>
		 
		<p id="paragrafoErrore">Si è verificato un problema!</p> 
		
		<%@ include file="/template/footer.jsp"%>
		
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>