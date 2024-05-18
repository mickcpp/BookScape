package net.bookscape.control;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminFilter implements Filter {

	public void destroy() {}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest hrequest = (HttpServletRequest) request;
		HttpServletResponse hresponse = (HttpServletResponse) response;
		
		String adminURI = hrequest.getContextPath() + "/admin";
		boolean loginRequest = hrequest.getRequestURI().startsWith(adminURI);

		if(loginRequest) {
			HttpSession session = hrequest.getSession(false);
			boolean loggedIn = session != null && session.getAttribute("adminRole") != null;

			if(!loggedIn) {
				hresponse.sendRedirect(hrequest.getContextPath());
			} else {
				// risorsa admin
				chain.doFilter(request, response);
			}
		} else {
			// risorsa accessibile
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig fConfig) throws ServletException {}
	
}
