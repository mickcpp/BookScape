<%@ page import="java.util.Collection, java.util.Iterator" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Wishlist, utility.EscaperHTML"%>

<html>
	<head>
	    <title>Wishlist</title>
	    <link rel="stylesheet" href="css/style.css">
	    <link rel="stylesheet" href="css/feedback.css">
	    <style>
	        body {
	            font-family: Arial, sans-serif;
	            background-color: #f4f4f4;
	            margin: 0;
	            padding: 0;
	        }
	        .container {
	            max-width: 1200px;
	            margin: 0 auto;
	            margin-top: -30px;
	            margin-bottom: 24px;
	        }
	        
	        h1 {
	            text-align: center;
	            color: #333;
	            margin-bottom: 10px;
	            margin-top: 0px;
	        }
	        .wishlist-items {
	            display: flex;
	            flex-wrap: wrap;
	            justify-content: center;
	        }
	        .product {
	            margin: 20px;
	            padding: 20px;
	            background-color: #fff;
	            border-radius: 8px;
	            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	            width: 155px;
	        }
	        .product img {
	            width: 100%;
	            height: auto;
	            border-radius: 8px;
	            object-fit: cover;
	        }
	        .product-info {
	            
	        }
	        .product-info p {
	            margin: 5px 0;
	        }
	        .action-buttons {
	            margin-top: 10px;
	        }
	        .action-buttons form {
	           	margin: 5px 0px;
	        }
	        .action-buttons input[type="submit"] {
	        	border: 1px solid grey;
	            padding: 4px 7px;
	            text-align: center;
	            text-decoration: none;
	            font-size: 15px;
	            cursor: pointer;
	            border-radius: 5px;
	            transition: background-color 0.3s;
	        }
	        .action-buttons input[type="submit"]:hover {
	            background-color: #0056b3;
	        }
	        
	        .empty-wishlist-msg {
	            text-align: center;
	            margin-top: 20px;
	            color: #666;
	        }
	        .logout {
	           	position: absolute;
				margin-left: 5%;
				top: 138px;
				padding-bottom: 10px;
				font-size: 18px;
	        }
	     
	        @media screen and (max-width: 768px) {
	            .product {
	                width: 45%;
	            }
	        }
	        @media screen and (max-width: 576px) {
	            .product {
	                width: 100%;
	            }
	        }
	        #searchbar-section{
		       	display: none;
		    }
	    </style>
	</head>
	<body>
		<%@ include file="template/navbar.jsp" %>
		
		<a class="logout" href="Logout">Logout</a>
	
		<%
			String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 		
	 		session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
		%>
		  
		<%@ include file="template/feedbackSection.jsp" %>
		
		<div class="container">
		    <%
		        String id = (String) session.getAttribute("cliente");
		        Wishlist wishlist = null;
		
		        if (id != null && !id.equals("")) {
		            wishlist = (Wishlist) request.getSession().getAttribute("wishlist");
		            if (wishlist == null) {
		                response.sendRedirect("WishlistControl");
		                return;
		            }
		    %>
		    <%
		        } else {
		            response.sendRedirect("Login?redirect=Wishlist.jsp");
		        }
		    %>
		
		    <h1>Prodotti nella Wishlist</h1>
		    <div class="wishlist-items">
		        <%
		            if (wishlist != null) {
		                Collection<Product> products = wishlist.getItems();
		                if (products != null && !products.isEmpty()) {
		                    Iterator<Product> iterator = products.iterator();
		                    while (iterator.hasNext()) {
		                        Product product = iterator.next();
		        %>
		        <div class="product">
					<a href="ProductDetails?productId=<%=product.getId()%>&type=<%=product.getClass().getSimpleName().toLowerCase()%>"><img src="<%=product.getImgURL()%>"></a>                              
		            <div class="product-info">
		                <p><strong>Nome Prodotto:</strong> <%= EscaperHTML.escapeHTML(product.getNome()) %></p>
		                <p><strong>Prezzo:</strong> <%= product.getPrezzo() %></p>
		                <div class="action-buttons">
		                    <form action="CartControl" method="post">
		                        <input type="hidden" name="productId" value="<%= product.getId() %>">
		                        <input type="hidden" name="type" value="<%= product.getClass().getSimpleName().toLowerCase() %>">
		                        <input type="hidden" name="action" value="aggiungi">
		                        <input type="hidden" name="redirect" value="Wishlist.jsp">
		                        <input type="submit" value="Aggiungi al carrello">
		                    </form>
		                    <form action="WishlistControl" method="post">
		                        <input type="hidden" name="productId" value="<%= product.getId() %>">
		                        <input type="hidden" name="type" value="<%= product.getClass().getSimpleName().toLowerCase() %>">
		                        <input type="hidden" name="redirect" value="Wishlist.jsp">
		                        <input type="submit" name="action" value="Rimuovi">
		                    </form>
		                </div>
		            </div>
		        </div>
		        <%
		                    }
		                } else {
		        %>
		        <p class="empty-wishlist-msg">Nessun prodotto nella Wishlist.</p>
		        <%
		                }
		            } else {
		        %>
		        <p class="empty-wishlist-msg">Nessun prodotto nella Wishlist.</p>
		        <%
		            }
		        %>
		    </div>
		</div>
		
		<%@ include file="template/footer.html" %>
		
		<script src="js/scriptFeedback.js"></script>
	</body>
</html>
