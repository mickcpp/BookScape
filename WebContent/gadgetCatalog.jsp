<%@ page import="java.util.*" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Gadget, utility.EscaperHTML"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
    	<title>Gadgets</title>
    	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
		<link rel="stylesheet" href="css/catalog.css">
		<link rel="stylesheet" href="css/feedback.css">
		<link rel="icon" href="img/logo.png" type="image/x-icon">
	</head>
	<body>
		<%@ include file="template/navbar.jsp" %>
		
		<%!String nomeTabella = "";%>
		
		<%
			String feedback = (String) session.getAttribute("feedback");
	 		String feedbackNegativo = (String) session.getAttribute("feedback-negative");
	 		
	 		session.removeAttribute("feedback");
			session.removeAttribute("feedback-negative");
			
			@SuppressWarnings("unchecked")
			Collection<Gadget> gadgets = (Collection<Gadget>) request.getAttribute("gadgets");
			
			@SuppressWarnings("unchecked")
			Map<Integer, Integer> valutazioni = (HashMap<Integer, Integer>) request.getAttribute("valutazioni");
		
			if(gadgets == null || gadgets.isEmpty() || valutazioni == null) {
				response.sendRedirect("GadgetCatalog");
				return;
			} 
		%>
		
		<%@ include file="template/feedbackSection.jsp" %>
		
		<div class="container-fluid gadgetsContainer">
			<div class="row d-flex justify-content-center">
	<%
			int i = 0;
			for(Gadget gadget : gadgets){
	%>
      		<div class="card mx-5 my-3">
      			<div class="img-container">
      				<a href="ProductDetails?productId=<%=gadget.getId()%>&type=<%=gadget.getClass().getSimpleName().toLowerCase()%>"><img src="<%= gadget.getImgURL() %>" alt="..." class="img-fluid"></a>
	         		<form action="CartControl" method="post">
						<input type="hidden" name="productId" value="<%= gadget.getId() %>">
						<input type="hidden" name="type" value="<%=gadget.getClass().getSimpleName().toLowerCase()%>">
						<input type="hidden" name="action" value="aggiungi">
						<input type="hidden" name="redirect" value="GadgetCatalog">
						<input type="submit" value="Aggiungi al carrello" class="add-to-cart">
					</form>
      			</div>
        
        		<div class="card-body">
           			<h5 class="card-title"><%= EscaperHTML.escapeHTML(gadget.getNome()) %></h5>
          			<p class="card-text">BS Gadget</p>
           			<div class="rating me-2">
		              	<% int valutazione = 3; if(valutazioni.get(gadget.getId()) != null) { valutazione = valutazioni.get(gadget.getId()); } for (int j = 0; j < valutazione; j++) { %>
		                	<i class="fas fa-star"></i>
		                <% } %>
         			</div>
         			<form id="wishlist-form" action="WishlistControl" method="post">
						<input type="hidden" name="productId" value="<%= gadget.getId() %>">
						<input type="hidden" name="type" value="<%=gadget.getClass().getSimpleName().toLowerCase()%>">
						<input type="hidden" name="action" value="aggiungi">
						<input type="hidden" name="redirect" value="GadgetCatalog">
						<button class="bookmark" type=submit><i class="bi bi-bookmark-heart"></i></button>
					</form>
       			</div>
       		</div>
	<%
			i++;
			if(i > 0 && i % 4 == 0){
				%>
					</div>
					<div class="row d-flex justify-content-center">
				<%
			}
		}
			if(i > 0 && i % 4 != 0){
				%>
					</div>
				<%
			}
	%>
		</div>
		
		<%@ include file="template/footer.jsp"%>
		
		<script src="js/scriptFeedback.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>
