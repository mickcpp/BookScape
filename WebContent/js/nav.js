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
    	try{
    		closeModal();
    	} catch(error){}
 
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

    // Funzione per gestire il click sull'overlay per chiudere il modale
    $(document).on('click', '#modalOverlay', function() {
        hideModal();
    });
    