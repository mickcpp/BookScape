<!DOCTYPE html>
<html>
<head>
    <base href="${pageContext.request.contextPath}/">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <style>
        .risultati {
            position: absolute;
            left: 0;
            top: 100%;
            width: 100%;
            background-color: white;
            border: 1px solid silver;
            border-radius: 0.25rem;
            display: none;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 10000;
            overflow-x: hidden;
            max-height: 400px;
            overflow-y: auto;
            transition: opacity 0.3s ease, transform 0.3s ease;
        }

        .risultati.show {
            display: block;
        }

        .risultati .product {
            display: flex;
            align-items: center;
            padding: 10px;
            cursor: pointer;
            width: 100%;
            border: 0.3px solid rgba(0, 0, 0, 0.3);
            transition: background-color 0.3s ease;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.15);
            border-radius: 0;
        }

        .risultati .product img {
            width: auto;
            margin-right: 2%;
        }

        .risultati .product #name {
            flex: 1;
            font-size: 16px;
            color: #333;
        }

        .risultati .product:hover {
            background-color: #f0f0f0;
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
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: #007bff;
            background-color: #f8f9fa;
        }

        .modal-section:hover {
            background-color: #dce4eb;
            border-radius: 12px;
            cursor: pointer;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .modal-section i {
            font-size: 50px;
            margin-bottom: 10px;
        }

        .modal-section p {
            margin: 0;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .divider {
            height: 80px;
            width: 2px;
            background-color: #ccc;
        }

        .blurred #zona_utente, 
        .blurred nav,
        .blurred #contenuto,
        .blurred .container {
            filter: blur(5px);
        }

        .icon-hover {
            position: relative;
            display: inline-block;
        }

        .icon-hover::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: -5px;
            height: 2px;
            width: 0;
            background-color: blue;
            transition: width 0.3s, left 0.3s;
            
        }

        .icon-hover:hover::after {
            width: 100%;
            left: 0;
            
        }

        #icon-links a {
            color: rgba(9, 23, 91, 1);
            text-decoration: none;
            margin: 0 10px;
            font-weight: bold;
        }
        #icon-links a:hover{
        	color: rgba(34, 19, 19, 0.6);
        }
        #links ul a:hover {
    		background-color: #89B9E3;
		}
		#navbarNav ul a:hover{
			background-color: #89B9E3;
		}
		.navbarBlue{
			background-color : rgba(9, 23, 91, 1);
		}
		.iconBlue{
			color : rgba(9, 23, 91, 1);
		}
		#divider-row{
			border-top: double 2px #CCC;
		}
        
    </style>
</head>
<body>

	 <!--  prima riga -->
    <nav class="navbar navbar-expand-lg navbar-dark navbarBlue">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav mx-auto " >
                <li class="nav-item"><a class="nav-link text-white" href="./">Home</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="contatti.jsp">Contatti</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="negozi.jsp">Negozi</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="punti_ritiro.jsp">Punti di Ritiro</a></li>
                <li class="nav-item"><a class="nav-link text-white" href="eventi.jsp">Eventi</a></li>
                <li class="nav-item"><a class="nav-link text-white mx-4" href="assistenza.jsp">Assistenza Clienti</a></li>
            </ul>
        </div>
    </nav>
    
    
     <!--  seconda riga -->
    <div class="container-fluid navbar-neutral">  
    <div id="zona_utente" class="container my-3 d-flex flex-column align-items-center ">
        <div class="d-flex justify-content-between align-items-center w-100">
            <div>
	            <span id="logo">
	                <a href="./"><img src="img/logo.png" alt="logo" class="img-fluid" style="max-width: 100px;"></a>
	            </span>
	            	
	            <span id="nomeSito"> 
	            	<a href="./"><img src="img/nomeSito.png" alt="Bookscape" class="img-fluid" style="max-width: 250px; "></a>
	            </span>
	        </div>    

            <div id="searchbar-section" class="flex-fill mx-3 position-relative">
                <input id="searchbar" name="search" type="text" class="form-control" autocomplete="off" placeholder="cerca nel catalogo...">
                <div class="risultati"></div>
            </div>

            <div id="icone" class="d-flex">
                <a href="Wishlist.jsp" class="icon mx-2"><img src="img/heart.png" alt="" width="25px" height="25px"></a>
                <a href="Cart.jsp" class="icon mx-2"><img src="img/shopping-cart.png" alt="" width="25px" height="25px"></a>
                <%
                    if(request.getSession().getAttribute("adminRole") != null){
                %>
                        <a href="javascript:void(0)" id="adminLink" class="icon mx-2" onclick="showModal()"><img src="img/user.png" alt="" width="25px" height="25px"></a>
                <%
                    } else {
                %>
                        <a href="UserControl" class="icon mx-2"><img src="img/user.png" alt="" width="25px" height="25px"></a>
                <%
                    }
                %>
            </div>
        </div>
        
        
        <!--  terza riga -->    
        <div id="icon-links" class="d-flex justify-content-center w-100 mt-3 ">
            <a class="icon-hover mx-4" href="Romani.jsp">Romanzi</a>
            <a class="icon-hover mx-4" href="Gialli.jsp">Gialli</a>
            <a class="icon-hover mx-4" href="Horror.jsp">Horror</a>
            <a class="icon-hover mx-4" href="Teen.jsp">Teen</a>
            <a class="icon-hover mx-4" href="Manga.jsp">Manga</a>
            <a class="icon-hover mx-4" href="Classici.jsp">Classici</a>
            <a class="icon-hover mx-4" href="CD.jsp">CD</a>
            <a class="icon-hover mx-4" href="Vinili.jsp">Vinili</a>
            <a class="icon-hover mx-4" href="Gadget.jsp">Gadget</a>
        </div>
        
    </div>
    <hr id="divider-row">
   
   </div> 

    <div id="modalOverlay" class="modal-overlay"></div>
    <div id="choiceModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content p-4">
                <div class="modal-section" onclick="window.location.href='UserControl?personalAreaAdmin=true'">
                    <i class="fas fa-user-shield iconBlue"></i>
                    <p>Area Personale</p>
                </div>
                <div class="divider"></div>
                <div class="modal-section" onclick="window.location.href='UserControl'">
                    <i class="fas fa-chart-line iconBlue"></i>
                    <p>Dashboard</p>
                </div>
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
                            $(".risultati").empty().addClass("show");
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
                    $(".risultati").removeClass("show");
                }
            });

            // Funzione per gestire il click al di fuori della searchbar
            $(document).on('click', function(event) {
                if (!$(event.target).closest('#searchbar-section').length) {
                    $(".risultati").removeClass("show");
                }
            });
        });

        function showModal() {
            $('body').addClass('blurred');
            $('#choiceModal').modal('show');
        }

        function hideModal() {
            $('body').removeClass('blurred');
        }

        $('#choiceModal').on('hidden.bs.modal', function () {
            hideModal();
        });

        $('#modalOverlay').on('click', function() {
            hideModal();
            $('#choiceModal').modal('hide');
        });
    </script>
</body>
</html>
