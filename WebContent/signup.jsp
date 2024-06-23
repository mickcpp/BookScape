<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Registrazione Cliente</title>
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
	    
	    <style>
	        html, body {
	            margin: 0;
	            padding: 0;
	            height: 100%;
	            font-family: 'Roboto', sans-serif;
	            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
	        }
	
	        .container {
	            background-color: #fff;
	            border-radius: 10px;
	            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	            padding: 40px;
	            width: 90%;
	            max-width: 600px;
	            text-align: center;
	           	margin: -29px auto 2% auto;
	        }
	
			#zona_utente #searchbar-section{
				display: none;
			}
			
	        h2 {
	            color: #333;
	          	margin: 0 auto 11px auto;
	        }
	
	        label {
	            display: block;
	            font-weight: bold;
	            text-align: left;
	            color: #555;
	            margin-bottom: 8px;
	        }
	
	        .container input[type="text"],
	        .container input[type="email"],
	        .container input[type="password"],
	        .container input[type="date"] {
	            width: 100%;
	            padding: 12px;
	            margin-bottom: 20px;
	            border: 1px solid #ddd;
	            border-radius: 5px;
	            box-sizing: border-box;
	            font-size: 16px;
	        }
	        
	        .error-message {
	            color: #e74c3c;
	            font-size: 0.9em;
	            margin-top: -15px;
	            margin-bottom: 1.55%;
	            text-align: left;
	            display: none;
	        }
	
	        input[type="submit"] {
	            background-color: #1abc9c;
	            color: white;
	            padding: 12px 20px;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            font-size: 18px;
	            width: 100%;
	            transition: background-color 0.3s;
	        }
	
	        input[type="submit"]:hover {
	            background-color: #16a085;
	        }
	
	        .form-group {
	            position: relative;
	        }
	
	        .form-group .fa {
	            position: absolute;
	            right: 10px;
	            top: 48px;
	            transform: translateY(-50%);
	            color: #999;
	        }
	
	        .tab-container {
	            display: flex;
	            justify-content: space-around;
	            margin-bottom: 24px;
	          	font-size: 1.1em;
	        }
	
	       .tab {
			    padding: 10px 20px;
			    cursor: pointer;
			}
			
			.tab a{
				padding: 10px 10px;
			}
		
			.tab.non-active{
				border-bottom: 2px solid rgba(0, 0, 0, 0.5);
			    opacity: 0.5;
			    transition: opacity 0.3s ease, border-bottom-color 0.3s ease;
			}
	
	        .tab.active {
	            border-bottom: 2px solid #1abc9c;
	            color: #1abc9c;
	        }
	        
	        @media (max-width: 768px) {
	            .container {
	                padding: 30px;
	            }
	
	            input[type="submit"] {
	                font-size: 16px;
	            }
	        }
	    </style>
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
	    
	    <div class="container">
	    
	        <div class="tab-container">
	            <div id="login-tab" class="tab non-active"><a href="login-form.jsp" style="text-decoration: none; color: inherit;">Login</a></div>
	            <div id="signup-tab" class="tab active"><a href="javascript:void(0)" style="text-decoration: none; color: inherit;">Registrazione</a></div>
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
	        <form action="Registration" method="post" onsubmit="return validateForm()">
	            <div class="form-group">
	                <label for="email">Email:</label>
	                <input type="email" id="email" name="email" required>
	                <i class="fa fa-envelope"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="username">Username:</label>
	                <input type="text" id="username" name="username" required>
	                <i class="fa fa-user"></i>
	                <div class="error-message"></div>
	            </div>
	
	            <div class="form-group">
	                <label for="password">Password:</label>
	                <input type="password" id="password" name="password" required>
	                <i class="fa fa-lock"></i>
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
	                <div class="error-message"></div>
	            </div>
	
	            <input type="submit" value="Registrati">
	        </form>
	    </div>
	
	    <%@ include file="template/footer.html" %>
	    
	    <script>
    		function validateForm() {
		        let isValid = true;
		
		        const email = document.getElementById('email');
		        const username = document.getElementById('username');
		        const password = document.getElementById('password');
		        const nome = document.getElementById('nome');
		        const cognome = document.getElementById('cognome');
		        const dataNascita = document.getElementById('dataNascita');
		        const citta = document.getElementById('citta');
		        const via = document.getElementById('via');
		        const CAP = document.getElementById('CAP');
		        
		        resetErrors();
		
		        if (!validateEmail(email.value)) {
		            showError(email, "Inserisci un'email valida.");
		            isValid = false;
		        }
		        
		        if (!validateUsername(username.value)) {
		        	if (username.value.length > 20) {
			        	showError(username, "L'username può essere lungo al massimo 20 caratteri");
			            isValid = false;
		        	} else if (username.value.length < 3) {
			        	showError(username, "L'username deve essere lungo almeno 3 caratteri");
			            isValid = false;
		        	} else{
		        		showError(username, "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.");
			            isValid = false;
		        	}
		        }
		
		        if (password.value.length < 8) {
		            showError(password, "La password deve essere lunga almeno 8 caratteri.");
		            isValid = false;
		        }
		
		        if (!validateName(nome.value)) {
		        	if (nome.value.length > 50) {
			        	showError(nome, "Il nome può essere lungo al massimo 50 caratteri");
			            isValid = false;
		        	} else if (nome.value.length < 3) {
			        	showError(nome, "Il nome deve essere lungo almeno 3 caratteri");
			            isValid = false;
		        	} else{
		        		showError(nome, "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)");
			            isValid = false;
		        	}
		        }
		
		        if (!validateAlpha(cognome.value)) {
		        	if (cognome.value.length > 50) {
			        	showError(cognome, "Il cognome può essere lungo al massimo 50 caratteri");
			            isValid = false;
		        	} else{
		        		showError(cognome, "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.");
				        isValid = false;
		        	}
		        }
		
		        if (!validateDate(dataNascita.value)) {
		            showError(dataNascita, "Inserisci una data di nascita valida.");
		            isValid = false;
		        }
		
		        if (!validateAlphaNumericWithSpaces(citta.value)) {
		        	if (citta.value.length > 50) {
			        	showError(citta, "La città può essere lunga al massimo 50 caratteri");
			            isValid = false;
		        	} else{
		        		showError(citta, "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
			            isValid = false;
		        	}
		        }
		        
		        if (!validateAlphaNumericWithSpaces(via.value)) {
		        	if (via.value.length > 50) {
			        	showError(via, "La via può essere lunga al massimo 50 caratteri");
			            isValid = false;
		        	} else{
		        		showError(via, "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).");
			            isValid = false;
		        	}
		        }
		
		        if (!validateCAP(CAP.value)) {
		            showError(CAP, "Inserisci un CAP valido.");
		            isValid = false;
		        }
		
		        return isValid;
		   	}	
		
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
	    </script>
	    
	    <script src="js/ValidationLibraryCliente.js"></script>
	</body>
</html>