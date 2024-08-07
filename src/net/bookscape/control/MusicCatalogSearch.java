package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import net.bookscape.model.Musica;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.RecensioneModelDM;

/**
 * Servlet implementation class BookCatalog
 */
@WebServlet("/MusicCatalogSearch")
public class MusicCatalogSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MusicCatalogSearch() {
        super();
    }
    
	private static ProductModelDM model;
	private static RecensioneModelDM recensioneModel;
	
	static {
		model = new ProductModelDM();
		recensioneModel = new RecensioneModelDM();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Collection<Musica> musics = null;
		Collection<Musica> musics2 = null;
		Map<Integer, Integer> valutazioni = null;
		
		String tipo  =  request.getParameter("type");
		
		if(tipo == null) {
			response.sendRedirect("GadgetCatalog");
			return ;
		}
		
		try {
			musics = model.doRetrieveAllMusica(null);
			valutazioni = recensioneModel.doRetrieveAllRatingAverageMusic();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(tipo.equalsIgnoreCase("miscellaneous")) {
			musics2 = musics.stream().filter(m -> !m.getGenere().contains("Rock") && !m.getGenere().contains("Pop") && !m.getGenere().contains("Hip-Hop")).collect(Collectors.toList());
		}
		if(tipo.equalsIgnoreCase("Beatles")) {
			musics2 = musics.stream().filter(m -> m.getArtista().contains(tipo)).collect(Collectors.toList());
		}
		else {
			musics2 = musics.stream().filter(m -> m.getGenere().contains(tipo)).collect(Collectors.toList());
		}
		
		request.setAttribute("type", tipo);
		request.setAttribute("musics", musics2);
		request.setAttribute("valutazioni", valutazioni);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("musicCatalogSearch.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
