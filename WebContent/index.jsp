<%@ page import="java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"%>
<%@ page import="utility.EscaperHTML"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>BookScape - Libri, CD e Vinili Online - Spedizione Veloce e Sicura</title>
    	<meta name="description" content="Acquista libri, CD, vinili e altri media online nel nostro e-commerce. Trova edizioni rare, novità e offerte speciali con spedizione veloce e sicura.">
    	<meta name="keywords" content="libri online, acquisto libri, CD online, vinili online, media online, edizioni rare, novità libri, offerte speciali, spedizione veloce, BookScape, libri, vinili, romanzi">
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
		<link rel="stylesheet" href="css/homePage.css">
		<link rel="stylesheet" href="css/feedback.css">
		<link rel="icon" href="img/logo.png" type="image/x-icon">
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
			
			List<Libro> scelteRedazione = prodotti.stream()
					.filter(P -> P instanceof Libro)
					.map(P -> (Libro) P)
					.filter(P -> P.getId() == 1056
						 	  || P.getId() == 1048
						      || P.getId() == 1062
						      || P.getId() == 1065
						      || P.getId() == 1060
						      || P.getId() == 1061
							)
					.toList();
			
			List<Musica> scelteRedazioneMusica = prodotti.stream()
					.filter(P -> P instanceof Musica)
					.map(P -> (Musica) P)
					.filter(P -> P.getId() == 1002
						 	  || P.getId() == 1011
						      || P.getId() == 1024
						      || P.getId() == 1025
						      || P.getId() == 1026
						      || P.getId() == 1023
							)
					.toList();
			
			List<Gadget> cartoleriaGadget = prodotti.stream()
					.filter(p -> p instanceof Gadget)
					.map(p -> (Gadget) p)
					.filter(p -> p.getDescrizione().contains("Penna") || p.getDescrizione().contains("Matita") || p.getDescrizione().contains("Quaderno"))
					.toList();
		%>
		
		<%!String nomeTabella = "";%>
		
		<%@ include file="template/feedbackSection.jsp" %>
		
		<div id="carousel" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="3000">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <a href="BookCatalogSearch?type=Tolkien"> <img src="img/tolkienCarosello.jpg" class="d-block w-100" alt="..."> </a>
		    </div>
		    <div class="carousel-item">
		      <a href="GadgetCatalogSearch?type=Spider-Man"> <img src="img/spidermanCarosello.jpg" class="d-block w-100" alt="..."> </a>
		    </div>
		    <div class="carousel-item">
		      <a href="MusicCatalogSearch?type=Beatles"> <img src="img/beatlesCarosello.jpg" class="d-block w-100" alt="..."> </a>
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
		
		<div class="container-lg mt-4 mt-md-5 mb-5">
            <h2 class="h1 text-center mb-3 mb-md-4">I libri piu recensiti</h2>
            <div id="bookCarousel" class="carousel slide">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="row d-flex justify-content-center">
                            <% int i = 0; for(Libro libro : libri) { if(i < 9) { i++; continue; } if(i == 12) break;  %>
                            <div class="col-4 col-md-3 col-lg-3 d-flex justify-content-center">
                                <div class="card mx-2 my-2">
                                    <div class="img-container">
                                        <a href="ProductDetails?productId=<%=libro.getId()%>&type=<%=libro.getClass().getSimpleName().toLowerCase()%>"><img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid"></a>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(libro.getNome()) %></h5>
                                        <p class="card-text mb-0 mb-sm-1">By <%=EscaperHTML.escapeHTML(libro.getAutore()) %></p>
                                        <div class="rating">
                                            <% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
                                            <i class="fas fa-star"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% i++; } %>
                        </div>
                    </div>
                
                    <div class="carousel-item">
                        <div class="row d-flex justify-content-center">
                            <% i = 0; for(Libro libro : libri) { if(i < 4) { i++; continue; } if(i == 7) break; %>
                            <div class="col-4 col-md-3 col-lg-3 d-flex justify-content-center">
                                <div class="card mx-2 my-2">
                                    <div class="img-container">
                                        <a href="ProductDetails?productId=<%=libro.getId()%>&type=<%=libro.getClass().getSimpleName().toLowerCase()%>"><img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid"></a>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(libro.getNome()) %></h5>
                                        <p class="card-text mb-0 mb-sm-1">By <%=EscaperHTML.escapeHTML(libro.getAutore()) %></p>
                                        <div class="rating">
                                            <% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
                                            <i class="fas fa-star"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% i++; } %>
                        </div>
                    </div>
                
                    <div class="carousel-item">
                        <div class="row d-flex justify-content-center">
                            <% i = 0; for(Libro libro : libri) { if(i < 12) { i++; continue; } if(i == 15) break; %>
                            <div class="col-4 col-md-3 col-lg-3 d-flex justify-content-center">
                                <div class="card mx-2 my-2">
                                    <div class="img-container">
                                        <a href="ProductDetails?productId=<%=libro.getId()%>&type=<%=libro.getClass().getSimpleName().toLowerCase()%>"><img src="<%= libro.getImgURL() %>" alt="..." class="img-fluid"></a>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(libro.getNome()) %></h5>
                                        <p class="card-text mb-0 mb-sm-1">By <%=EscaperHTML.escapeHTML(libro.getAutore()) %></p>
                                        <div class="rating">
                                            <% int valutazione = 3; if(valutazioni.get(libro.getId()) != null) { valutazione = valutazioni.get(libro.getId()); } for (int j = 0; j < valutazione; j++) { %>
                                            <i class="fas fa-star"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% i++; } %>
                        </div>
                    </div>
                </div>

                <a class="control carousel-control-prev" href="#bookCarousel" role="button" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </a>
                <a class="control carousel-control-next" href="#bookCarousel" role="button" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </a>
            </div>
        </div>
		
		<hr>
		
		<div class="container-lg mt-4 mt-md-3 mb-4">
			<h2 id="headerEditorialChoise" class="display-2 text-center mb-4">Scelte della redazione</h2>
			<div id="editorialChoises" class="carousel slide">
			 	<div class="carousel-inner">
			   		<div class="carousel-item active">
			      		<div class="row d-flex justify-content-center">
			        		<% i = 0; for(Libro libro : scelteRedazione) { if(i == 3) break; %>
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
		              				<h5 class="card-title"><%= EscaperHTML.escapeHTML(libro.getNome()) %></h5>
		              				<p class="card-text">By <%= EscaperHTML.escapeHTML(libro.getAutore()) %></p>
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
			        		<% i = 0; for(Libro libro : scelteRedazione) { if(i < 3) { i++; continue; } if(i == 6) break; %>
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
		              				<h5 class="card-title"><%= EscaperHTML.escapeHTML(libro.getNome()) %></h5>
	              					<p class="card-text">By <%= EscaperHTML.escapeHTML(libro.getAutore()) %></p>
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
			  
			 	<a class="control carousel-control-prev" href="#editorialChoises" role="button" data-bs-slide="prev">
			    	<span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    	<span class="visually-hidden">Previous</span>
			  	</a>
			  	<a class="control carousel-control-next" href="#editorialChoises" role="button" data-bs-slide="next">
			    	<span class="carousel-control-next-icon" aria-hidden="true"></span>
			    	<span class="visually-hidden">Next</span>
			  	</a>
			</div>
		</div>
		
		<hr>
		
		<div class="container-lg mt-4 mb-5 mb-lg-4">
            <h2 class="h1 text-center mb-3 mb-md-4">Il meglio in vinile</h2>
            <div id="musicCarousel" class="carousel slide">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="row d-flex justify-content-center">
                            <% i = 0; for(Musica musica : scelteRedazioneMusica) { if(i == 3) break; %>
                            <div class="col-4 col-md-3 col-lg-3 d-flex justify-content-center">
                                <div class="card mx-2 my-2">
                                    <div class="img-container">
                                        <a href="ProductDetails?productId=<%=musica.getId()%>&type=<%=musica.getClass().getSimpleName().toLowerCase()%>"><img src="<%= musica.getImgURL() %>" alt="..." class="img-fluid"></a>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(musica.getNome()) %></h5>
                                        <p class="card-text mb-0 mb-sm-1">By <%=EscaperHTML.escapeHTML(musica.getArtista()) %></p>
                                        <div class="rating">
                                            <% int valutazione = 3; if(valutazioni.get(musica.getId()) != null) { valutazione = valutazioni.get(musica.getId()); } for (int j = 0; j < valutazione; j++) { %>
                                            <i class="fas fa-star"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% i++; } %>
                        </div>
                    </div>
                
                    <div class="carousel-item">
                        <div class="row d-flex justify-content-center">
                            <% i = 0; for(Musica musica : scelteRedazioneMusica) { if(i < 3) { i++; continue; } if(i == 6) break; %>
                            <div class="col-4 col-md-3 col-lg-3 d-flex justify-content-center">
                                <div class="card mx-2 my-2">
                                    <div class="img-container">
                                        <a href="ProductDetails?productId=<%=musica.getId()%>&type=<%=musica.getClass().getSimpleName().toLowerCase()%>"><img src="<%= musica.getImgURL() %>" alt="..." class="img-fluid"></a>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(musica.getNome()) %></h5>
                                        <p class="card-text mb-0 mb-sm-1">By <%= EscaperHTML.escapeHTML(musica.getArtista()) %></p>
                                        <div class="rating">
                                            <% int valutazione = 3; if(valutazioni.get(musica.getId()) != null) { valutazione = valutazioni.get(musica.getId()); } for (int j = 0; j < valutazione; j++) { %>
                                            <i class="fas fa-star"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% i++; } %>
                        </div>
                    </div>
                </div>

                <a class="control carousel-control-prev" href="#musicCarousel" role="button" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </a>
                <a class="control carousel-control-next" href="#musicCarousel" role="button" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </a>
            </div>
        </div>
        
        <div class="container-lg mb-5 pb-2">
            <h2 class="h1 text-center mb-4 mb-md-4">Cartoleria</h2>
            <div id="gadgetCarousel" class="carousel slide">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="row d-flex justify-content-center">
                            <% i = 0; for(Gadget g : cartoleriaGadget) { if(i == 3) break; %>
                            <div class="col-4 col-md-3 col-lg-3 d-flex justify-content-center">
                                <div class="card mx-2 my-2">
                                    <div class="img-container">
                                        <a href="ProductDetails?productId=<%=g.getId()%>&type=<%=g.getClass().getSimpleName().toLowerCase()%>"><img src="<%= g.getImgURL() %>" alt="..." class="img-fluid"></a>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(g.getNome()) %></h5>
                                        <p class="card-text mb-0 mb-sm-1">By BSGadgets</p>
                                        <div class="rating">
                                            <% int valutazione = 3; if(valutazioni.get(g.getId()) != null) { valutazione = valutazioni.get(g.getId()); } for (int j = 0; j < valutazione; j++) { %>
                                            <i class="fas fa-star"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% i++; } %>
                        </div>
                    </div>
                
                    <div class="carousel-item">
                        <div class="row d-flex justify-content-center">
                            <% i = 0; for(Gadget g : cartoleriaGadget) { if(i < 3) { i++; continue; } if(i == 6) break; %>
                            <div class="col-4 col-md-3 col-lg-3 d-flex justify-content-center">
                                <div class="card mx-2 my-2">
                                    <div class="img-container">
                                        <a href="ProductDetails?productId=<%=g.getId()%>&type=<%=g.getClass().getSimpleName().toLowerCase()%>"><img src="<%= g.getImgURL() %>" alt="..." class="img-fluid"></a>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(g.getNome()) %></h5>
                                        <p class="card-text mb-0 mb-sm-1">By BSGadgets></p>
                                        <div class="rating">
                                            <% int valutazione = 3; if(valutazioni.get(g.getId()) != null) { valutazione = valutazioni.get(g.getId()); } for (int j = 0; j < valutazione; j++) { %>
                                            <i class="fas fa-star"></i>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% i++; } %>
                        </div>
                    </div>
                </div>

                <a class="control carousel-control-prev" href="#gadgetCarousel" role="button" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </a>
                <a class="control carousel-control-next" href="#gadgetCarousel" role="button" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </a>
            </div>
        </div>
		
		<%@ include file="template/footer.jsp"%>
		
		<script src="js/scriptFeedback.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>
