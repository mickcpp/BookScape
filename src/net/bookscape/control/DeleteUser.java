package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.ClienteModelDM;

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
		
		try {
			model.doDelete(email);
			request.getSession().invalidate();
			response.sendRedirect("HomePage");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}