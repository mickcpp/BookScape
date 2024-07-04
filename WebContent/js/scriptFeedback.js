document.addEventListener("DOMContentLoaded", function() {
    var feedbackMessage = document.getElementById("feedback-message");
    if (feedbackMessage.textContent.trim() !== "") {
        feedbackMessage.style.display = "block";
        setTimeout(function() {
            feedbackMessage.style.opacity = "1";
        }, 100);  // Slight delay to trigger CSS transition
        setTimeout(function() {
            feedbackMessage.style.opacity = "0";
            setTimeout(function() {
                feedbackMessage.style.display = "none";
            }, 500);  // Time for the fade-out transition
        }, 3000);  // Display the message for 3 seconds
    }
});

document.addEventListener("DOMContentLoaded", function() {
    var feedbackMessage = document.getElementById("feedback-message-negative");
    if (feedbackMessage.textContent.trim() !== "") {
        feedbackMessage.style.display = "block";
        setTimeout(function() {
            feedbackMessage.style.opacity = "1";
        }, 100);  // Slight delay to trigger CSS transition
        setTimeout(function() {
            feedbackMessage.style.opacity = "0";
            setTimeout(function() {
                feedbackMessage.style.display = "none";
            }, 500);  // Time for the fade-out transition
        }, 3000);  // Display the message for 3 seconds
    }
});