package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Cart;
import net.bookscape.model.CartModelDM;
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.Wishlist;
import net.bookscape.model.WishlistModelDM;
import utility.ValidationUtilsCliente;

@WebServlet("/Login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public Login() {
		super();
	}	
	
	private static ClienteModelDM model;
	private static String username;
	
	static {
		model = new ClienteModelDM();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		
		if(id == null || password == null) {
			response.sendRedirect("login-form.jsp");
			return;
		}
		
		String errorMessage = ValidationUtilsCliente.validateInputsLogin(id, password);

        if (errorMessage != null) {
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("/login-form.jsp").forward(request, response);
            return;
        }
	        
		boolean checkLogin = false;
		String error = "";
		username = id;
		
		try {
			checkLogin =  checkLogin(id, password, request);
		} catch (Exception e) {
			error = e.getMessage();
		}
		
		if(checkLogin) {
			redirect(request, response, "HomePage", "Benvenuto, " + username + "!", false);
			return;
		} else {
			request.setAttribute("error", error);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/login-form.jsp");
			dispatcher.forward(request, response);
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	private boolean checkLogin(String id, String password, HttpServletRequest request) throws Exception{
		
		Cliente cliente = null;
		cliente = model.doRetrieveByKey(id);

		if(cliente == null) {
			throw new Exception("Username o password errata!");
		} else {
			if((id.equals(cliente.getEmail()) || id.equals(cliente.getUsername())) && model.toHash(password).equals(cliente.getPassword())) {
				Cart cart = new Cart();
				Wishlist wishlist =  new Wishlist();
				try {
					cart.setItems(new CartModelDM().doRetrieveAll(null, cliente.getEmail()));
					wishlist.setItems(new WishlistModelDM().doRetrieveAll(null, cliente.getEmail()));
				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.getSession().setAttribute("cliente", cliente.getEmail());
				request.getSession().setAttribute("cart", cart);
				request.getSession().setAttribute("wishlist", wishlist);
				username = cliente.getUsername();
				
				if(model.isAdmin(cliente.getEmail())) {
					request.getSession().setAttribute("adminRole", true);
				}
				return true;
			} else {
				throw new Exception("Username o password errata!");
			}
		}
	}
	
	private void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
        if (negative) request.getSession().setAttribute("feedback-negative", message);
        else request.getSession().setAttribute("feedback", message);
        response.sendRedirect(redirect);
    }
}
