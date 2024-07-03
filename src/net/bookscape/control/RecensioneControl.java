package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;
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
	private static ProductModelDM modelProduct;
	
	static {
		model = new RecensioneModelDM();
		modelProduct = new ProductModelDM();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String cliente = (String) request.getSession().getAttribute("cliente");
		if(cliente == null) {
			response.sendRedirect("Login");
			return;
		}
		
		String action = request.getParameter("action");
		if(action == null) {
			response.sendRedirect("./");
			return;
		}
		
		int prodotto = getProdotto(request);
		int rating = getValutazione(request);
		
		String recensione = request.getParameter("recensione");
		String tableName = request.getParameter("type");

		if(prodotto == 0 || tableName == null) {
			response.sendRedirect("./");
			return;
		}

		if(rating == 0 && !action.equals("visualizza")) {
			response.sendRedirect("ProductDetails?productId=" + prodotto + "&type=" + tableName);
			return;
		}
		
		switch(action) {
			case "insert":
				insertRecensione(response, cliente, prodotto, recensione, rating, tableName);
				break;
			case "delete":
				deleteRecensione(response, cliente, prodotto, recensione, rating, tableName);
				break;
			case "update":
				updateRecensione(response, cliente, prodotto, recensione, rating, tableName);
				break;
			case "visualizza":
				showRecensioni(request, response, prodotto, tableName);
				break;
			default:
				response.sendRedirect("./");
				break;
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private void insertRecensione(HttpServletResponse response, String cliente, int prodotto, String recensione, int rating, String tableName) throws ServletException, IOException {

		Recensione r = new Recensione(cliente, prodotto, recensione, rating);
		
		try {
			model.doSave(r, TABLE.valueOf(tableName));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		response.sendRedirect("ProductDetails?productId=" + prodotto + "&type=" + tableName);
		return;
	}
	
	private void deleteRecensione(HttpServletResponse response, String cliente, int prodotto, String recensione, int rating, String tableName) throws ServletException, IOException {
		response.sendRedirect("ProductDetails?productId=" + prodotto + "&type=" + tableName);
		return;	
	}
	
	private void updateRecensione(HttpServletResponse response, String cliente, int prodotto, String recensione, int rating, String tableName) throws ServletException, IOException {
		response.sendRedirect("ProductDetails?productId=" + prodotto + "&type=" + tableName);
		return;	
	}
	
	private void showRecensioni(HttpServletRequest request,HttpServletResponse response, int productId, String tableName) throws ServletException, IOException {
		Collection<Recensione> recensioni = null;
		Product product = null;
		
		try {
			recensioni = model.doRetrieveAll(productId,TABLE.valueOf(tableName));
			product = modelProduct.doRetrieveByKey(productId, TABLE.valueOf(tableName));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("recensioni", recensioni);
		request.setAttribute("prodotto", product);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Recensioni.jsp");
		dispatcher.forward(request, response);
	}
	
	private int getProdotto(HttpServletRequest request) throws IOException {
		int prodotto = 0;
		if(request.getParameter("productId") != null) {
			prodotto = Integer.parseInt(request.getParameter("productId"));
		}
		return prodotto;
	}
	
	private int getValutazione(HttpServletRequest request) throws IOException {
		int prodotto = 0;
		if(request.getParameter("rating") != null) {
			prodotto = Integer.parseInt(request.getParameter("rating"));
		}
		return prodotto;
	}
}
