<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Dettagli Prodotto</title>
	<link rel="stylesheet" href="css/style.css">
<style>
    /* Stile per la struttura del prodotto */
    .product-container {
        border: 1px solid #ccc;
        border-radius: 5px;
        padding: 20px;
        margin: 20px auto;
        max-width: 500px;
    }
    .product-image {
        width: 100%;
        max-width: 200px;
        height: auto;
    }
    .product-info {
        margin-top: 10px;
    }
    .product-info p {
        margin: 5px 0;
    }
    .btn {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-right: 10px;
    }
    #logout{
		margin-left: 5%;
		padding-bottom: 10px;
		font-size: 18px;
	}
</style>
</head>
<body>
	<%@ include file="template/navbar.html" %>
	
	<%
		String id = (String) session.getAttribute("cliente");
		if(id != null && !id.equals("")){
			%>
			<a id="logout" href="Logout">Logout</a>
			<%
		}
	%>
	
	<% if(request.getAttribute("prodotto") == null){
			response.sendRedirect("./");
			return;
		}
	%>
	<div class="product-container">
	    <img src="${prodotto.imgURL}" alt="Immagine Prodotto" class="product-image">
	    <div class="product-info">
	        <h2>${prodotto.nome}</h2>
	        <p>${prodotto.descrizione}</p>
	        <p>Prezzo: ${prodotto.prezzo}</p>
	        <p>Disponibilità: ${prodotto.quantita}</p>
	    <form action="CartControl" method="post">
	    	<input type="hidden" name="productId" value="${prodotto.getId()}">
			<input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
			<input type="hidden" name="action" value="aggiungi">
			<input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
	        <button class="btn">Aggiungi al carrello</button>
		</form>
	    </div>
	</div>
	
	<%@ include file="template/footer.html" %>
</body>
</html>

