<%@ page import="java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"%>
<%@ page import="utility.EscaperHTML"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>Home</title>
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
		<link rel="stylesheet" href="css/homePage.css">
		<link rel="stylesheet" href="css/feedback.css">
	</head>
	
	<body>
		<%@ include file="template/navbar.jsp"%>
		
		<%
			String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 	
			session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
			
			@SuppressWarnings("unchecked")
			List<Product> prodotti = (List<Product>) request.getAttribute("prodotti");
			
			@SuppressWarnings("unchecked")
			Map<Integer, Integer> valutazioni = (HashMap<Integer, Integer>) request.getAttribute("valutazioni");
			
			if(prodotti == null || prodotti.isEmpty() || valutazioni == null) {
				response.sendRedirect("HomePage");
				return;
			}
			
			List<Libro> libri = prodotti.stream()
						.filter(P -> P instanceof Libro)
						.map(P -> (Libro) P)
						.toList();
		%>
		
		<%!String nomeTabella = "";%>
		
		<%@ include file="template/feedbackSection.jsp" %>
		
		<div id="carousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="3000">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="img/offertaCarosello.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="img/tolkienCarosello.jpg" class="d-block w-100" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="img/spidermanCarosello.jpg" class="d-block w-100" alt="...">
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
		
		<div class="container-lg mt-5 mb-5">
			<h2 class="h1 text-center mb-4">I libri piu recensiti</h2>
			<div id="bookCarousel" class="carousel slide">
			 	<div class="carousel-inner">
			   		<div class="carousel-item active">
			      		<div class="row d-flex justify-content-center">
			        		<% int i = 0; for(Libro libro : libri) { if(i == 3) break; %>
		          			<div class="card mx-5 my-2">
		            			<div class="img-container">
				      				<a href="ProductDetails?productId=<%=libro.getId()%>&type=<%=libro.getClass().getSimpleName().toLowerCase()%>"><img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid"></a>
					         		<form action="CartControl" method="post">
										<input type="hidden" name="productId" value="<%= libro.getId() %>">
										<input type="hidden" name="type" value="<%=libro.getClass().getSimpleName().toLowerCase()%>">
										<input type="hidden" name="action" value="aggiungi">
										<input type="hidden" name="redirect" value="HomePage">
										<input type="submit" value="Aggiungi al carrello" class="add-to-cart">
									</form>
				      			</div>
		            			<div class="card-body">
		              				<h5 class="card-title"><%= libro.getNome() %></h5>
		              				<p class="card-text">By <%=libro.getAutore() %></p>
		              				<div class="rating me-2">
		                				<% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
		                  					<i class="fas fa-star"></i>
		                				<% } %>
		              				</div>
		              				<form id="wishlist-form" action="WishlistControl" method="post">
										<input type="hidden" name="productId" value="<%= libro.getId() %>">
										<input type="hidden" name="type" value="<%=libro.getClass().getSimpleName().toLowerCase()%>">
										<input type="hidden" name="action" value="aggiungi">
										<input type="hidden" name="redirect" value="HomePage">
										<button class="bookmark" type=submit><i class="bi bi-bookmark-heart"></i></button>
									</form>
		            			</div>
	          				</div>
			        		<% i++; } %>
			      		</div>
			    	</div>
			    
			    	<div class="carousel-item">
			      		<div class="row d-flex justify-content-center">
			        		<% i = 0; for(Libro libro : libri) { if(i < 3) { i++; continue; } if(i == 6) break; %>
		          			<div class="card mx-5 my-2">
		            			<div class="img-container">
				      				<a href="ProductDetails?productId=<%=libro.getId()%>&type=<%=libro.getClass().getSimpleName().toLowerCase()%>"><img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid"></a>
					         		<form action="CartControl" method="post">
										<input type="hidden" name="productId" value="<%= libro.getId() %>">
										<input type="hidden" name="type" value="<%=libro.getClass().getSimpleName().toLowerCase()%>">
										<input type="hidden" name="action" value="aggiungi">
										<input type="hidden" name="redirect" value="HomePage">
										<input type="submit" value="Aggiungi al carrello" class="add-to-cart">
									</form>
				      			</div>
	            				<div class="card-body">
		              				<h5 class="card-title"><%= libro.getNome() %></h5>
	              					<p class="card-text">By <%=libro.getAutore() %></p>
		              				<div class="rating me-2">
					              	<% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
					                	<i class="fas fa-star"></i>
					                <% } %>
					         		</div>
					         		<form id="wishlist-form" action="WishlistControl" method="post">
										<input type="hidden" name="productId" value="<%= libro.getId() %>">
										<input type="hidden" name="type" value="<%=libro.getClass().getSimpleName().toLowerCase()%>">
										<input type="hidden" name="action" value="aggiungi">
										<input type="hidden" name="redirect" value="HomePage">
										<button class="bookmark" type=submit><i class="bi bi-bookmark-heart"></i></button>
									</form>
	            				</div>
		          			</div>
			        		<% i++; } %>
			      		</div>
			    	</div>
			    
					<div class="carousel-item">
			      		<div class="row d-flex justify-content-center">
			        		<% i = 0; for(Libro libro : libri) { if(i < 6) { i++; continue; } if(i == 9) break; %>
		          			<div class="card mx-5 my-2">
		            			<div class="img-container">
				      				<a href="ProductDetails?productId=<%=libro.getId()%>&type=<%=libro.getClass().getSimpleName().toLowerCase()%>"><img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid"></a>
					         		<form action="CartControl" method="post">
										<input type="hidden" name="productId" value="<%= libro.getId() %>">
										<input type="hidden" name="type" value="<%=libro.getClass().getSimpleName().toLowerCase()%>">
										<input type="hidden" name="action" value="aggiungi">
										<input type="hidden" name="redirect" value="HomePage">
										<input type="submit" value="Aggiungi al carrello" class="add-to-cart">
									</form>
				      			</div>
	            				<div class="card-body">
		              				<h5 class="card-title"><%= libro.getNome() %></h5>
	              					<p class="card-text">By <%=libro.getAutore() %></p>
		              				<div class="rating me-2">
					              	<% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
					                	<i class="fas fa-star"></i>
					                <% } %>
					         		</div>
					         		<form id="wishlist-form" action="WishlistControl" method="post">
										<input type="hidden" name="productId" value="<%= libro.getId() %>">
										<input type="hidden" name="type" value="<%=libro.getClass().getSimpleName().toLowerCase()%>">
										<input type="hidden" name="action" value="aggiungi">
										<input type="hidden" name="redirect" value="HomePage">
										<button class="bookmark" type=submit><i class="bi bi-bookmark-heart"></i></button>
									</form>
	            				</div>
		          			</div>
			        		<% i++; } %>
			      		</div>
			    	</div>
			    </div>
			  
			 	<a class="carousel-control-prev" href="#bookCarousel" role="button" data-bs-slide="prev">
			    	<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    	<span class="visually-hidden">Previous</span>
			  	</a>
			  	<a class="carousel-control-next" href="#bookCarousel" role="button" data-bs-slide="next">
			    	<span class="carousel-control-next-icon" aria-hidden="true"></span>
			    	<span class="visually-hidden">Next</span>
			  	</a>
			</div>
		</div>
		
		<hr>
		
		<div class="container-fluid productsContainer">
			<div class="row d-flex justify-content-center">
	<%
			i = 0;
			for(Product prodotto : prodotti){
	%>
      		<div class="card mx-5 my-3">
      			<div class="img-container">
      				<a href="ProductDetails?productId=<%=prodotto.getId()%>&type=<%=prodotto.getClass().getSimpleName().toLowerCase()%>"><img src="<%= prodotto.getImgURL() %>" alt="..." class="img-fluid"></a>
	         		<form action="CartControl" method="post">
						<input type="hidden" name="productId" value="<%= prodotto.getId() %>">
						<input type="hidden" name="type" value="<%=prodotto.getClass().getSimpleName().toLowerCase()%>">
						<input type="hidden" name="action" value="aggiungi">
						<input type="hidden" name="redirect" value="HomePage">
						<input type="submit" value="Aggiungi al carrello" class="add-to-cart">
					</form>
      			</div>
        
        		<div class="card-body">
           			<h5 class="card-title"><%= prodotto.getNome() %></h5>
      				<%
      					if(prodotto instanceof Libro){
      						%>
      							<p class="card-text">By <%= ((Libro) prodotto).getAutore() %></p>
      						<%
      					} else if(prodotto instanceof Musica){
      						%>
  								<p class="card-text">By <%= ((Musica) prodotto).getArtista() %></p>
  							<%
      					} else{
      						%>
								<p class="card-text"> BS Gadget</p>
							<%
      					}
      				%>
           			<div class="rating me-2">
		              	<% int valutazione = 3; if(valutazioni.get(prodotto.getId()) != null) { valutazione = valutazioni.get(prodotto.getId()); } for (int j = 0; j < valutazione; j++) { %>
		                	<i class="fas fa-star"></i>
		                <% } %>
         			</div>
         			<form id="wishlist-form" action="WishlistControl" method="post">
						<input type="hidden" name="productId" value="<%= prodotto.getId() %>">
						<input type="hidden" name="type" value="<%=prodotto.getClass().getSimpleName().toLowerCase()%>">
						<input type="hidden" name="action" value="aggiungi">
						<input type="hidden" name="redirect" value="HomePage">
						<button class="bookmark" type=submit><i class="bi bi-bookmark-heart"></i></button>
					</form>
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
			if(i > 0 && i % 4 != 0){
				%>
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
