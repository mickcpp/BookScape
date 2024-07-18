<%@ page import="java.util.Collection" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="net.bookscape.model.Cart, net.bookscape.model.CartItem, utility.EscaperHTML"%>
<html>
<head>
    <meta charset="utf-8">
   	<meta name="viewport" content="width=device-width, initial-scale=1">
   	<title>Carrello</title>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/feedback.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        
  		.section-menu {
  			display: none;
  		}
  		
        h1 {
            text-align: center;
            color: #333;
            margin-top: 0;
            margin-bottom: 7px;
            font-size: 2em;
        }
        #cart-items {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .product {
            margin: 20px 20px 15px 20px;
            padding: 10px 10px 0px 10px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 200px;
        }
        .product img {
            width: 100%;
            border-radius: 8px;
        }
        .product-info {
            margin-top: 10px;
        }
        .product-info p {
            margin: 5px 0;
        }
        .checkout-btn {
            display: block;
            margin: 0px auto 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .checkout-btn:hover {
            background-color: #0056b3;
        }
        .footer {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
       	#logout{
      		position: absolute;
			margin-left: 5%;
			top: 138px;
			padding-bottom: 10px;
			font-size: 18px;
		}
		#searchbar-section{
	      	display: none;
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
		
		String feedback = (String) session.getAttribute("feedback");
 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
 		
 		session.removeAttribute("feedback");
		session.removeAttribute("feedback-negative");
	%>
		
	<%@ include file="template/feedbackSection.jsp" %>
	
    <div class="container">
      	<h1>Prodotti nel Carrello</h1>
        <div id="cart-items">
            <% 
                Cart carrello = (Cart)request.getSession().getAttribute("cart");
                if(carrello != null){
                    Collection<CartItem> items = carrello.getItems();
                    if (items != null && !items.isEmpty()) {
            %>
            <%
                        for (CartItem item : items) {
            %>
                            <div class="product">
									<a href="ProductDetails?productId=<%=item.getProduct().getId()%>&type=<%=item.getProduct().getClass().getSimpleName().toLowerCase()%>"><img src="<%=item.getProduct().getImgURL()%>"></a>                                <div class="product-info">
                                    <p><strong>Nome Prodotto:</strong> <%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %></p>
                                    <p><strong>Prezzo:</strong> <%= item.getProduct().getPrezzo() %></p>
                                    <p><strong>Quantità:</strong> <%= item.getNumElementi() %></p>
                                    <hr>
                                    <p><strong>Prezzo totale:</strong> <%= item.getTotalCost() %></p>
                                    <hr>
                                    <form action="CartControl" method="post">
                                        <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                        <input type="hidden" name="type" value="<%= item.getProduct().getClass().getSimpleName().toLowerCase() %>">
                                        <input type="hidden" name="redirect" value="Cart.jsp">
                                        <input type="number" name="quantity" value="<%= item.getNumElementi() %>" min="1" max="10">
                                        <input type="submit" name="action" value="Aggiorna">
                                        <input type="submit" name="action" value="Rimuovi">
                                    </form>
                                </div>
                            </div>
            <%  
                        }
                    } else { 
            %>		
                        <p class="empty-cart-msg">Il carrello è vuoto.</p>
            <%          }
                } else { 
            %>		
                    <p class="empty-cart-msg">Il carrello è vuoto.</p>
            <%  }  %>
            
        </div>
        
   		<%
   			if(carrello != null && !carrello.getItems().isEmpty()){
   				%>
   				<button class="checkout-btn" onclick="location.href='OrderControl?action=checkout';">Procedi all'acquisto</button>
   				<%
   			}
   		%>
    </div>
    
    <%@ include file="template/footer.jsp"%>
    
    <script src="js/scriptFeedback.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
