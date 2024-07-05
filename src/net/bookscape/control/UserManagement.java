package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.ClienteModelDM;

/**
 * Servlet implementation class UserManagement
 */
@WebServlet("/UserManagement")
public class UserManagement extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public UserManagement() {
        super();
    }
    
	private static ClienteModelDM model;
	
	static {
		model = new ClienteModelDM();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		String clienteId = request.getParameter("id");
		String role = request.getParameter("role");
		String clienteInSession = (String) request.getSession().getAttribute("cliente");
		
		try {
			
			if(action.equalsIgnoreCase("rimuovi")) {
				try {
					if(model.doDelete(clienteId)) {
						forward(request, response, "UserControl", "Cliente rimosso correttamente!", false);
						return;
					}
				} catch (SQLException e) {
					forward(request, response, "UserControl", "Errore nella rimozione del cliente!", true);
					return;
				}
				
			} else if(action.equalsIgnoreCase("changeRole")) {
				boolean check = false;
				
				if(role.equalsIgnoreCase("admin")) check = model.changeRole(clienteId, "admin");
				else if(role.equalsIgnoreCase("cliente")) check = model.changeRole(clienteId, "cliente");
				
				if(check) {
					if(clienteInSession.equalsIgnoreCase(clienteId)) {
						response.sendRedirect("Logout");
						return;
					} else {
						forward(request, response, "UserControl", "L'utente '" + clienteId + "' ha cambiato correttamente ruolo in: " + role.toUpperCase() + "!", false);
						return;
					}
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("admin/dashboard.jsp");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void forward(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.setAttribute("feedback-negative", message);
		else request.setAttribute("feedback", message);
		RequestDispatcher dispatcher = request.getRequestDispatcher(redirect);
		dispatcher.forward(request, response);
	}
}
