<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.*"%>
<%@ page import="java.util.*" %>
<%@ page import="utility.EscaperHTML"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.concurrent.TimeUnit"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettagli Prodotto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/feedback.css">
    <script src="js/scriptFeedback.js"></script>
     
    <style>
        .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            text-transform: uppercase;
        }
        .error-message {
            color: #e74c3c;
            font-size: 0.9em;
            margin: -10px 8px 1.55% auto;
            text-align: right;
            display: none;
        }
        .rating input {
            display: none;
            direction: rtl;
        }
        .rating label {
            color: #ddd;
            font-size: 20px;
            cursor: pointer;
            transition: color 0.2s;
        }
        .rating input:checked ~ label,
        .rating label:hover,
        .rating label:hover ~ label {
            color: #f5a623;
            
        }
        .logout {
            position: absolute;
            margin-left: 5%;
            top: 138px;
            padding-bottom: 10px;
            font-size: 18px;
        }
        .rating{
        	
        }
    </style>
</head>
<body>
    <%@ include file="template/navbar.jsp" %>
    <%
        String id = (String) session.getAttribute("cliente");
        if (id != null && !id.equals("")) {
    %>
         <a class="logout btn btn-danger" href="Logout">Logout</a>
    <%
        }
    %>
    <%
        if (request.getAttribute("prodotto") == null) {
            response.sendRedirect("./");
            return;
        }
    
        String errorMessage = (String) request.getAttribute("errorMessage");
        String feedback = (String) request.getAttribute("feedback");
        String feedbackNegativo = (String) request.getAttribute("feedback-negative");
    
        @SuppressWarnings("unchecked")
        List<Recensione> recensioni = (List<Recensione>) request.getAttribute("recensioni");
    
        if (id != null && !id.isEmpty()) {
            Recensione clienteReview = null;
            Iterator<Recensione> iter = recensioni.iterator();
            while (iter.hasNext()) {
                Recensione recensione = iter.next();
                if (recensione.getCliente().equals(id)) {
                    clienteReview = recensione;
                    iter.remove();
                    break;
                }
            }
            if (clienteReview != null) {
                recensioni.add(0, clienteReview);
            }
        }
    %>

    <%!
        String formatTimeAgo(Calendar date) {
            long durationInMillis = new Date().getTime() - date.getTimeInMillis();
            long minutes = TimeUnit.MILLISECONDS.toMinutes(durationInMillis);
            long hours = TimeUnit.MILLISECONDS.toHours(durationInMillis);
            long days = TimeUnit.MILLISECONDS.toDays(durationInMillis);

            if (minutes < 60) {
                if (minutes == 1) {
                    return minutes + " minuto fa";
                }
                return minutes + " minuti fa";
            } else if (hours < 24) {
                if (hours == 1) {
                    return hours + " ora fa";
                }
                return hours + " ore fa";
            } else if (days < 7) {
                if (days == 1) {
                    return days + " giorno fa";
                }
                return days + " giorni fa";
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                return sdf.format(date.getTime());
            }
        }
    %>

    <%@ include file="template/feedbackSection.jsp" %>

    <div class="container my-4">
        <div class="row">
            <div class="col-md-6">
                <img src="${prodotto.imgURL}" alt="Immagine Prodotto" class="img-fluid rounded">
            </div>
            <div class="col-md-6">
                <h2>${EscaperHTML.escapeHTML(prodotto.nome)}</h2>
                <p>${EscaperHTML.escapeHTML(prodotto.descrizione)}</p>
                <p>Prezzo: ${prodotto.prezzo}</p>
                <p>Disponibilità: ${prodotto.quantita}</p>
                <form action="CartControl" method="post">
                    <input type="hidden" name="productId" value="${prodotto.getId()}">
                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
                    <input type="hidden" name="action" value="aggiungi">
                    <input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
                    <button class="btn btn-success">Aggiungi al carrello</button>
                </form>
                <hr>
                <form action="WishlistControl" method="post">
                    <input type="hidden" name="productId" value="${prodotto.getId()}">
                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
                    <input type="hidden" name="action" value="aggiungi">
                    <input type="hidden" name="redirect" value="ProductDetails?productId=${prodotto.getId()}&type=${prodotto.getClass().getSimpleName().toLowerCase()}">
                    <button class="btn btn-outline-warning"><i class="far fa-bookmark"></i> Aggiungi alla lista desideri</button>
                </form>
            </div>
        </div>
    </div>
    
    <div class="container my-4">
        <div class="card">
            <div class="card-body">
                <h3 class="card-title">Scrivi una Recensione</h3>
                <div class="text-danger"><%=errorMessage == null ? "" : errorMessage%></div>
                <form action="RecensioneControl" method="post" onsubmit="return validateForm()">
                    <input type="hidden" name="action" value="insert">
                    <input type="hidden" name="productId" value="${prodotto.getId()}">
                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
                    <div class="rating">
                        <input type="radio" name="rating" id="star5" value="5">
                        <label for="star5" class="fas fa-star"></label>
                        <input type="radio" name="rating" id="star4" value="4">
                        <label for="star4" class="fas fa-star"></label>
                        <input type="radio" name="rating" id="star3" value="3">
                        <label for="star3" class="fas fa-star"></label>
                        <input type="radio" name="rating" id="star2" value="2">
                        <label for="star2" class="fas fa-star"></label>
                        <input type="radio" name="rating" id="star1" value="1">
                        <label for="star1" class="fas fa-star"></label>
                        <div class="text-danger"></div>
                    </div>
                    <div class="mb-3">
                        <textarea id="recensione" name="recensione" class="form-control" placeholder="Scrivi qui la tua recensione..."></textarea>
                        <div class="text-danger"></div>
                    </div>
                    <button type="submit" class="btn btn-success">Invia Recensione</button>
                </form>
            </div>
        </div>
    </div>
    
    
    <div class="container my-4">
        <div class="card">
            <div class="card-body">
                <h3 class="card-title">Recensioni</h3>
                <%
                    if (recensioni != null && !recensioni.isEmpty()) {
                    	int num=0;
                        for (Recensione recensione : recensioni) {
                        	if (num == 4) break;
                %>
                <div class="card mb-3">
                    <div class="card-body">
                        <div class="d-flex align-items-center mb-3">
                            <div class="avatar bg-primary text-white mr-3">
                                <%= recensione.getCliente().charAt(0) %>
                            </div>
                            <h5 class="mb-0"><%= recensione.getCliente() %></h5>
                        </div>
                        <p class="card-text"><%= EscaperHTML.escapeHTML(recensione.getRecensione()) %></p>
                        <div class="d-flex align-items-center">
                            <div class="rating">
                                <%
                                    for (int i = 1; i <= 5; i++) {
                                        if (i <= recensione.getValutazione()) {
                                            out.print("<i class='fas fa-star text-warning'></i>");
                                        } else {
                                            out.print("<i class='far fa-star text-secondary'></i>");
                                        }
                                    }
                                %>
                            </div>
                            <p class="ml-auto mb-0"><%= formatTimeAgo(recensione.getData()) %></p>
                        </div>
                        <% 
	                                if (recensione.getCliente().equals(id)) { // Mostra il pulsante solo se è la recensione del cliente autenticato
	                            %>
	                                <form action="RecensioneControl" method="post" style="float: right">
	                                    <input type="hidden" name="action" value="delete">
	                                    <input type="hidden" name="productId" value="${prodotto.getId()}">
	                                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
	                                    <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Elimina Recensione</button>
	                                </form>
                       	<%
                                }
                      	%>
                    </div>
                </div>
                <%
                	num++;
                        }
                    } else {
                %>
                <p class="text-muted" >Ancora nessuna recensione.</p>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    
    <%@ include file="template/footer.html" %>
</body>
</html>
