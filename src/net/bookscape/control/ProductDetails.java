package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.TABLE;

/**
 * Servlet implementation class ProductDetails
 */
@WebServlet("/ProductDetails")
public class ProductDetails extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	private static ProductModelDM model;
	
	static {
		model = new ProductModelDM();
	}
	
    public ProductDetails() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Product prodotto = null;
		int id = Integer.parseInt(request.getParameter("productId"));
		String tableName = request.getParameter("type");
		
		try {
			prodotto = model.doRetrieveByKey(id, TABLE.valueOf(tableName));
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		request.setAttribute("prodotto", prodotto);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("ProductView.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
