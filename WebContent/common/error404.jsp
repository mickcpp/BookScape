<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Pagina non trovata</title>
	
	<base href="${pageContext.request.contextPath}/">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/navStyle.css">
	<link rel="stylesheet" href="css/footerStyle.css">
	
	<style>
		.errorContent{
			text-align: center;
			padding: 5px 0px 30px 0px;
		}
		p{
			font-size: 20px;
			color: #5E5B58;
		}
	</style>
</head>
<body>
	<%@ include file="/template/navbar.jsp" %>
	<div class="errorContent">
		<h1>Errore! Pagina non trovata.</h1>
		<img src="img/errorBook.png" alt="erroreImg" width="30%">
		<p>
		Sembra che la pagina che stai cercando non esista,
		è possible che il contenuto sia stato eliminato o che
		la URL non sia stata digitata correttamente.
		</p>
	</div>
	<%@ include file="/template/footer.html" %>
</body>
</html>