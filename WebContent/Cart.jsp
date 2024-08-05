<%@ page import="java.util.Collection" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="net.bookscape.model.Cart, net.bookscape.model.CartItem, utility.EscaperHTML"%>
<html lang="it">
<head>
    <meta charset="utf-8">
   	<meta name="viewport" content="width=device-width, initial-scale=1">
   	<title>Carrello</title>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/cart.css">
    <link rel="stylesheet" href="css/feedback.css">
    <link rel="icon" href="img/logo.png" type="image/x-icon">
    <jsp:include page="header.jsp" />
</head>
<body>
   <%@ include file="template/navbar.jsp" %>
   
 	<%
		String id = (String) session.getAttribute("cliente");
		
		String feedback = (String) session.getAttribute("feedback");
 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
 		
 		session.removeAttribute("feedback");
		session.removeAttribute("feedback-negative");
		
		Cart carrello = (Cart)request.getSession().getAttribute("cart");
	%>
		
	<%@ include file="template/feedbackSection.jsp" %>
		
   <div class="container productsContainer my-3 my-md-2 my-lg-0">
	    <h1 class="text-center mb-2 mb-lg-3">Prodotti nel Carrello</h1>
	    <div class="row d-flex justify-content-center">
	        <% 
	            if(carrello != null){
	                Collection<CartItem> items = carrello.getItems();
	                if (items != null && !items.isEmpty()) {
	        %>
	        <%
	                int i = 0;
	                for (CartItem item : items) {
	        %>
	                    <div class="card mx-5 my-3">
	                        <div class="img-container">
	                            <a href="ProductDetails?productId=<%=item.getProduct().getId()%>&type=<%=item.getProduct().getClass().getSimpleName().toLowerCase()%>">
	                                <img src="<%= item.getProduct().getImgURL() %>" alt="..." class="img-fluid">
	                            </a>
	                        </div>
	                        <div class="card-body">
	                            <h5 class="card-title"><%= EscaperHTML.escapeHTML(item.getProduct().getNome())%></h5>
	                            <p class="my-0 py-0"><strong>Prezzo:</strong> <%= item.getProduct().getPrezzo() %></p>
	                            <p class="my-0 py-0"><strong>Quantità:</strong> <%= item.getNumElementi() %></p>
	                            <p class="my-0 py-0"><strong>Prezzo totale:</strong> <%= item.getTotalCost() %></p>
	                            <hr class="mb-2 mt-2">
	                           	<div class="row">
		                            <form class="col-9 col-lg-9 mt-0" action="CartControl" method="post">
		                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
		                                <input type="hidden" name="type" value="<%= item.getProduct().getClass().getSimpleName().toLowerCase() %>">
		                                <input type="hidden" name="redirect" value="Cart.jsp">
		                                <input class="form-control form-control-sm" type="number" name="quantity" value="<%= item.getNumElementi() %>" min="1" max="10" required>
		                                <input style="width:100%" class="btn btn-sm btn-success my-1" type="submit" name="action" value="Aggiorna">
		                                <input style="width:100%" class="btn btn-sm btn-danger" type="submit" name="action" value="Rimuovi">
		                            </form>
		                            <form class="col-2 mt-2 me-2" id="wishlist-form" action="WishlistControl" method="post">
		                                <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
		                                <input type="hidden" name="type" value="<%=item.getProduct().getClass().getSimpleName().toLowerCase()%>">
		                                <input type="hidden" name="action" value="aggiungi">
		                                <input type="hidden" name="redirect" value="Cart.jsp">
		                                <button class="bookmark" type="submit"><i class="bi bi-bookmark-heart"></i></button>
		                            </form>
	                            </div>
	                        </div>
	                    </div>
	        <%  
	                i++;
	                if(i > 0 && i % 4 == 0){
	        %>
	                    </div>
	                    <div class="row d-flex justify-content-center">
	        <%  
	                }
	            }
	            
	        } else { 
	        %>        
	            <p class="empty-cart-msg">Il carrello è vuoto.</p>
	        <%  
	            }
	        } else { 
	        %>        
	            <p class="empty-cart-msg">Il carrello è vuoto.</p>
	        <%  
	            }  
	        %>
	    </div>
	    
	<%
		if(carrello != null && !carrello.getItems().isEmpty()){
			%>
			<div class="row text-center">
				<button class="btn btn-primary item-background-blue text-white my-2 mb-4 mx-auto col-7 col-md-6 col-lg-4" onclick="location.href='OrderControl?action=checkout';">Procedi all'acquisto</button>
			</div>
			<%
		}
	%>	
	</div>
   
    <%@ include file="template/footer.jsp"%>
    
    <script src="js/scriptFeedback.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
