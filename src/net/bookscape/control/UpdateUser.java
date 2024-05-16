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
import net.bookscape.model.CartaPagamento;
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.Ordine;

/**
 * Servlet implementation class UpdateUser
 */
@WebServlet("/UpdateUser")
public class UpdateUser extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public UpdateUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	private static ClienteModelDM model;
	
	static {
		model = new ClienteModelDM();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String clienteId = (String) request.getSession().getAttribute("cliente");
		if(clienteId == null || clienteId.equals("")) {
			response.sendRedirect("Login");
			return;
		}
		
		String action = request.getParameter("action");
	
		try {
			if(action.equals("updatePagamento")) {
				CartaPagamento carta = new CartaPagamento();
//				model.doUpdate(clienteId);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
