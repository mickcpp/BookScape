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
	
		<style>
			.card img {
	      		max-width: 100%;
	        }
	        .card-body {
	            padding: 10px;
	        }
	        .card-title, .card-text {
	            margin-bottom: 5px;
	        }
	      	.rating {
	            color: #f5a623;
	            font-size: 16px;
	        }
	        .card{
	        	width: 12rem;
	        	border: none;
	        }
	       	.row>*{
	     		padding-right: 0;
	     		padding-left: 0;
	       	}
	       	
	       	@media (max-width: 992px) {
				.card > *{
			
				}
			}
		</style>
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
		
		<div id="carousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="1500">
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
		          			<div class="card mx-5">
		            			<img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid">
		            			<div class="card-body">
		              				<h5 class="card-title"><%= libro.getNome() %></h5>
		              				<p class="card-text">By Shakespeare</p>
		              				<div class="rating">
		                				<% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
		                  					<i class="fas fa-star"></i>
		                				<% } %>
		              				</div>
		            			</div>
	          				</div>
			        		<% i++; } %>
			      		</div>
			    	</div>
			    
			    	<div class="carousel-item">
			      		<div class="row d-flex justify-content-center">
			        		<% i = 0; for(Libro libro : libri) { if(i < 3) { i++; continue; } if(i == 6) break; %>
		          			<div class="card mx-5">
		            			<img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid">
	            				<div class="card-body">
		              				<h5 class="card-title"><%= libro.getNome() %></h5>
	              					<p class="card-text">By Shakespeare</p>
		              				<div class="rating">
					              	<% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
					                	<i class="fas fa-star"></i>
					                <% } %>
					         		</div>
	            				</div>
		          			</div>
			        		<% i++; } %>
			      		</div>
			    	</div>
			    
					<div class="carousel-item">
			      		<div class="row d-flex justify-content-center">
			        		<% i = 0; for(Libro libro : libri) { if(i < 3) { i++; continue; } if(i == 6) break; %>
		          			<div class="card mx-5">
		            			<img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid">
	            				<div class="card-body">
		              				<h5 class="card-title"><%= libro.getNome() %></h5>
	              					<p class="card-text">By Shakespeare</p>
		              				<div class="rating">
					              	<% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
					                	<i class="fas fa-star"></i>
					                <% } %>
					         		</div>
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
		
		<div class="container-fluid">
			<div class="row d-flex justify-content-center">
	<%
			i = 0;
			for(Product prodotto : prodotti){
	%>
      		<div class="card mx-5 my-3">
         		<img src="<%= prodotto.getImgURL() %>" alt="..." class="img-fluid">
        		<div class="card-body">
           			<h5 class="card-title"><%= prodotto.getNome() %></h5>
          			<p class="card-text">By Shakespeare</p>
           			<div class="rating">
		              	<% int valutazione = 3; if(valutazioni.get(prodotto.getId()) != null) { valutazione = valutazioni.get(prodotto.getId()); } for (int j = 0; j < valutazione; j++) { %>
		                	<i class="fas fa-star"></i>
		                <% } %>
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
			if(i > 0 && i % 4 != 0){
				%>
					</div>
				<%
			}
	%>
		</div>
		
		
		
		<script src="js/scriptFeedback.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>
