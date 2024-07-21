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

import net.bookscape.model.Gadget;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.RecensioneModelDM;

/**
 * Servlet implementation class BookCatalog
 */
@WebServlet("/GadgetCatalogSearch")
public class GadgetCatalogSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GadgetCatalogSearch() {
        super();
    }
    
	private static ProductModelDM model;
	private static RecensioneModelDM recensioneModel;
	
	static {
		model = new ProductModelDM();
		recensioneModel = new RecensioneModelDM();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Collection<Gadget> gadgets = null;
		Collection<Gadget> gadgetsFiltered = null;
		Map<Integer, Integer> valutazioni = null;
		
	
		
		String tipo  =  request.getParameter("type");
		
		if(tipo == null) {
			response.sendRedirect("GadgetCatalog");
			return ;
		}
		
		try {
			gadgets = model.doRetrieveAllGadget(null);
			valutazioni = recensioneModel.doRetrieveAllRatingAverageGadgets();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		gadgetsFiltered = gadgets.stream().filter(g -> g.getDescrizione().contains(tipo)).collect(Collectors.toList());
		
		request.setAttribute("gadgets", gadgetsFiltered);
		request.setAttribute("valutazioni", valutazioni);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("gadgetCatalogSearch.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
