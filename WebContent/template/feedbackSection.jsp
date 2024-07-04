<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	</head>
	<body>
		<%!
			String feedback, feedbackNegativo;
		%>
		
		<div id="feedback-message" class="feedback-message">
	    <%= feedback == null ? "" : feedback %>
		</div>
		
		<div id="feedback-message-negative" class="feedback-message-negative">
		    <%= feedbackNegativo == null ? "" : feedbackNegativo %>
		</div>
		
	</body>
</html>