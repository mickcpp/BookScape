<%@ page import="java.util.Collection, java.util.Iterator" contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Wishlist, utility.EscaperHTML"%>

<html>
<head>
    <title>Wishlist</title>
    <link rel="stylesheet" href="css/style.css">
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
            margin-top: -30px;
            margin-bottom: 24px;
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
            margin-top: 0px;
        }
        .wishlist-items {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .product {
            margin: 20px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 200px;
        }
        .product img {
            width: 100%;
            height: 200px;
            border-radius: 8px;
            object-fit: contain;
        }
        .product-info p {
            margin: 5px 0;
        }
        .action-buttons {
            margin-top: 10px;
        }
        .action-buttons form {
            margin: 5px 0px;
        }
        .action-buttons input[type="submit"] {
            border: 1px solid grey;
            padding: 4px 7px;
            text-align: center;
            text-decoration: none;
            font-size: 15px;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .action-buttons input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .empty-wishlist-msg {
            text-align: center;
            margin-top: 20px;
            color: #666;
        }
        .logout {
            position: absolute;
            margin-left: 5%;
            top: 138px;
            padding-bottom: 10px;
            font-size: 18px;
        }
        @media screen and (max-width: 768px) {
            .product {
                width: 45%;
            }
        }
        @media screen and (max-width: 576px) {
            .product {
                width: 100%;
            }
        }
        #searchbar-section {
            display: none;
        }
    </style>
</head>
<body>
    <%@ include file="template/navbar.jsp" %>
    
    <a class="logout btn btn-danger" href="Logout">Logout</a>

    <%
        String feedback = (String) request.getAttribute("feedback");
        String feedbackNegativo = (String) request.getAttribute("feedback-negative");
    %>
      
    <%@ include file="template/feedbackSection.jsp" %>
    
    <div class="container mt-5">
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

        <h1>Prodotti nella Wishlist</h1>
        <div class="wishlist-items row">
            <%
                if (wishlist != null) {
                    Collection<Product> products = wishlist.getItems();
                    if (products != null && !products.isEmpty()) {
                        Iterator<Product> iterator = products.iterator();
                        while (iterator.hasNext()) {
                            Product product = iterator.next();
            %>
            <div class="product col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card h-100">
                    <a href="ProductDetails?productId=<%=product.getId()%>&type=<%=product.getClass().getSimpleName().toLowerCase()%>">
                        <img src="<%=product.getImgURL()%>" class="card-img-top" alt="<%= EscaperHTML.escapeHTML(product.getNome()) %>">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><%= EscaperHTML.escapeHTML(product.getNome()) %></h5>
                        <p class="card-text"><strong>Prezzo:</strong> <%= product.getPrezzo() %> EUR</p>
                        <div class="action-buttons">
                            <form action="CartControl" method="post">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <input type="hidden" name="type" value="<%= product.getClass().getSimpleName().toLowerCase() %>">
                                <input type="hidden" name="action" value="aggiungi">
                                <input type="hidden" name="redirect" value="Wishlist.jsp">
                                <input type="submit" value="Aggiungi al carrello" class="btn btn-primary btn-block">
                            </form>
                            <form action="WishlistControl" method="post">
                                <input type="hidden" name="productId" value="<%= product.getId() %>">
                                <input type="hidden" name="type" value="<%= product.getClass().getSimpleName().toLowerCase() %>">
                                <input type="hidden" name="redirect" value="Wishlist.jsp">
                                <input type="submit" name="action" value="Rimuovi" class="btn btn-danger btn-block">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                        }
                    } else {
            %>
            <p class="empty-wishlist-msg">Nessun prodotto nella Wishlist.</p>
            <%
                    }
                } else {
            %>
            <p class="empty-wishlist-msg">Nessun prodotto nella Wishlist.</p>
            <%
                }
            %>
        </div>
    </div>
    
    <%@ include file="template/footer.jsp" %>
    
    
</body>
</html>
