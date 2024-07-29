package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Map;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import net.bookscape.model.Gadget;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.RecensioneModelDM;

/**
 * Servlet implementation class BookCatalog
 */
@WebServlet("/GadgetCatalog")
public class GadgetCatalog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GadgetCatalog() {
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
		Map<Integer, Integer> valutazioni = null;
		
		try {
			gadgets = model.doRetrieveAllGadget(null);
			valutazioni = recensioneModel.doRetrieveAllRatingAverageGadgets();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("gadgets", gadgets);
		request.setAttribute("valutazioni", valutazioni);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("gadgetCatalog.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
