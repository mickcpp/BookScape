package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Map;
import java.util.stream.Collectors;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.bookscape.model.Libro;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.RecensioneModelDM;

@WebServlet("/BookCatalogSearch")
public class BookCatalogSearch extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public BookCatalogSearch() {
        super();
    }

    private static ProductModelDM model;
    private static RecensioneModelDM recensioneModel;

    static {
        model = new ProductModelDM();
        recensioneModel = new RecensioneModelDM();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Collection<Libro> libri = null;
        Collection<Libro> libri2 = null;
        Map<Integer, Integer> valutazioni = null;
        
        String tipo  =  request.getParameter("type");
        String autore  =  request.getParameter("autor");

		
		if(tipo == null) {
			response.sendRedirect("BookCatalog");
			return ;
		}

        try {
            libri = model.doRetrieveAllLibro(null);
            valutazioni = recensioneModel.doRetrieveAllRatingAverageBooks();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (libri != null) {
        	if(tipo.equalsIgnoreCase("Fantasy")) {
        		libri2 = libri.stream()
                        .filter(l -> l.getGenere().contains("Fantasy") || l.getGenere().contains("Fantascienza"))
                        .collect(Collectors.toList());
        	}
        	if(tipo.equalsIgnoreCase("Horror")) {
        		libri2 = libri.stream()
                        .filter(l -> l.getGenere().equals(tipo))
                        .collect(Collectors.toList());
        	}
        	if(tipo.equalsIgnoreCase("teen")) {
        		libri2 = libri.stream()
                        .filter(l -> l.getDescrizione().contains("Fiaba") || l.getDescrizione().contains("ragazzi"))
                        .collect(Collectors.toList());
        	}
        	if(tipo.equalsIgnoreCase("Manga")) {
        		libri2 = libri.stream()
                        .filter(l -> l.getGenere().equals(tipo))
                        .collect(Collectors.toList());
        	}
        	if(tipo.equalsIgnoreCase("Classic")) {
        		libri2 = libri.stream()
                        .filter(l -> l.getDescrizione().contains("Classico") || l.getDescrizione().contains("classico"))
                        .collect(Collectors.toList());
        	}
        	if(tipo.equalsIgnoreCase("Tolkien")) {
        		libri2 = libri.stream()
                        .filter(l -> l.getAutore().contains(tipo))
                        .collect(Collectors.toList());
        	}
        	if(tipo.equalsIgnoreCase("love")) {
        		libri2 = libri.stream()
                        .filter(l -> l.getDescrizione().contains("amore") || l.getDescrizione().contains("romantica"))
                        .collect(Collectors.toList());
        	}
            
        }
        

        request.setAttribute("libri", libri2);
        request.setAttribute("valutazioni", valutazioni);

        RequestDispatcher dispatcher = request.getRequestDispatcher("bookCatalogSearch.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
