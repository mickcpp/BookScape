package net.bookscape.control;

import java.io.IOException;

import java.sql.SQLException;
import java.util.Collection;
import java.util.UUID;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import net.bookscape.model.CsrfTokens;
import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;
import utility.EscaperHTML;

@WebServlet("/ProductSearchAdmin")
public class ProductSearchAdmin extends HttpServlet {
	
    private static final long serialVersionUID = 1L;
    
    public ProductSearchAdmin() {
        super();
    }
    
    private static ProductModelDM model;
	
	static {
		model = new ProductModelDM();
	}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        String queryParam = request.getParameter("query");
        final String query;
        
        if(queryParam != null) query = request.getParameter("query").toLowerCase();
        else {
        	response.sendRedirect("./");
        	return;
        }
        
        Collection<Product> prodotti = null;
        
		try {
			prodotti = model.doRetrieveAll(null);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        Collection<Product> filteredProducts = prodotti.stream()
            .filter(p -> p.getNome().toLowerCase().contains(query))
            .collect(Collectors.toList());

	    CsrfTokens csrfTokens = (CsrfTokens) request.getSession().getAttribute("csrfTokens");
	    
	    if (csrfTokens == null) {
	        csrfTokens = new CsrfTokens();
	    }

	    // Genera un nuovo token
	    String csrfToken = UUID.randomUUID().toString();
	    csrfTokens.addToken(csrfToken);
	    request.getSession().setAttribute("csrfTokens", csrfTokens);
        
        StringBuilder sb = new StringBuilder();
        for (Product p : filteredProducts) {
        	sb.append("<tr>")
        	  .append("<td>").append(p.getId()).append("</td>")
        	  .append("<td>").append(EscaperHTML.escapeHTML(p.getNome())).append("</td>")
        	  .append("<td>").append(p.getPrezzo()).append("</td>")
        	  .append("<td>").append(p.getQuantita()).append("</td>")
        	  .append("<td class=\"row\">")

        	  // Modifica button for large screens
        	  .append("<button class=\"btn btn-primary d-none d-lg-inline-block col-auto my-1 my-lg-0 mx-1\" onclick=\"location.href='ProductControl?productId=").append(p.getId()).append("&action=viewEdit'\">Modifica</button>")

        	  // Modifica button for small screens
        	  .append("<button class=\"btn btn-primary btn-sm d-lg-none col-auto my-1 my-lg-0 mx-1\" onclick=\"location.href='ProductControl?productId=").append(p.getId()).append("&action=viewEdit'\">Modifica</button>")

        	  // Elimina button for large screens wrapped in a form
        	  .append("<form action=\"ProductControl\" method=\"post\" class=\"d-none d-lg-inline-block col-auto my-1 my-lg-0 mx-1\" style=\"padding: 0\">")
        	  .append("<input type=\"hidden\" name=\"productId\" value=\"").append(p.getId()).append("\">")
        	  .append("<input type=\"hidden\" name=\"action\" value=\"rimuovi\">")
        	  .append("<input type=\"hidden\" name=\"csrfToken\" value=\"").append(csrfToken).append("\">") // Add CSRF token
        	  .append("<button type=\"submit\" class=\"btn btn-danger\">Elimina</button>")
        	  .append("</form>")

        	  // Elimina button for small screens wrapped in a form
        	  .append("<form action=\"ProductControl\" method=\"post\" class=\"d-lg-none col-auto my-1 my-lg-0 mx-1\" style=\"padding: 0\">")
        	  .append("<input type=\"hidden\" name=\"productId\" value=\"").append(p.getId()).append("\">")
        	  .append("<input type=\"hidden\" name=\"action\" value=\"rimuovi\">")
        	  .append("<input type=\"hidden\" name=\"csrfToken\" value=\"").append(csrfToken).append("\">") // Add CSRF token
        	  .append("<button type=\"submit\" class=\"btn btn-danger btn-sm\">Elimina</button>")
        	  .append("</form>")

        	  .append("</td>")
        	  .append("</tr>");
        }


        response.setContentType("text/html");
        response.getWriter().write(sb.toString());
    }  
}
