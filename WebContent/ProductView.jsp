<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            max-width: 30%; /* ridotto rispetto al precedente */
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
            font-size: 26px; /* leggermente ridotto rispetto al precedente */
            margin-bottom: 20px;
        }
        .product-info p {
            margin: 8px 0; /* ridotto rispetto al precedente */
            color: #666;
        }
        .btn {
            padding: 10px 20px; /* ridotto rispetto al precedente */
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-right: 10px;
            transition: background-color 0.3s;
            font-size: 14px; /* ridotto rispetto al precedente */
        }
        .btn:hover {
            background-color: #45a049;
        }
        .bookmark {
            background: none;
            border: none;
            cursor: pointer;
            transition: color 0.3s;
            font-size: 14px; /* ridotto rispetto al precedente */
        }
        .bookmark:hover {
            color: #f44336;
        }
        #logout {
            margin-left: 5%;
            padding-bottom: 10px;
            font-size: 18px;
            color: #333;
            text-decoration: none;
            transition: color 0.3s;
        }
        #logout:hover {
            color: #f44336;
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

    <%@ include file="template/footer.html" %>
</body>
</html>
