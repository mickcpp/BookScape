<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
	    <base href="${pageContext.request.contextPath}/">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	    <link rel="stylesheet" href="css/navStyle.css">
	</head>
	
	<body>
	    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
		    <div class="container-fluid">
		        <a class="navbar-brand d-flex align-items-center" href="./">
		            <img src="img/logo.png" alt="BookscapeLogo" class="navbar-logo" width="52" height="43" style="filter: brightness(0) invert(1);">
		        </a>
		        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		            <span class="navbar-toggler-icon"></span>
		        </button>
		        <div class="collapse navbar-collapse" id="navbarNav">
		            <ul class="navbar-nav ms-auto me-3">
		                <li class="nav-item">
		                    <a class="nav-link text-white" href="./">Home</a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link text-white" href="contatti.jsp">Contatti</a>
		                </li>
		                <li class="nav-item">
		                    <a class="nav-link text-white" href="assistenza.jsp">Assistenza clienti</a>
		                </li>
		            </ul>
		        </div>
		    </div>
		</nav>

	 	<div id="zona_utente" class="container-sm mt-3">
	        <div class="row align-items-center">
	            <div class="col-lg-4 col-md-4 d-none d-md-block">
	                <a class="navbar-brand" href="./">
	                    <img src="img/nomeSito.png" alt="Bookscape" class="navbar-logo img-fluid">
	                </a>
	            </div>
	            <div class="col-lg-6 col-md-5 col-8">
	                <div id="searchbar-section">
	                    <input id="searchbar" name="search" type="text" class="form-control" autocomplete="off" placeholder="Cerca nel catalogo...">
	                    <div class="risultati"></div>
	                </div>
	            </div>
	            <div class="col-lg-2 col-md-3 col-4 text-end">
	              	<a href="Wishlist.jsp"><img src="img/heart.png" alt="Heart" class="img-fluid me-md-3 me-2" width="25" height="25"></a>
	                <a href="Cart.jsp"><img src="img/shopping-cart.png" alt="Shopping Cart" class="img-fluid me-md-3 me-2" width="25" height="25"></a>
<%
            		if(request.getSession().getAttribute("adminRole") != null){
%>
                		<a href="javascript:void(0)" id="adminLink" onclick="showModal()"><img src="img/user.png" alt="User" class="img-fluid me-md-3 me-1" width="25" height="25"></a>
<%
            		} else{
%>
                		<a href="UserControl"><img src="img/user.png" alt="User" class="img-fluid me-md-3 me-1" width="25" height="25"></a>
<%
            		}
%>
	            </div>
	        </div>
	    </div>
	    
	 	<div class="container mt-4 section-menu">
	        <div id="section-links" class="d-flex justify-content-center flex-wrap">
	            <a class="section-link mx-4" href="bookCatalog.jsp">Romanzi</a>
	            <a class="section-link mx-4" href="bookCatalog.jsp">Gialli</a>
	            <a class="section-link mx-4" href="bookCatalog.jsp">Horror</a>
	            <a class="section-link mx-4" href="bookCatalog.jsp">Teen</a>
	            <a class="section-link mx-4" href="bookCatalog.jsp">Manga</a>
	            <a class="section-link mx-4" href="bookCatalog.jsp">Classici</a>
	            <a class="section-link mx-4" href="musicCatalog.jsp">CD</a>
	            <a class="section-link mx-4" href="musicCatalog.jsp">Vinili</a>
	            <a class="section-link mx-4" href="gadgetCatalog.jsp">Gadget</a>
	        </div>
	        <div>
				<hr id="divider-row">
  			</div>
	    </div>
  		
 		<div id="modalOverlay"></div>
	    <div id="choiceModal">
	        <div class="modalContent">
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
	    
  		<script src="js/nav.js"></script>
	</body>
</html>