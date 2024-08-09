package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.Recensione;
import net.bookscape.model.RecensioneModelDM;
import net.bookscape.model.TABLE;

/**
 * Servlet implementation class ProductDetails
 */
@WebServlet("/ProductDetails")
public class ProductDetails extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	private static ProductModelDM modelProduct;
	private static RecensioneModelDM modelRecensione;
	
	static {
		modelProduct = new ProductModelDM();
		modelRecensione = new RecensioneModelDM();
	}
	
    public ProductDetails() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Product prodotto = null;
		Collection<Recensione> recensioni = null;
		
		int id = Integer.parseInt(request.getParameter("productId"));
		String tableName = request.getParameter("type");
		
		try {
			prodotto = modelProduct.doRetrieveByKey(id, TABLE.valueOf(tableName));
			recensioni = modelRecensione.doRetrieveAll(id, TABLE.valueOf(tableName), "Data");
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage()); 
		}
		
		request.setAttribute("prodotto", prodotto);
		request.setAttribute("recensioni", recensioni);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("ProductView.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}