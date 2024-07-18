<%@ page import="net.bookscape.model.Recensione, net.bookscape.model.*, java.util.*, java.text.SimpleDateFormat" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.util.ListIterator, java.util.UUID"%>
<%@ page import="utility.EscaperHTML" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.concurrent.TimeUnit"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="utf-8">
   	<meta name="viewport" content="width=device-width, initial-scale=1">
   	<title>Recensioni</title>
   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: 27px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 7px;
        }

		.section-menu {
			display: none;
		}
		
        h1 {
            text-align: center;
            color: #333;
            margin: 0.8% 1% 0% 1%;
        }

        .content {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
        }

        .product-details {
            width: 30%;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            margin: auto;
        }

        .product-details img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            margin-bottom: 15px;
            border-radius: 10px;
        }

        .product-details h2 {
            margin: 0 0 10px;
            color: #333;
            font-size: 20px;
        }

        .product-details p {
            color: #666;
            margin: 5px 0;
        }

        .review-display {
            width: 65%;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            text-align: left;
        }

        .review-display .review {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 10px 0;
        }

        .review-display .review:last-child {
            border-bottom: none;
        }

        .review-display .avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
            margin-right: 15px;
            text-transform: uppercase;
        }

        .review-display .review-content {
            flex: 1;
        }

        .review-display .review-content h4 {
            margin: 0 0 5px;
            font-size: 18px;
            color: #333;
        }

        .review-display .review-content p {
            margin: 5px 0;
            color: #666;
        }

        .review-display .review-content .rating {
            color: #f5a623;
            font-size: 16px;
        }

        #logout {
            position: absolute;
            margin-left: 4%;
            top: 138px;
            padding-bottom: 10px;
            font-size: 18px;
        }
        
        .review-display .review-content small {
	        color: #999;
	        font-size: 14px;
	        margin-top: 5px;
	        display: inline-block;
	    }
    </style>
</head>
<body>
    <%@ include file="template/navbar.jsp" %>
    <%
        String id = (String) session.getAttribute("cliente");
        if(id != null && !id.equals("")) {
    %>
        <a id="logout" href="Logout">Logout</a>
    <%
        }

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

    <div class="container">
        <div class="content">
            <div class="review-display">
                <h2>Recensioni dei Clienti</h2>
                <%
                    if (recensioni != null && !recensioni.isEmpty()) {
                        for (Recensione recensione : recensioni) {
                            String email = recensione.getCliente();
                            String initials = email.substring(0, 1).toUpperCase();
                %>
                            <div class="review">
                                <div class="avatar" data-email="<%= email %>"><%= initials %></div>
                                <div class="review-content">
                                    <h4><%= EscaperHTML.escapeHTML(email) %></h4>
                                    <div class="rating">
                                        <% 
                                            for (int i = 0; i < recensione.getValutazione(); i++) { 
                                        %>
                                                <i class="fas fa-star"></i>
                                        <%
                                            } 
                                        %>
                                    </div>
                                    <p><%= EscaperHTML.escapeHTML(recensione.getRecensione()) %></p>
                                    <small><%= formatTimeAgo(recensione.getData()) %></small>
                                </div>
                            </div>
                <%
                        }
                    } else {
                %>
                        <p>Nessuna recensione disponibile.</p>
                <%
                    }
                %>
            </div>

            <div class="product-details">
            	<a href="ProductDetails?productId=<%=prodotto.getId()%>&type=<%=prodotto.getClass().getSimpleName().toLowerCase()%>">
            		<img src="<%= EscaperHTML.escapeHTML(prodotto.getImgURL()) %>" alt="<%= EscaperHTML.escapeHTML(prodotto.getNome())%>">
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
