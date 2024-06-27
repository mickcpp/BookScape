<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="css/navStyle.css">
</head>
<body>
    <nav>
        <div id="links">
            <ul>
                <li><a href="./">Home</a></li>
                <li><a href="contatti.jsp">Contatti</a></li>
                <li><a href="assistenza.jsp">Assistenza clienti</a></li>
            </ul>
        </div>
    </nav>

<div id="zona_utente">
    <div id="logo">
        <a href="./"><img src="img/logo.png" alt="logo" width="100%" height="auto"></a>
    </div>
   
     <div id="searchbar-section">
     	<input id="searchbar" name="search" type="text" placeholder="cerca nel catalogo...">
     	
     	<div class="risultati"></div>
     </div>
     
    <div id="icone">
        <a href="Wishlist.jsp"><img src="img/heart.png" alt="" width="25px" height="25px"></a>
        <a href="Cart.jsp"><img src="img/shopping-cart.png" alt="" width="25px" height="25px"></a>
        <a href="UserControl"><img src="img/user.png" alt="" width="25px" height="25px"></a>
    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    $(document).ready(function(){
        $("#searchbar").keyup(function(){
            var query = $("#searchbar").val();
            if(query != ""){
                $.get("./RicercaProdotto", {"query": query}, function(data){
                    if(data != ""){
                        $(".risultati").empty().css({"display" : "block"});
                        $.each(data, function(i, product) {
                            // Determina il tipo in base alle proprietà del prodotto
                            var type = "gadget"; // Valore predefinito

                            if (product.numeroTracce !== null && product.numeroTracce !== undefined) {
                                type = "musica";
                            } else if (product.numeroPagine !== null && product.numeroPagine !== undefined) {
                                type = "libro";
                            }

                            // Costruzione dell'elemento da aggiungere al DOM
                            var productElement = "<div id='product-r' class='product' data-id='" + product.ID + "' data-type='" + type + "'>" +
                                                 "<p id='name'>" + product.nome + "</p>" +
                                                 "<img id='pic' width='65' height='65' src='" + product.imgURL + "'/>" +
                                                 "</div>";

                            // Aggiunta dell'elemento al contenitore risultati
                            $(".risultati").append(productElement);
                        });
                        $(document).on("click", ".product", function(){
                            var productId = $(this).data('id');
                            console.log(productId);
                            var productType = $(this).data('type');
                            window.location = "./ProductDetails?productId=" + productId + "&type=" + productType;
                        });
                    }
                }).fail(function(){
                    console.error("Error fetching data");
                });
            } else {
                $(".risultati").css({"display" : "none"});
            }
        });
    });
    
    $(document).ready(function(){
        // Funzione per gestire il click al di fuori della searchbar
        $(document).on('click', function(event) {
            if (!$(event.target).closest('#searchbar-section').length) {
                // Chiude i risultati della ricerca se clicchi fuori dalla searchbar
                $(".risultati").css({"display" : "none"});
            }
        });
    });
</script>
</body>
</html>

