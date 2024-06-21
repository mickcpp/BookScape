<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
        }
	
		#zona_utente #searchbar-section{
			display: none;
		}
		
        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 90%;
            max-width: 350px;
            text-align: center;
            margin: -10px auto 6% auto;
        }
      	
        h2 {
            color: #333;
            margin-top: 0;
            margin-bottom: 0;
            font-size: 1.5em;
        }

        label {
            color: #555;
            margin-bottom: 20px;
            margin-top: 18px;
        }

        a {
            color: #007bff;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            text-align: left;
            color: #555;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #1abc9c;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s;
            margin: 15px auto;
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

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            input[type="submit"] {
                font-size: 14px;
            }
        }

        .tab-container {
            display: flex;
            justify-content: space-around;
            margin-bottom: 19px;
          	font-size: 1.1em;
        }

        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border-bottom: 2px solid transparent;
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
    </style>
</head>
<body>
    <%@ include file="template/navbar.jsp" %>

    <div class="container">
        <div class="tab-container">
            <div id="login-tab" class="tab active"><a href="javascript:void(0)" style="text-decoration: none; color: inherit;">Login</a></div>
            <div id="signup-tab" class="tab non-active"><a href="signup.jsp" style="text-decoration: none; color: inherit;">Registrazione</a></div>
        </div>

        <div id="login-form">
            <h2>Login</h2>
            <form action="Login" method="post" onsubmit="return validateForm()">
                <div class="form-group">
                    <label for="login-id">Username o Email:</label>
                    <input type="text" id="login-id" name="id" placeholder="Username o Email" required>
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group">
                    <label for="login-password">Password:</label>
                    <input type="password" id="login-password" name="password" placeholder="Password" required>
                    <i class="fa fa-lock"></i>
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

    <%@ include file="template/footer.html" %>
    
    <script>
        function validateForm() {
            let isValid = true;
            const id = document.getElementById('login-id');
            const password = document.getElementById('login-password');
            const errorElement = document.getElementById('error-message');

            resetErrors();

            if (id.value.includes('@')) {
                if (!validateEmail(id.value) || password.value.length < 8) {
                    showError("Email o password errate!");
                    isValid = false;
                }
            } else {
                if (!validateUsername(id.value) || password.value.length < 8) {
                    showError("Username o password errati!");
                    isValid = false;
                }
            }
            return isValid;
        }

        function validateEmail(email) {
            const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return re.test(String(email).toLowerCase());
        }
        
        function validateUsername(username) {
            const re = /^[a-zA-Z0-9_.]{3,}$/;
            return re.test(String(username));
        }

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
    </script>
</body>
</html>
