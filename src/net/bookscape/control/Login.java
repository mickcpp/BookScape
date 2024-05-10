package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;

@WebServlet("/Login")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	public Login() {
		super();
	}	
	
	private static ClienteModelDM model;
	
	static {
		model = new ClienteModelDM();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		boolean checkLogin = false;
		String error = "";
	
		if(id == null || password == null) {
			response.sendRedirect("login-form.jsp");
			return;
		}
		
		try {
			checkLogin =  checkLogin(id, password);
		} catch (Exception e) {
			error = e.getMessage();
		}
		
		if(checkLogin) {
			request.getSession().setAttribute("cliente", id);
			response.sendRedirect("./");
		}else {
			request.setAttribute("error", error);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/login-form.jsp");
			dispatcher.forward(request, response);
		}
	}

	private boolean checkLogin(String id, String password) throws Exception{
		
		Cliente cliente = null;
		cliente = model.doRetrieveByKey(id);
		
		if(cliente == null) {
			throw new Exception("username o password errati!");
		} else {
			if((id.equals(cliente.getEmail()) || id.equals(cliente.getUsername())) && model.toHash(password).equals(cliente.getPassword())) {
				return true;
			}else {
				throw new Exception("username o password errati!");
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
	
}
