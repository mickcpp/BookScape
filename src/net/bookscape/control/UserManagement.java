package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Cliente;
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

		Boolean checkAdmin = (Boolean) request.getSession().getAttribute("adminRole");
		if(checkAdmin == null || !checkAdmin.booleanValue()) {
			response.sendRedirect("./");
			return;
		}
		String action = request.getParameter("action");
		String clienteId = request.getParameter("id");
		String role = request.getParameter("role");
		String clienteInSession = (String) request.getSession().getAttribute("cliente");
		
		try {
			if(action.equalsIgnoreCase("rimuovi")) {
				try {
					model.doDelete(clienteId);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else if(action.equalsIgnoreCase("changeRole")) {
				if(role.equalsIgnoreCase("admin")) model.changeRole(clienteId, "admin");
				else if(role.equalsIgnoreCase("cliente")) model.changeRole(clienteId, "cliente");
				if(clienteInSession.equalsIgnoreCase(clienteId)) {
					response.sendRedirect("Logout");
					return;
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
	
}
