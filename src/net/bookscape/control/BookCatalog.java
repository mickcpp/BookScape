package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Libro;
import net.bookscape.model.ProductModelDM;

/**
 * Servlet implementation class BookCatalog
 */
@WebServlet("/BookCatalog")
public class BookCatalog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BookCatalog() {
        super();
    }
    
	private static ProductModelDM model;
	
	static {
		model = new ProductModelDM();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Collection<Libro> libri = null;
		
		try {
			libri = model.doRetrieveAllLibro(null);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		request.setAttribute("libri", libri);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("bookCatalog.jsp");
		dispatcher.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
}
