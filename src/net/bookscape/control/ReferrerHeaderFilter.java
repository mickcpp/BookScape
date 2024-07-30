package net.bookscape.control;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ReferrerHeaderFilter extends HttpFilter implements Filter {
       
    public ReferrerHeaderFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if (response instanceof HttpServletResponse) {
            HttpServletResponse httpServletResponse = (HttpServletResponse) response;
            httpServletResponse.setHeader("Referrer-Policy", "strict-origin-when-cross-origin");
        }
		chain.doFilter(request, response);
	}

	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}
}