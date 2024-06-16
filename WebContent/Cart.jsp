<%@ page import="java.util.Collection, net.bookscape.model.Cart, net.bookscape.model.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Carrello</title>
    <link rel="stylesheet" href="css/style.css">
    
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
            margin-top: -50px;
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
            width: 170px;
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
            margin: 0px auto 15px auto;
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
	%>
		
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
                                    <p><strong>Nome Prodotto:</strong> <%= item.getProduct().getNome() %></p>
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
    
    <%@ include file="template/footer.html" %>
</body>
</html>
