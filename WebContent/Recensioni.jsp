<%@ page import="net.bookscape.model.Recensione, net.bookscape.model.*, java.util.*, java.text.SimpleDateFormat" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.util.ListIterator, java.util.UUID"%>
<%@ page import="utility.EscaperHTML" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.concurrent.TimeUnit, java.util.UUID"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Recensioni</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/recensioni.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="icon" href="img/logo.png" type="image/x-icon">
    <jsp:include page="header.jsp" />
</head>
<body>
    <%@ include file="template/navbar.jsp" %>
    <%
        String id = (String) session.getAttribute("cliente");

        @SuppressWarnings("unchecked")
        List<Recensione> recensioni = (List<Recensione>) request.getAttribute("recensioni");
        Product prodotto = (Product) request.getAttribute("prodotto");
        
        if(prodotto == null || recensioni == null){
            response.sendRedirect("./");
            return;
        }
    %>
    
    <%!
        // funzione per formattare la data
        String formatTimeAgo(Calendar date) {
            long durationInMillis = new Date().getTime() - date.getTimeInMillis();
            long minutes = TimeUnit.MILLISECONDS.toMinutes(durationInMillis);
            long hours = TimeUnit.MILLISECONDS.toHours(durationInMillis);
            long days = TimeUnit.MILLISECONDS.toDays(durationInMillis);
            
            if (minutes < 60) {
                if(minutes == 1){
                    return minutes + " minuto fa";
                }
                return minutes + " minuti fa";
            } else if (hours < 24) {
                if(hours == 1){
                    return hours + " ora fa";
                }
                return hours + " ore fa";
            } else if (days < 7) {
                if(days == 1){
                    return days + " giorno fa";
                }
                return days + " giorni fa";
            } else {
                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                return sdf.format(date.getTime());
            }
        }
    %>
    
    <%
	    CsrfTokens csrfTokens = (CsrfTokens) session.getAttribute("csrfTokens");
	    
	    if (csrfTokens == null) {
	        csrfTokens = new CsrfTokens();
	    }
	
	    // Genera un nuovo token
	    String csrfToken = UUID.randomUUID().toString();
	    csrfTokens.addToken(csrfToken);
	    session.setAttribute("csrfTokens", csrfTokens);
    %>

    <div class="container my-4">
        <div class="row">
            <div class="col-lg-9">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title mb-3">Recensioni</h3>
                        <%
                            if (recensioni != null && !recensioni.isEmpty()) {
                                int num = 0;
                                for (Recensione recensione : recensioni) {
                                    String email = recensione.getCliente();
                                    String initials = email.substring(0, 1).toUpperCase();
                        %>
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="d-flex align-items-center mb-3">
                                    <div class="avatar me-2" data-email="<%= EscaperHTML.escapeHTML(email) %>"><%= initials %></div>
                                    <h5 id="emailRecensione" class="h5 mb-0"><%= EscaperHTML.escapeHTML(recensione.getCliente()) %></h5>
                                </div>
                                <p class="card-text mb-2"><%= EscaperHTML.escapeHTML(recensione.getRecensione()) %></p>
                                
                                <div class="rating text-start">
                                    <% 
                                        for (int i = 0; i < recensione.getValutazione(); i++) { 
                                    %>
                                            <i class="fas fa-star"></i>
                                    <%
                                        } 
                                    %>
                                </div>
                                <small><%= formatTimeAgo(recensione.getData()) %></small>
                                
                                <% 
                                    if (recensione.getCliente().equals(id)) { // Mostra il pulsante solo se è la recensione del cliente autenticato
                                %>
                                <form action="RecensioneControl" method="post" style="float: right">
                                	<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="productId" value="${prodotto.getId()}">
                                    <input type="hidden" name="type" value="${prodotto.getClass().getSimpleName().toLowerCase()}">
                                    <button id="deleteRecensione" type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer;">Elimina Recensione</button>
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
                        <p class="text-muted">Ancora nessuna recensione.</p>
                        <%
                        }
                        %>
                    </div>
                </div>
            </div>
            <div id="productDetails" class="col-lg-3 text-center mt-4 mt-sm-3">
                <a href="ProductDetails?productId=<%=prodotto.getId()%>&type=<%=prodotto.getClass().getSimpleName().toLowerCase()%>">
                    <img src="<%= EscaperHTML.escapeHTML(prodotto.getImgURL()) %>" alt="<%= EscaperHTML.escapeHTML(prodotto.getNome())%>" width="50%">
                </a>
                <h2><%= EscaperHTML.escapeHTML(prodotto.getNome()) %></h2>
                <p>ID: <%= prodotto.getId() %></p>
            </div>
        </div>
    </div>

    <%@ include file="template/footer.jsp"%>

    <script>
        function stringToColor(str) {
            let hash = 0;
            for (let i = 0; i < str.length; i++) {
                hash = str.charCodeAt(i) + ((hash << 5) - hash);
            }
            let color = '#';
            for (let i = 0; i < 3; i++) {
                let value = (hash >> (i * 8)) & 0xFF;
                color += ('00' + value.toString(16)).substr(-2);
            }
            return color;
        }

        document.querySelectorAll('.avatar').forEach(function(avatar) {
            let email = avatar.getAttribute('data-email');
            let color = stringToColor(email);
            avatar.style.backgroundColor = color;
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
