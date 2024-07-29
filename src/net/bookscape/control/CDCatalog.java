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
@WebServlet("/CDCatalog")
public class CDCatalog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CDCatalog() {
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
		Collection<Musica> vinili = null;
		Map<Integer, Integer> valutazioni = null;
		
		try {
			musics = model.doRetrieveAllMusica(null);
			valutazioni = recensioneModel.doRetrieveAllRatingAverageMusic();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		vinili = musics.stream().filter(v -> v.getFormato().toString().equalsIgnoreCase("CD")).collect(Collectors.toList());
		
		request.setAttribute("musics", vinili);
		request.setAttribute("valutazioni", valutazioni);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("CDCatalog.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
