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

import net.bookscape.model.Cart;
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.OrderModelDM;
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
	private static OrderModelDM orderModel;
	
	static {
		model = new ClienteModelDM();
		orderModel = new OrderModelDM();
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
				
				if(request.getParameter("option") != null && request.getParameter("option").equals("updateSpedizione")) {
					String nome = request.getParameter("nomeSpedizione");
					String cognome = request.getParameter("cognomeSpedizione");
					
					ordine.setNomeConsegna(nome);
					ordine.setCognomeConsegna(cognome);
					
					String input = request.getParameter("indirizzoSpedizione");
					String[] parts = input.split(",\\s*");
					 
			        if (parts.length == 3) {
			            String via = parts[0];
			            String citta = parts[1];
			            String cap = parts[2];

			            ordine.setVia(via);
			            ordine.setCitta(citta);
			            ordine.setCAP(cap);
			            
			            request.setAttribute("fatturazioneCheckbox", false);
			        }
				} else {
					ordine.setCitta(cliente.getCitta());
					ordine.setVia(cliente.getVia());
					ordine.setCAP(cliente.getCAP());
				}
				
				ordine.setCliente(cliente.getEmail());
				
				request.setAttribute("ordine", ordine);
				request.setAttribute("cliente", cliente);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
				dispatcher.forward(request, response);
			} if(action.equals("acquista")) {
				Cart cart = (Cart) request.getSession().getAttribute("cart");
//				Cliente cliente = model.doRetrieveByKey(clienteId);
				
				Ordine ordine = new Ordine();
				ordine.setProdotti(cart.getItems());
			
				ordine.setNomeConsegna(request.getParameter("nomeConsegna"));
				ordine.setCognomeConsegna(request.getParameter("cognomeConsegna"));
				ordine.setPrezzoTotale();
				ordine.setDataConsegna();
				ordine.setDataOrdine();
				ordine.setVia(request.getParameter("viaConsegna"));
				ordine.setCitta(request.getParameter("cittaConsegna"));
				ordine.setCAP(request.getParameter("capConsegna"));
				ordine.setCliente(clienteId);
				
				orderModel.doSave(ordine);
				
				response.sendRedirect("./");
				
			} if(action.equals("visualizza")) {
				
				Collection<Ordine> ordini = orderModel.doRetrieveAll(clienteId);
				Cliente cliente = model.doRetrieveByKey(clienteId);
				request.setAttribute("ordini", ordini);
				request.setAttribute("cliente", cliente);
				
				RequestDispatcher dispatcher = request.getRequestDispatcher("clientePersonal.jsp");
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
