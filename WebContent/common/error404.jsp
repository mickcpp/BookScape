<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
	  	<meta name="viewport" content="width=device-width, initial-scale=1">
	  	<title>Pagina non trovata</title>
	  	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		
		<base href="${pageContext.request.contextPath}/">
		<link rel="stylesheet" href="css/style.css">
		<jsp:include page="/header.jsp" />
		
		<style>
			.errorContent{
				text-align: center;
				padding: 5px 0px 30px 0px;
				margin-top: 20px;
			}
			#paragrafoErrore{
				font-size: 20px;
				color: #5E5B58;
			}
			.section-menu{
				display: none;
			}
		</style>
	</head>
	
	<body>
		<%@ include file="/template/navbar.jsp" %>
		<div class="errorContent">
			<h1>Errore! Pagina non trovata.</h1>
			<img src="img/errorBook.png" alt="erroreImg" width="30%">
			<p id="paragrafoErrore">
			Sembra che la pagina che stai cercando non esista,
			è possible che il contenuto sia stato eliminato o che
			la URL non sia stata digitata correttamente.
			</p>
		</div>
		
		<%@ include file="/template/footer.jsp"%>
		
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>