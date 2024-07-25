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
 * Servlet implementation class DeleteUser
 */
@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
    public DeleteUser() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	private static ClienteModelDM model;
	
	static {
		model = new ClienteModelDM();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = (String) request.getSession().getAttribute("cliente");
		if(email == null) {
			response.sendRedirect("./");
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
        
		String redirect = "";
		if(request.getSession().getAttribute("adminRole") != null) {
			redirect = "UserControl?personalAreaAdmin=true";
		} else {
			redirect = "UserControl";
		}
		
		try{
			boolean check = model.doDelete(email);
			if(check) {
				request.getSession().invalidate();
				redirect(request, response, "HomePage", "Account eliminato correttamente!", false);
				return;
			} else {
				redirect(request, response, redirect, "Errore nell'eliminazione dell'account!", true);
				return;
			}
		} catch (SQLException e) {
			if(redirect.equals("UserControl")) {
				redirect(request, response, redirect, "Errore nell'eliminazione dell'account!", true);
				return;
			} else {
				redirect(request, response, redirect, "Errore nell'eliminazione dell'account; per motivi di sicurezza, devi cambiare il tuo ruolo in 'CLIENTE' prima di poter eliminare il tuo account!", true);
				return;
			}
		}
	}
	
	public void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.getSession().setAttribute("feedback-negative", message);
		else request.getSession().setAttribute("feedback", message);
		response.sendRedirect(redirect);
	}
}