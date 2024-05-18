<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <title>Login</title>
	    <link rel="stylesheet" href="css/style.css">
	    <style>
	        /* Stili CSS per il form */
	        body {
	            font-family: Arial, sans-serif;
	            background-color: #f4f4f4;
	        }
	        .login-box {
	            width: 300px;
	            margin: 70px auto;
	            margin-bottom: 110px;
	            padding: 20px;
	            background: #fff;
	            border-radius: 5px;
	            box-shadow: 0 0 10px rgba(0,0,0,0.1);
	        }
	        .login-box h2 {
	            text-align: center;
	            margin-bottom: 20px;
	        }
	        .login-box input[type="text"], 
	        .login-box input[type="password"] {
	            width: 100%;
	            padding: 10px;
	            margin-bottom: 15px;
	            border: 1px solid #ccc;
	            border-radius: 5px;
	            box-sizing: border-box;
	        }
	        .login-box input[type="submit"] {
	            width: 100%;
	            background: #007bff;
	            border: none;
	            padding: 10px;
	            border-radius: 5px;
	            color: #fff;
	            cursor: pointer;
	        }
	        .login-box input[type="submit"]:hover {
	            background: #0056b3;
	        }
	    </style>
	</head>
	<body>
		<%@ include file="template/navbar.html" %>
		
		<div class="login-box">
		    <h2>Login</h2>
		    <p>Se non sei registrato, <a href="signup.jsp">registrati qui!</a></p>
		    <form action="Login" method="post">
		        <input type="text" name="id" placeholder="Username" required><br>
		        <input type="password" name="password" placeholder="Password" required><br>
		        <input type="submit" value="Login">
		    </form>
		    <%
			String error = (String) request.getAttribute("error");
			if(error != null){
				%>
					<p style="color: red; text-align: center"><%=error%></p>
				<%
			}
			%>
		</div>
	
		<%@ include file="template/footer.html" %>
	</body>
</html>