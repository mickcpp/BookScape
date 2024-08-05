<%!
	String feedback, feedbackNegativo;
%>

	<div id="feedback-message" class="feedback-message">
	   <%= feedback == null ? "" : feedback %>
	</div>
	
	<div id="feedback-message-negative" class="feedback-message-negative">
	    <%= feedbackNegativo == null ? "" : feedbackNegativo %>
	</div>
