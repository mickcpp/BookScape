<%@ page import="java.util.Collection" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="net.bookscape.model.Cart, net.bookscape.model.CartItem, utility.EscaperHTML"%>
<html>
<head>
    <title>Carrello</title>
    <link rel="stylesheet" href="css/feedback.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="js/scriptFeedback.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            margin-top: -50px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-top: 0;
            margin-bottom: 7px;
            font-size: 2em;
        }
        #cart-items {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .product {
            margin: 20px;
            padding: 10px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 200px;
        }
        .product img {
            width: 100%;
            height: 200px; /* Altezza fissa per le immagini */
            object-fit: contain; /* Adatta l'immagine senza distorcerla */
            border-radius: 8px;
        }
        .product-info {
            margin-top: 10px;
        }
        .product-info p {
            margin: 5px 0;
        }
        .checkout-btn {
            display: block;
            margin: 0px auto 20px auto;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            font-size: 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .checkout-btn:hover {
            background-color: #0056b3;
        }
        .footer {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
            position: fixed;
            bottom: 0;
            width: 100%;
        }
        #logout {
            position: absolute;
            margin-left: 5%;
            top: 138px;
            padding-bottom: 10px;
            font-size: 18px;
        }
        #searchbar-section {
            display: none;
        }
        .empty-cart-msg {
            text-align: center;
            font-size: 1.2em;
            color: #555;
            margin-top: 20px;
        }
    </style>
</head>
<body>
   <%@ include file="template/navbar.jsp" %>
   
    <%
        String id = (String) session.getAttribute("cliente");
        if(id != null && !id.equals("")){
    %>
            <a id="logout" href="Logout" class="btn btn-danger">Logout</a>
    <%
        }
        
        String feedback = (String) request.getAttribute("feedback");
        String feedbackNegativo = (String) request.getAttribute("feedback-negative");
    %>
        
    <%@ include file="template/feedbackSection.jsp" %>
    
    <div class="container mt-5">
        <h1>Prodotti nel Carrello</h1>
        <div id="cart-items" class="row">
            <% 
                Cart carrello = (Cart)request.getSession().getAttribute("cart");
                if(carrello != null){
                    Collection<CartItem> items = carrello.getItems();
                    if (items != null && !items.isEmpty()) {
            %>
            <%
                        for (CartItem item : items) {
            %>
                            <div class="product col-lg-3 col-md-4 col-sm-6 mb-4">
                                <div class="card h-100">
                                    <a href="ProductDetails?productId=<%=item.getProduct().getId()%>&type=<%=item.getProduct().getClass().getSimpleName().toLowerCase()%>">
                                        <img src="<%=item.getProduct().getImgURL()%>" class="card-img-top" alt="<%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %>">
                                    </a>
                                    <div class="card-body">
                                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %></h5>
                                        <p class="card-text"><strong>Prezzo:</strong> <%= item.getProduct().getPrezzo() %> EUR</p>
                                        <p class="card-text"><strong>Quantità:</strong> <%= item.getNumElementi() %></p>
                                        <p class="card-text"><strong>Prezzo totale:</strong> <%= item.getTotalCost() %> EUR</p>
                                        <form action="CartControl" method="post">
                                            <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                            <input type="hidden" name="type" value="<%= item.getProduct().getClass().getSimpleName().toLowerCase() %>">
                                            <input type="hidden" name="redirect" value="Cart.jsp">
                                            <div class="form-group">
                                                <input type="number" class="form-control" name="quantity" value="<%= item.getNumElementi() %>" min="1" max="10">
                                            </div>
                                            <button type="submit" name="action" value="Aggiorna" class="btn btn-primary btn-block">Aggiorna</button>
                                            <button type="submit" name="action" value="Rimuovi" class="btn btn-danger btn-block">Rimuovi</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
            <%  
                        }
                    } else { 
            %>      
                        <p class="empty-cart-msg">Il carrello è vuoto.</p>
            <%          }
                } else { 
            %>      
                    <p class="empty-cart-msg">Il carrello è vuoto.</p>
            <%  }  %>
            
        </div>
        
        <%
            if(carrello != null && !carrello.getItems().isEmpty()){
        %>
            <button class="checkout-btn btn btn-primary" onclick="location.href='OrderControl?action=checkout';">Procedi all'acquisto</button>
        <%
            }
        %>
    </div>
    
    <%@ include file="template/footer.jsp" %>
    
    
</body>
</html>
