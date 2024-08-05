<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
	<head>
	    <meta charset="utf-8">
	   	<meta name="viewport" content="width=device-width, initial-scale=1">
	   	<title>Login</title>
	   	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	    <link rel="stylesheet" href="css/login.css">
	    <link rel="icon" href="img/logo.png" type="image/x-icon">
	    <jsp:include page="header.jsp" />
	</head>
	<body>
	    <%@ include file="template/navbar.jsp" %>
	    
	    <%
		    String clienteId = (String) request.getSession().getAttribute("cliente");
		    if(clienteId != null){
		        response.sendRedirect("./");
		        return;
		    }
	    %>
	    
	    <div class="container loginContainer">
	        <div class="row justify-content-around mb-3">
	            <div id="login-tab" class="tab active col-auto"><a href="javascript:void(0)" style="text-decoration: none; color: inherit;">Login</a></div>
	            <div id="signup-tab" class="tab non-active col-auto"><a href="signup.jsp" style="text-decoration: none; color: inherit;">Registrazione</a></div>
	        </div>
	
	        <div id="login-form" class="row">
	            <h2>Login</h2>
	            <form action="Login" method="post" onsubmit="return validateLoginForm()">
	                <div class="form-group">
	                    <label for="login-id">Username o Email:</label>
	                    <input type="text" id="login-id" name="id" placeholder="Username o Email" required>
	                    <i class="fa fa-user"></i>
	                </div>
	                <div class="form-group">
	                    <label for="login-password">Password:</label>
	                    <input type="password" id="login-password" name="password" placeholder="Password" required>
	             		<i class="fa fa-eye" id="togglePassword" onclick="togglePasswordVisibility()"></i>
	                </div>
	                <input type="submit" value="Login">
	            </form>
	        </div>
	
	        <%
	            String error = (String) request.getAttribute("error");
	            if (error != null) {
	                %>
	                <div id="error-message" style="color: red; text-align: center; font-size: 1.05em"><%=error%></div>
	                <%
	            } else{
	            	%>
	                <div id="error-message" style="display: none; color: red; text-align: center; font-size: 1.05em"></div>
	            	<%
	            }
	        %>
	    </div>
	
	    <%@ include file="template/footer.jsp"%>
	    
	    <script>
	        function showError(message) {
	            const errorElement = document.getElementById('error-message');
	            errorElement.textContent = message;
	       		errorElement.style.display = 'block';
	        }
	        
	        function resetErrors() {
	            const errorElement = document.getElementById('error-message');
	            errorElement.textContent = '';
	            errorElement.style.display = 'none';
	        }
	        
	        function togglePasswordVisibility() {
		        const passwordInput = document.getElementById('login-password');
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
	    
	    <script src="js/ValidationLibraryCliente.js"></script>
	    <script src="js/ValidationUtilsCliente.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	</body>
</html>