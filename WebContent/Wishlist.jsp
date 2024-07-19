<%@ page import="java.util.Collection, java.util.Iterator" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Wishlist, utility.EscaperHTML"%>

<html>
	<head>
	    <meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>Wishlist</title>
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	    <link rel="stylesheet" href="css/cart.css">
	    <link rel="stylesheet" href="css/wishlist.css">
	    <link rel="stylesheet" href="css/feedback.css">
	</head>

	<body>
		<%@ include file="template/navbar.jsp" %>
	
		<%
			String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 		
	 		session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
		%>
		  
		<%@ include file="template/feedbackSection.jsp" %>
		
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
		
		<div class="container productsContainer my-3 my-lg-0">
		    <h1 class="text-center mb-2 mb-lg-3">Prodotti nella wishlist</h1>
		    <div class="row d-flex justify-content-center">
		        <% 
		            if(wishlist != null){
		                Collection<Product> products = wishlist.getItems();
		                if (products != null && !products.isEmpty()) {
		                	
		                int i = 0;
		                for (Product product : products) {
		        %>
		                    <div class="card mx-5 my-3">
		                        <div class="img-container">
		                            <a href="ProductDetails?productId=<%=product.getId()%>&type=<%=product.getClass().getSimpleName().toLowerCase()%>">
		                                <img src="<%= product.getImgURL() %>" alt="..." class="img-fluid">
		                            </a>
		                            <form action="CartControl" method="post">
				                        <input type="hidden" name="productId" value="<%= product.getId() %>">
				                        <input type="hidden" name="type" value="<%= product.getClass().getSimpleName().toLowerCase() %>">
				                        <input type="hidden" name="action" value="aggiungi">
				                        <input type="hidden" name="redirect" value="Wishlist.jsp">
				                        <input type="submit" value="Aggiungi al carrello" class="add-to-cart">
				                    </form>
		                        </div>
		                        <div class="card-body">
		                       		<h5 class="card-title"><%= product.getNome() %></h5>
		                           	<div class="row mt-3">
			                            <p class="col-9 my-0 py-0"><strong>Prezzo:</strong> <%= product.getPrezzo() %></p>
			                          
			                            <form id="wishlist-form" class="col-3" action="WishlistControl" method="post">
					                        <input type="hidden" name="productId" value="<%= product.getId() %>">
					                        <input type="hidden" name="type" value="<%= product.getClass().getSimpleName().toLowerCase() %>">
					                        <input type="hidden" name="redirect" value="Wishlist.jsp">
					                        <button type="submit" name="action" value="Rimuovi"><i class="bi bi-bookmark-x"></i></button>
					                    </form>
					                    
					                    <hr class="mb-1">
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
		            <p class="empty-cart-msg">Non hai nessun prodotto nella wishlist.</p>
		        <%  
		            }
		        } else { 
		        %>        
		            <p class="empty-cart-msg">Non hai nessun prodotto nella wishlist.</p>
		        <%  
		            }  
		        %>
		    </div>
		</div>
		
		<%@ include file="template/footer.jsp"%>
		
		<script src="js/scriptFeedback.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>
