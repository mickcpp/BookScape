<%@ page import="net.bookscape.model.Recensione, net.bookscape.model.*, java.util.*, java.text.SimpleDateFormat" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.util.ListIterator, java.util.UUID"%>
<%@ page import="utility.EscaperHTML" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Recensioni</title>
  	<link rel="stylesheet" href="css/style.css">
  	
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

        h1 {
            text-align: center;
            color: #333;
            margin: 0.8% 1% 0% 1%;
        }

        .ordine {
            border-bottom: 1px solid #ccc;
            padding: 10px 0;
            margin-bottom: 10px;
        }

        .ordine h2 {
            color: #333;
        }

        .ordine p {
            color: #666;
        }

        .product-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            margin-right: 10px;
        }

        ul {
            list-style-type: none;
            padding: 0;
        }

        li {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        li p {
            margin: 0;
            color: #333;
        }
        
        #logout {
            position: absolute;
            margin-left: 4%;
            top: 138px;
            padding-bottom: 10px;
            font-size: 18px;
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
    %>
    <div class="container">
    <h1>Le Recensioni</h1>
    <%@ page import="utility.EscaperHTML" %>
    <%
        @SuppressWarnings("unchecked")
        Collection<Recensione> recensioni = (Collection<Recensione>) request.getAttribute("recensioni");
    
        if (recensioni == null || recensioni.isEmpty()) {
            %>
            <p>Non ci sono recensioni disponibili per questo prodotto.</p>
            <%
        } else {
            for (Recensione r : recensioni) {
                %>
                <div class="review">
                    <h4><%= EscaperHTML.escapeHTML(r.getCliente()) %></h4>
                    <p><%= EscaperHTML.escapeHTML(r.getRecensione()) %></p>
                    <p class="rating"><%= r.getValutazione() %> <i class="fas fa-star"></i></p>
                </div>
                <%
            }
        }
    %>
</div>

    <%@ include file="template/footer.html" %>
   
    
</body>
</html>
