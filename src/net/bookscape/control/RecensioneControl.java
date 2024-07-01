package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Recensione;
import net.bookscape.model.RecensioneModelDM;
import net.bookscape.model.TABLE;

/**
 * Servlet implementation class RecensioneControl
 */
@WebServlet("/RecensioneControl")
public class RecensioneControl extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	
    public RecensioneControl() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	private static RecensioneModelDM model;
	
	static {
		model = new RecensioneModelDM();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String cliente = (String) request.getSession().getAttribute("cliente");
		if(cliente == null) {
			response.sendRedirect("Login");
			return;
		}
		
		int prodotto = 0;
		int rating = 0;
		
		if(request.getParameter("productId") != null) {
			prodotto = Integer.parseInt(request.getParameter("productId"));
		}
		
		if(request.getParameter("rating") != null) {
			rating = Integer.parseInt(request.getParameter("rating"));
		}
		
		String recensione = request.getParameter("recensione");
		String tableName = request.getParameter("type");

		if(prodotto == 0) {
			response.sendRedirect("./");
			return;
		}

		if(recensione == null || rating == 0 || tableName == null) {
			response.sendRedirect("./");
			return;
		}

		Recensione r = new Recensione(cliente, prodotto, recensione, rating);
		
		try {
			model.doSave(r, TABLE.valueOf(tableName));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("ProductDetails?productId=" + prodotto + "&type=" + tableName);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}