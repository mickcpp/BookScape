package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.CsrfTokens;

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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action = request.getParameter("action");
		String clienteId = request.getParameter("id");
		String role = request.getParameter("role");
		String clienteInSession = (String) request.getSession().getAttribute("cliente");

		if(action == null) {
			response.sendRedirect("admin/dashboard.jsp");
			return;
		}
		
        CsrfTokens csrfTokens = (CsrfTokens) request.getSession().getAttribute("csrfTokens");
        
        if (csrfTokens == null) {
            // Se non ci sono token, non è valido
            response.sendRedirect("./");
            return;
        }

        String csrfToken = request.getParameter("csrfToken");
        
        if (csrfToken == null || !csrfTokens.containsToken(csrfToken)) {
            response.sendRedirect("./");
            return;
        }

        // Se il token è valido, rimuovilo dalla lista
        csrfTokens.removeToken(csrfToken);
        request.getSession().setAttribute("csrfTokens", csrfTokens);
        
		try {	
			if(action.equalsIgnoreCase("rimuovi")) {		        
				try {
					if(model.doDelete(clienteId)) {
						redirect(request, response, "UserControl", "Cliente rimosso correttamente!", false);
						return;
					} else {
						redirect(request, response, "UserControl", "Errore nella rimozione del cliente!", true);
						return;
					}
				} catch (SQLException e) {
					redirect(request, response, "UserControl", "Errore nella rimozione del cliente!", true);
					return;
				}
				
			} else if(action.equalsIgnoreCase("changeRole")) {
				boolean check = false;
				
				try {
					if(role.equalsIgnoreCase("admin")) check = model.changeRole(clienteId, "admin");
					else if(role.equalsIgnoreCase("cliente")) check = model.changeRole(clienteId, "cliente");
				
					if(check) {
						if(clienteInSession.equalsIgnoreCase(clienteId)) {
							response.sendRedirect("Logout");
							return;
						} else {
							redirect(request, response, "UserControl", "L'utente '" + clienteId + "' ha cambiato correttamente ruolo in: " + role.toUpperCase() + "!", false);
							return;
						}
					} else {
						redirect(request, response, "UserControl", "Errore nella modifica del ruolo!", true);
						return;
					}
				} catch (SQLException e) {
					e.printStackTrace();
					redirect(request, response, "UserControl", "Errore nella rimozione del cliente!", true);
					return;
				}		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.sendRedirect("admin/dashboard.jsp");
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	public void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.getSession().setAttribute("feedback-negative", message);
		else request.getSession().setAttribute("feedback", message);
		response.sendRedirect(redirect);
	}
}