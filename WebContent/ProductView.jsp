<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="utility.EscaperHTML"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Dettagli Prodotto</title>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	    <link rel="stylesheet" href="css/style.css">
	    
	    <style>
	        /* Stile per la struttura del prodotto */
	        body {
	            font-family: Arial, sans-serif;
	            background-color: #f9f9f9;
	            margin: 0;
	            padding: 0;
	        }
	        .container {
	            display: flex;
	            justify-content: center;
	            align-items: center;
	            margin-bottom: 42px;
	            background-color: #f9f9f9;
	            padding: 20px;
	        }
	        .product-container {
	            display: flex;
	            align-items: center;
	            background-color: #fff;
	            border-radius: 10px;
	            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	            width: 80%;
	            max-width: 800px;
	            overflow: hidden;
	        }
	        .product-image {
	            flex: 1;
	            max-width: 30%;
	            height: auto;
	            border-radius: 10px 0 0 10px;
	            object-fit: cover;
	        }
	        .product-info {
	            flex: 1;
	            padding: 30px;
	            text-align: left;
	        }
	        .product-info h2 {
	            color: #333;
	            margin-top: 0;
	            font-size: 26px;
	            margin-bottom: 20px;
	        }
	        .product-info p {
	            margin: 8px 0;
	            color: #666;
	        }
	        .btn {
	            padding: 10px 20px;
	            background-color: #4CAF50;
	            color: white;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            margin-right: 10px;
	            transition: background-color 0.3s;
	            font-size: 14px;
	        }
	        .btn:hover {
	            background-color: #45a049;
	        }
	        .bookmark {
	            background: none;
	            border: none;
	            cursor: pointer;
	            transition: color 0.3s;
	            font-size: 14px;
	        }
	        .bookmark:hover {
	            color: #f44336;
	        }
	       	#logout {
	            position: absolute;
	            margin-left: 3%;
	            top: 130px;
	            margin-bottom: 20px;
	            font-size: 18px;
	        }
	        .review-section {
	            width: 80%;
	            max-width: 800px;
	            background-color: #fff;
	            padding: 20px;
	            border-radius: 10px;
	            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	            margin: 20px auto;
	            text-align: left;
	        }
	        .review-section h3 {
	            margin-top: 0;
	            color: #333;
	            font-size: 24px;
	        }
	        .review-section textarea {
	   			box-sizing: border-box;
	            width: 100%;
	            height: 100px;
	            padding: 10px;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	            margin-bottom: 10px;
	            font-family: Arial, sans-serif;
	            resize: vertical;
	       		min-height: 35px;
	        }
	        .review-section .rating {
	            margin-bottom: 15px;
	           	direction: rtl;
	        }
	        .review-section .rating input {
	            display: none;
	        }
	        .review-section .rating label {
	            color: #ddd;
	            font-size: 20px;
	            cursor: pointer;
	            transition: color 0.2s;
	        }
	        .review-section .rating input:checked ~ label,
	        .review-section .rating label:hover,
	        .review-section .rating label:hover ~ label {
	            color: #f5a623;
	        }
	        .review-section button {
	            padding: 10px 20px;
	            background-color: #4CAF50;
	            color: white;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            font-size: 16px;
	            transition: background-color 0.3s;
	        }
	        .review-section button:hover {
	            background-color: #45a049;
	        }
	    </style>
	</head>
	<body>
	    <%@ include file="template/navbar.jsp" %>
	
	    <%
	        String id = (String) session.getAttribute("cliente");
	        if(id != null && !id.equals("")){
	    %>
	        <a id="logout" href="Logout">Logout</a>
	    <%
	        }
	    %>
	
	    <%
	        if(request.getAttribute("prodotto") == null){
	            response.sendRedirect("./");
	            return;
	        }
	    %>
	
    	<div class="container">
	        <div class="product-container">
	            <img src="${prodotto.imgURL}" alt="Immagine Prodotto" class="product-image">
	            <div class="product-info">
	                <h2>${EscaperHTML.escapeHTML(prodotto.nome)}</h2>
	                <p>${EscaperHTML.escapeHTML(prodotto.descrizione)}</p>
	                <p>Prezzo: ${prodotto.prezzo}</p>
	                <p>Disponibilità: ${prodotto.quantita}</p>
	                <form action="CartControl" method="post">
	                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <input type="hidden" name="action" value="aggiungi">
	                    <input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <button class="btn">Aggiungi al carrello</button>
	                </form>
	                <hr>
	                <form action="WishlistControl" method="post">
	                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                    <input type="hidden" name="action" value="aggiungi">
	                    <input type="hidden" name="redirect" value="ProductView.jsp">
	                    <button class="bookmark" type="submit"><i class="far fa-bookmark"></i> Aggiungi alla lista desideri</button>
	                </form>
	            </div>
	        </div>
	    </div>
	
	    <div class="review-section">
	        <h3>Scrivi una Recensione</h3>
	        <form action="RecensioneControl" method="post">
	        	<input type="hidden" name="action" value="insert">   
	        	<input type="hidden" name="productId" value="${prodotto.getId()}">   
	        	<input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">         
	        	<div class="rating">
	                <input type="radio" name="rating" id="star5" value="5">
	                <label for="star5" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star4" value="4">
	                <label for="star4" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star3" value="3">
	                <label for="star3" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star2" value="2">
	                <label for="star2" class="fas fa-star"></label>
	                <input type="radio" name="rating" id="star1" value="1">
	                <label for="star1" class="fas fa-star"></label>
	            </div>
	            <textarea id="Recensione" name="recensione" placeholder="Scrivi qui la tua recensione..."></textarea>
	            <button type="submit">Invia Recensione</button>
	        </form>
	    </div>
	
	    <%@ include file="template/footer.html" %>
	</body>
</html>