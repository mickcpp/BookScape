<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/">
    <link rel="stylesheet" href="css/navStyle.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        #choiceModal {
            position: fixed;
            top: 45%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.3);
            z-index: 1000; /* Ensures it is above other elements */
            display: none; /* Hidden by default */
            text-align: center;
            width: 80%;
            max-width: 400px;
            overflow: hidden;
            background: linear-gradient(145deg, #ffffff, #f0f0f0);
            opacity: 0; /* Inizialmente nascosto */
    		transition: opacity 0.2s ease;
        }
        #modalOverlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none; /* Hidden by default */
            z-index: 1000;
            opacity: 0; /* Inizialmente nascosto */
    		transition: opacity 0.5s ease; /* Aggiunge una transizione graduale */
        }
        
        body.blurred #zona_utente, 
        body.blurred nav,
        body.blurred #contenuto,
       	body.blurred .container{
            filter: blur(5px);
        }
        
        .modal-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-section {
		    flex: 1;
		    text-align: center;
		    padding: 20px;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease; /* Aggiunta transizione per box-shadow */
		    display: flex;
		    flex-direction: column;
		    align-items: center;
		    justify-content: center;
		    color: #007bff; /* Cambia il colore delle icone */
		    background-color: #f8f9fa; /* Colore di sfondo base */
		}
		.modal-section:hover {
		    background-color: #dce4eb; /* Colore di sfondo al passaggio del mouse */
		    border-radius: 12px; /* Aumentato il raggio per bordi più arrotondati */
		    cursor: pointer;
		    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Effetto di ombra al passaggio del mouse */
		}
        .modal-section i {
            font-size: 50px;
            margin-bottom: 10px;
        }
        .modal-section p {
            margin: 0;
            font-size: 18px;
            font-weight: bold;
            color: #333; /* Cambia il colore del testo */
        }
        .divider {
            height: 80px;
            width: 2px;
            background-color: #ccc;
        }
    </style>
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
        <%
            if(request.getSession().getAttribute("adminRole") != null){
         %>
                <a href="javascript:void(0)" id="adminLink" onclick="showModal()"><img src="img/user.png" alt="" width="25px" height="25px"></a>
         <%
            } else{
         %>
                <a href="UserControl"><img src="img/user.png" alt="" width="25px" height="25px"></a>
         <%
            }
        %>
        </div>
    </div>

    <div id="modalOverlay"></div>
    <div id="choiceModal">
        <div class="modal-content">
            <div class="modal-section" onclick="window.location.href='UserControl?personalAreaAdmin=true'">
                <i class="fas fa-user-circle"></i>
                <p>Area Personale</p>
            </div>
            <div class="divider"></div>
            <div class="modal-section" onclick="window.location.href='UserControl'">
                <i class="fas fa-chart-line"></i>
                <p>Dashboard</p>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function(){
            // Funzione per gestire la barra di ricerca
            $("#searchbar").keyup(function(){
                var query = $("#searchbar").val();
                if(query != ""){
                    $.get("./RicercaProdotto", {"query": query}, function(data){
                        if(data != ""){
                            $(".risultati").empty().css({"display" : "block"});
                            $.each(data, function(i, product) {
                                var type = "gadget"; // Valore predefinito
        
                                if (product.numeroTracce !== null && product.numeroTracce !== undefined) {
                                    type = "musica";
                                } else if (product.numeroPagine !== null && product.numeroPagine !== undefined) {
                                    type = "libro";
                                }
        
                                var productElement = "<div id='product-r' class='product' data-id='" + product.ID + "' data-type='" + type + "'>" +
                                                     "<p id='name'>" + product.nome + "</p>" +
                                                     "<img id='pic' width='65' height='65' src='" + product.imgURL + "'/>" +
                                                     "</div>";
        
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

            // Funzione per gestire il click al di fuori della searchbar
            $(document).on('click', function(event) {
                if (!$(event.target).closest('#searchbar-section').length) {
                    $(".risultati").css({"display" : "none"});
                }
            });
        });

        function showModal() {
            document.body.classList.add("blurred");
            var modalOverlay = document.getElementById("modalOverlay");
            var choiceModal = document.getElementById("choiceModal");

            modalOverlay.style.display = "block";
            choiceModal.style.display = "block";

            setTimeout(function() {
                modalOverlay.style.opacity = "1";
                choiceModal.style.opacity = "1";
            }, 10); // Ritardo minimo per assicurarsi che le transizioni siano applicate correttamente
        }

        function hideModal() {
            document.body.classList.remove("blurred");
            var modalOverlay = document.getElementById("modalOverlay");
            var choiceModal = document.getElementById("choiceModal");

            choiceModal.style.opacity = "0";

            setTimeout(function() {
                modalOverlay.style.opacity = "0";
            }, 10); // Ritardo minimo per assicurarsi che le transizioni siano applicate correttamente

            setTimeout(function() {
                choiceModal.style.display = "none";
                modalOverlay.style.display = "none";
            }, 300); // Chiusura più veloce, quindi ritardo minore
        }

        // Gestione del click sull'overlay per chiudere il modal
        document.getElementById("modalOverlay").addEventListener("click", function() {
            hideModal();
        });


        // Funzione per gestire il click sull'overlay per chiudere il modale
        $(document).on('click', '#modalOverlay', function() {
            hideModal();
        });
    </script>
</body>
</html>