<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <base href="${pageContext.request.contextPath}/">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	  	<link rel="stylesheet" href="css/footerStyle.css">
	</head>
	<body>
	    <footer class="bg-dark text-light py-4">
	        <div class="container">
	            <div class="row">
	                <!-- Terms and Policy -->
	                <div class="col-md-3">
	                    <h3>Terms and Policy</h3>
	                    <ul class="list-unstyled">
	                        <li><a href="privacyPolicy.jsp" class="text-light">Privacy Policy</a></li>
	                        <li><a href="termsService.jsp" class="text-light">Terms of Service</a></li>
	                        <li><a href="refundPolicy.jsp" class="text-light">Refund Policy</a></li>
	                    </ul>
	                </div>
	
	                <!-- Quick Help -->
	                <div class="col-md-3">
	                    <h3>Quick Help</h3>
	                    <ul class="list-unstyled">
	                        <li><a href="shippingInfo.jsp" class="text-light ">Shipping Info</a></li>
	                        <li><a href="faq.jsp" class="text-light">FAQ</a></li>
	                        <li><a href="support.jsp" class="text-light">Support</a></li>
	                    </ul>
	                </div>
	
	                <!-- Contact -->
	                <div class="col-md-3">
	                    <h3>Contact</h3>
	                    <ul class="list-unstyled">
	                        <li><a href="emailUs.jsp" class="text-light">Email Us</a></li>
	                        <li><a href="callUs.jsp" class="text-light">Call Us</a></li>
	                        <li><a href="visitUs.jsp" class="text-light">Visit Us</a></li>
	                    </ul>
	                </div>
	
	                <!-- Products -->
	                <div class="col-md-3">
	                    <h3>Products</h3>
	                    <div class="row">
	                        <div class="col">
	                            <h5><a href="bookCatalog.jsp" class="text-light">Books</a></h5>
	                            <ul class="list-unstyled">
	                                <li><a href="fantasyCatalog.jsp" class="text-light">Fantasy</a></li>
	                                <li><a href="horrorCatalog.jsp" class="text-light">Thriller</a></li>
	                                <li><a href="teenCatalog.jsp" class="text-light">Teen</a></li>
	                                <li><a href="classicCatalog.jsp" class="text-light">Classics</a></li>
	                            </ul>
	                        </div>
	                        <div class="col">
	                            <h5><a href="musicCatalog.jsp" class="text-light">Vinyls/CDs </a></h5>
	                            <ul class="list-unstyled">
	                                <li><a href="MusicCatalogSearch?type=Rock" class="text-light">Rock</a></li>
	                                <li><a href="MusicCatalogSearch?type=Hip-Hop" class="text-light">Hip-Hop</a></li>
	                                <li><a href="MusicCatalogSearch?type=Pop" class="text-light">Pop</a></li>
	                                <li><a href="MusicCatalogSearch?type=Miscellaneous" class="text-light">Miscellaneous</a></li>
	                            </ul>
	                        </div>
	                        <div class="col">
	                            <h5><a href="gadgetCatalog.jsp" class="text-light">Gadgets </a></h5>
	                            <ul class="list-unstyled">
	                                <li><a href="GadgetCatalogSearch?type=Tazza" class="text-light">Mugs</a></li>
	                                <li><a href="GadgetCatalogSearch?type=Action" class="text-light">Figures</a></li>
	                                <li><a href="GadgetCatalogSearch?type=Cover" class="text-light">Covers</a></li>
	                                <li><a href="GadgetCatalogSearch?type=Poster" class="text-light">Posters</a></li>
	                            </ul>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            
	            <hr class="bg-light">
	            
	            <div class="row">
	                <!-- About Us -->
	                <div class="col-md-10">
	                    <h5>About Us</h5>
	                    <p>Bookscape Internet Bookshop S.r.l. - Sede legale e amministrativa Via Tenente Nastri, 14 84084 Lancusi (SA) - C.F. e P.I. 0512113333 - Reg. imprese di Maddaloni Ottaviano S.M.A.V. nr. 0512113333 - R.E.A. SA 1815721 - Capitale Sociale € 100.000,00 i.v. - A Socio Unico soggetta a direzione e coordinamento di BookScape S.r.L.</p>
	                </div>
	                <!-- Social Media -->
	                <div class="col-md-2 text-md-end">
	                    <h5>Follow Us</h5>
	                    <a href="https://www.facebook.com/" class="text-light me-2"><i class="fab fa-facebook fa-2x"></i></a>
	                    <a href="https://x.com/" class="text-light me-2"><i class="fab fa-twitter fa-2x"></i></a>
	                    <a href="https://www.instagram.com/" class="text-light me-2"><i class="fab fa-instagram fa-2x"></i></a>
	                    <a href="https://it.linkedin.com/" class="text-light"><i class="fab fa-linkedin fa-2x"></i></a>
	                </div>
	            </div>
	        </div>
	    </footer>
	</body>
</html>