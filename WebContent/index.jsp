<%@ page import="java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"%>
<%@ page import="utility.EscaperHTML"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>BookScape</title>
        <link rel="stylesheet" href="css/feedback.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="js/scriptFeedback.js"></script>
        
        <style>
            .product img#productImage {
                width: 100%;
                height: 300px; /* Altezza fissa */
                object-fit: contain; /* Adatta l'immagine senza distorcerla */
                border-radius: 8px;
            }
            .bookmark img {
                width: 20px;
                height: 20px;
            }
            #logout {
                font-size: 18px;
                position: absolute;
                margin-left: 3%;
                top: 130px;
                margin-bottom: 20px;
            }
            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-color: black; /* Colore di sfondo per migliorare la visibilità */
                border-radius: 50%;
                padding: 30px; /* Aggiungi padding per aumentare la dimensione del bottone */
            }
            .carousel-control-prev-icon:hover,
            .carousel-control-next-icon:hover {
                background-color: grey; /* Cambia colore al passaggio del mouse */
            }
            .carousel-inner img {
                width: 100%;
                height: 700px; /* Altezza fissa per tutte le immagini del carosello */
                object-fit: fit; /* Adatta l'immagine senza distorcerla */
            }
            .carousel-item{
            	transition: transform 0.8s ease-in-out;
            }
        </style>
    </head>
    <body >
        <%@ include file="template/navbar.jsp" %>

        <%
            String id = (String) session.getAttribute("cliente");
            if (id != null && !id.equals("")) {
        %>
                <a id="logout" href="Logout" class="btn btn-danger">Logout</a>
        <%
            }

            String feedback = (String) request.getAttribute("feedback");
            String feedbackNegativo = (String) request.getAttribute("feedback-negative");
        %>

        <%!String nomeTabella = ""; %>

        <%@ include file="template/feedbackSection.jsp" %>

        <!-- Inizio del carosello -->
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active" data-interval="5000">
                    <img src="img/tolkienCarosello.jpeg" class="d-block w-100" alt="Tolkien">
                </div>
                <div class="carousel-item" data-interval="5000">
                    <img src="img/spidermanCarosello.jpg" class="d-block w-100" alt="Spiderman">
                </div>
                <div class="carousel-item" data-interval="5000">
                    <img src="img/becc.png" class="d-block w-100" alt="Pubblicità">
                </div>
                <div class="carousel-item" data-interval="5000">
                    <img src="img/offertaCarosello.jpg" class="d-block w-100" alt="Offerta">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" data-bs-target="#carouselExample" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" data-bs-target="#carouselExample" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
        <!-- Fine del carosello -->

        <div id="contenuto" class="container mt-4">
            <div class="row">
                <%
                    @SuppressWarnings("unchecked")
                    Collection<Product> prodotti = (Collection<Product>) request.getAttribute("prodotti");

                    if (prodotti == null || prodotti.isEmpty()) {
                        response.sendRedirect("HomePage");
                        return;
                    } else {
                        for (Product p : prodotti) {
                %>
                            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="product card">
                                    <div class="card-body">
                                        <h2 class="card-title h5"><%= EscaperHTML.escapeHTML(p.getNome()) %></h2>
                                        <p class="card-text product-description" data-full-description="<%= EscaperHTML.escapeHTML(p.getDescrizione()) %>"></p>
                                        <p class="card-text">Prezzo: <%= p.getPrezzo() %> EUR</p>
                                        <p class="card-text">Quantità disponibile: <%= p.getQuantita() %></p>
                                        <a href="ProductDetails?productId=<%= p.getId() %>&type=<%= p.getClass().getSimpleName().toLowerCase() %>">
                                            <img id="productImage" src="<%= p.getImgURL() %>" class="img-fluid">
                                        </a>
                                        <form action="CartControl" method="post" class="mt-2">
                                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                                            <input type="hidden" name="type" value="<%= p.getClass().getSimpleName().toLowerCase() %>">
                                            <input type="hidden" name="action" value="aggiungi">
                                            <input type="hidden" name="redirect" value="HomePage">
                                            <input type="submit" value="Aggiungi al carrello" class="btn btn-primary">
                                        </form>
                                        <hr>
                                        <form action="WishlistControl" method="post" class="mt-2">
                                            <input type="hidden" name="productId" value="<%= p.getId() %>">
                                            <input type="hidden" name="type" value="<%= p.getClass().getSimpleName().toLowerCase() %>">
                                            <input type="hidden" name="action" value="aggiungi">
                                            <input type="hidden" name="redirect" value="HomePage">
                                            <button class="bookmark btn btn-outline-warning" type="submit">
                                                <img src="img/bookmark.png" alt="Bookmark">
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                <%
                        }
                    }
                %>
            </div>
        </div>

        <%@ include file="template/footer.jsp" %>

        
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                const maxLength = 25; // Lunghezza massima della descrizione
                const descriptions = document.querySelectorAll('.product-description');
                
                descriptions.forEach(description => {
                    const fullText = description.getAttribute('data-full-description');
                    if (fullText.length > maxLength) {
                        const truncatedText = fullText.substring(0, maxLength) + '...';
                        description.innerHTML = truncatedText + ' <a href="#" class="read-more">Di più</a>';
                    } else {
                        description.textContent = fullText;
                    }
                });

                document.addEventListener('click', function(event) {
                    if (event.target.classList.contains('read-more')) {
                        event.preventDefault();
                        const description = event.target.parentElement;
                        const fullText = description.getAttribute('data-full-description');
                        description.innerHTML = fullText;
                    }
                });
            });
        </script>
        
		   <script>
		        $('#carouselExample').on('slide.bs.carousel', function (event) {
		    var $e = $(event.relatedTarget);
		    var idx = $e.index();
		    var itemsPerSlide = 1;
		    var totalItems = $('.carousel-item').length;
		
		    if (idx >= totalItems - (itemsPerSlide - 1)) {
		        var it = itemsPerSlide - (totalItems - idx);
		        for (var i = 0; i < it; i++) {
		            if (event.direction == "left") {
		                $('.carousel-item').eq(i).appendTo('.carousel-inner');
		            } else {
		                $('.carousel-item').eq(0).appendTo('.carousel-inner');
		            }
		        }
		    }
		});
		
		$('#carouselExample').on('slid.bs.carousel', function () {
		    $('.carousel-item').css('transition', 'none');
		    setTimeout(function() {
		        $('.carousel-item').css('transition', 'transform 0.5s ease-in-out');
		    }, 0);
		});
		</script>
    </body>
</html>
