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
import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.RecensioneModelDM;

/**
 * Servlet implementation class HomePage
 */
@WebServlet("/HomePage")
public class HomePage extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public HomePage() {
        super();
    }
    
	private static ProductModelDM model;
	private static RecensioneModelDM recensioneModel;
	
	static {
		model = new ProductModelDM();
		recensioneModel = new RecensioneModelDM();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Collection<Product> prodotti = null;
		Map<Integer, Integer> valutazioni = null;
		Collection<Integer> libriPiuRecensitiID = null;
		
		try {
			prodotti = model.doRetrieveAll(null);
			valutazioni = recensioneModel.doRetrieveAllRatingAverageBooks();
			valutazioni.putAll(recensioneModel.doRetrieveAllRatingAverageMusic());
			valutazioni.putAll(recensioneModel.doRetrieveAllRatingAverageGadgets());
			libriPiuRecensitiID = model.doRetrievePiuRecensiti();
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		request.setAttribute("prodotti", prodotti);
		request.setAttribute("valutazioni", valutazioni);
		request.setAttribute("libriPiuRecensitiID", libriPiuRecensitiID);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("./");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
