<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
	<head>
	    <meta charset="utf-8">
	   	<meta name="viewport" content="width=device-width, initial-scale=1">
	   	<title>Registrazione Cliente</title>
	   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	    <link rel="stylesheet" href="css/signup.css">
	    <link rel="stylesheet" href="css/feedback.css">
	    <link rel="icon" href="img/logo.png" type="image/x-icon">
	</head>
	
	<body>
	    <%@ include file="template/navbar.jsp" %>
	
		<%
			String clienteId = (String) request.getSession().getAttribute("cliente");
		    if(clienteId != null){
		        response.sendRedirect("./");
		        return;
		    }
		    
		    String feedbackNegativo = (String) session.getAttribute("feedback-negative");	    	 	
			session.removeAttribute("feedback-negative");
	    %>
	    
	    <%@ include file="template/feedbackSection.jsp" %>
	    
	    <div class="container signupContainer">
	    
	        <div class="row justify-content-around mb-3">
	            <div id="login-tab" class="tab non-active col-auto"><a href="login-form.jsp" style="text-decoration: none; color: inherit;">Login</a></div>
	            <div id="signup-tab" class="tab active col-auto"><a href="javascript:void(0)" style="text-decoration: none; color: inherit;">Registrazione</a></div>
	        </div>
        
	        <h2>Registrazione Cliente</h2>
	     
	     	<%
	    		String serverError = (String) request.getAttribute("errorMessage");
	     		if(serverError != null){
	     			%>
	     				<div class="error-message" style="display: block; margin: 4% auto"><%= serverError %></div>
	     			<%
	     		}
	     	%>
	        <form action="Registration" method="post" onsubmit="return validateSignupForm()" class="row">
	            <div class="form-group">
	                <label for="email">Email:</label>
	                <input type="email" id="email" name="email" required>
	                <i class="fa fa-envelope"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="username">Username:</label>
	                <input type="text" id="username" name="username" autocomplete="username" required>
	                <i class="fa fa-user"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="password">Password:</label>
	                <input type="password" id="password" name="password" required>
	                <i class="fa fa-eye" id="togglePassword" onclick="togglePasswordVisibility()"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="nome">Nome:</label>
	                <input type="text" id="nome" name="nome" required>
	                <i class="fa fa-id-card"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="cognome">Cognome:</label>
	                <input type="text" id="cognome" name="cognome" required>
	                <i class="fa fa-id-card"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="dataNascita">Data di nascita:</label>
	                <input type="date" id="dataNascita" name="dataNascita" required>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="citta">Città:</label>
	                <input type="text" id="citta" name="citta" required>
	                <i class="fa fa-city"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="via">Via:</label>
	                <input type="text" id="via" name="via" required>
	                <i class="fa fa-road"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="CAP">CAP:</label>
	                <input type="text" id="CAP" name="CAP" maxlength="5" required>
	                <i class="fa fa-mail-bulk"></i>
	                <div class="error-message mb-3"></div>
	            </div>
	
	            <input type="submit" value="Registrati">
	        </form>
	    </div>
	
	    <%@ include file="template/footer.jsp"%>
	    
	    <script>
	        function showError(input, message) {
	            const errorElement = input.parentElement.querySelector('.error-message');
	            errorElement.textContent = message;
	            errorElement.style.display = 'block';
	        }
	        
		    function resetErrors() {
		        const errorMessages = document.querySelectorAll('.error-message');
		        errorMessages.forEach(function (error) {
		            error.style.display = 'none';
		            error.textContent = '';
		        });
		    }
		    
		    function togglePasswordVisibility() {
		        const passwordInput = document.getElementById('password');
		        const toggleIcon = document.getElementById('togglePassword');
		        if (passwordInput.type === 'password') {
		            passwordInput.type = 'text';
		            toggleIcon.classList.remove('fa-eye');
		            toggleIcon.classList.add('fa-eye-slash');
		        } else {
		            passwordInput.type = 'password';
		            toggleIcon.classList.remove('fa-eye-slash');
		            toggleIcon.classList.add('fa-eye');
		        }
		    }
	    </script>
	    
	    <script src="js/ValidationUtilsCliente.js"></script>
	    <script src="js/ValidationLibraryCliente.js"></script>
	    <script src="js/scriptFeedback.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>