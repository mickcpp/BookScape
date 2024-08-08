package net.bookscape.control;

import jakarta.servlet.Filter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

/**
 * Servlet Filter implementation class RedirectFilter
 */
public class RedirectFilter extends HttpFilter implements Filter {

    public RedirectFilter() {
        super();
    }

	public void destroy() {}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String redirectUrl = httpRequest.getParameter("redirect");

        if (redirectUrl != null && isRelativePath(redirectUrl)) {
            // Se l'URL è consentito, continua con la catena di filtri
            chain.doFilter(request, response);
        } else {
        	if(redirectUrl == null) chain.doFilter(request, response);
            // Blocca il reindirizzamento e invia un errore 403
        	else httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Reindirizzamento non consentito");
        }
	}

    private boolean isRelativePath(String url) {
        // Verifica che il percorso sia relativo (non contenga punti o protocolli)
        return !url.startsWith("http://") && !url.startsWith("https://");
    }

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}
}