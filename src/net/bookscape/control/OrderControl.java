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
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.Ordine;

/**
 * Servlet implementation class OrderControl
 */
@WebServlet("/OrderControl")
public class OrderControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    public OrderControl() {
        super();
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
			if(action.equals("checkout")) {
				Cart cart = (Cart) request.getSession().getAttribute("cart");
				Cliente cliente = model.doRetrieveByKey(clienteId);
				
				Ordine ordine = new Ordine();
				ordine.setProdotti(cart.getItems());
				ordine.setNomeConsegna(cliente.getNome());
				ordine.setCognomeConsegna(cliente.getCognome());
				ordine.setPrezzoTotale();
				ordine.setDataConsegna();
				ordine.setDataOrdine();
				ordine.setCitta(cliente.getCitta());
				ordine.setVia(cliente.getVia());
				ordine.setCAP(cliente.getCAP());
				ordine.setCliente(cliente.getEmail());
				
				request.setAttribute("ordine", ordine);
				request.setAttribute("cliente", cliente);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
				dispatcher.forward(request, response);
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
