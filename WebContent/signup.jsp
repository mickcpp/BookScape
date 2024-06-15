<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Registrazione Cliente</title>
	    <link rel="stylesheet"href="css/style.css">
	    
	    <style>
	
	        .container {
	            width: 400px;
	            background-color: #fff;
	            border-radius: 5px;
	            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	            padding: 20px;
	        }
	
	        h2 {
	            text-align: center;
	            margin-bottom: 20px;
	        }
	
	        label {
	            font-weight: bold;
	        }
	
	        input[type="text"],
	        input[type="email"],
	        input[type="password"],
	        input[type="date"] {
	            width: calc(100% - 20px);
	            padding: 10px;
	            margin: 8px 0;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	            box-sizing: border-box;
	        }
	
	        input[type="submit"] {
	            background-color: #4CAF50;
	            color: white;
	            padding: 10px 20px;
	            border: none;
	            border-radius: 5px;
	            cursor: pointer;
	            font-size: 16px;
	            width: 100%;
	        }
	
	        input[type="submit"]:hover {
	            background-color: #45a049;
	        }
	        #contenuto{
	        	align-self: center;
	        }
	        #searchbar-section{
	       		display: none;
	       	}
	    </style>
	</head>
	<body>
		<%@ include file="template/navbar.jsp" %>
		
		<div id="contenuto">
		    <div class="container">
		        <h2>Registrazione Cliente</h2>
		        <form action="Registration" method="post">
		            <label for="email">Email:</label>
		            <input type="email" id="email" name="email" required>
		
		            <label for="username">Username:</label>
		            <input type="text" id="username" name="username" required>
		
		            <label for="password">Password:</label>
		            <input type="password" id="password" name="password" required>
		
		            <label for="nome">Nome:</label>
		            <input type="text" id="nome" name="nome" required>
		
		            <label for="cognome">Cognome:</label>
		            <input type="text" id="cognome" name="cognome" required>
		
		            <label for="dataNascita">Data di nascita:</label>
		            <input type="date" id="dataNascita" name="dataNascita" required>
		
		            <label for="citta">Città:</label>
		            <input type="text" id="citta" name="citta" required>
		
		            <label for="via">Via:</label>
		            <input type="text" id="via" name="via" required>
		
		            <label for="CAP">CAP:</label>
		            <input type="text" id="CAP" name="CAP" required>
		
		            <input type="submit" value="Registrati">
		        </form>
		    </div>
	    </div>
	    
	    <%@ include file="template/footer.html" %>
	</body>
</html>