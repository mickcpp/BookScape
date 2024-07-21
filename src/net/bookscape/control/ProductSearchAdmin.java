package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;

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

        StringBuilder sb = new StringBuilder();
        for (Product p : filteredProducts) {
            sb.append("<tr>")
              .append("<td>").append(p.getId()).append("</td>")
              .append("<td>").append(p.getNome()).append("</td>")
              .append("<td>").append(p.getPrezzo()).append("</td>")
              .append("<td>").append(p.getQuantita()).append("</td>")
              .append("<td class=\"row\">")
              .append("<button class=\"btn btn-primary d-none d-lg-inline-block col-auto my-1 my-lg-0 mx-1\" onclick=\"location.href='ProductControl?productId=").append(p.getId()).append("&action=viewEdit'\">Modifica</button>")
              .append("<button class=\"btn btn-primary btn-sm d-lg-none col-auto my-1 my-lg-0 mx-1\" onclick=\"location.href='ProductControl?productId=").append(p.getId()).append("&action=viewEdit'\">Modifica</button>")
              .append("<button class=\"btn btn-danger d-none d-lg-inline-block col-auto my-1 my-lg-0 mx-1\" onclick=\"location.href='ProductControl?productId=").append(p.getId()).append("&action=rimuovi'\">Elimina</button>")
              .append("<button class=\"btn btn-danger btn-sm d-lg-none col-auto my-1 my-lg-0 mx-1\" onclick=\"location.href='ProductControl?productId=").append(p.getId()).append("&action=rimuovi'\">Elimina</button>")
              .append("</td>")
              .append("</tr>");
        }


        response.setContentType("text/html");
        response.getWriter().write(sb.toString());
    }  
}
