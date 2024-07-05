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
import net.bookscape.model.CartModelDM;
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.OrderModelDM;
import net.bookscape.model.Ordine;
import utility.ValidationUtilsCliente;

@WebServlet("/OrderControl")
public class OrderControl extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    private static ClienteModelDM model;
    private static OrderModelDM orderModel;
    private static CartModelDM cartModel;
    
    static {
        model = new ClienteModelDM();
        orderModel = new OrderModelDM();
        cartModel = new CartModelDM();
    }
    
    public OrderControl() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String clienteId = (String) request.getSession().getAttribute("cliente");
        if (clienteId == null || clienteId.equals("")) {
            response.sendRedirect("Login");
            return;
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action != null) {
                switch (action) {
                    case "checkout":
                        performCheckout(request, response, clienteId);
                        break;
                    case "acquista":
                        performAcquista(request, response, clienteId);
                        break;
                    case "visualizza":
                        showOrdini(request, response, clienteId);
                        break;
                    default:
                        response.sendRedirect("error404.jsp");
                }
            } else {
            	response.sendRedirect("./");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    private void performCheckout(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException, SQLException {
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        Cliente cliente = model.doRetrieveByKey(clienteId);
        
        Ordine ordine = new Ordine();
        ordine.setProdotti(cart.getItems());
        ordine.setNomeConsegna(cliente.getNome());
        ordine.setCognomeConsegna(cliente.getCognome());
        ordine.setPrezzoTotale();
        ordine.setDataConsegna();
        ordine.setDataOrdine();
        
        if (request.getParameter("option") != null && request.getParameter("option").equals("updateSpedizione")) {
            String nome = request.getParameter("nomeSpedizione");
            String cognome = request.getParameter("cognomeSpedizione");
            String input = request.getParameter("indirizzoSpedizione");
            
			String errorMessage = ValidationUtilsCliente.validateFormShipping(nome, cognome, input);

	        if (errorMessage != null) {
	        	request.setAttribute("errorMessage", errorMessage);
	    		RequestDispatcher dispatcher = request.getRequestDispatcher("OrderControl?action=checkout&option=false");
	    		dispatcher.forward(request, response);
	        	return;
	        }
            
            ordine.setNomeConsegna(nome);
            ordine.setCognomeConsegna(cognome);
            
            String[] parts = input.split(",\\s*");
            
            String via = parts[0];
            String citta = parts[1];
            String cap = parts[2];
            
            ordine.setVia(via);
            ordine.setCitta(citta);
            ordine.setCAP(cap);
                
            request.setAttribute("fatturazioneCheckbox", false);  	
        } else {
        	ordine.setVia(cliente.getVia());
            ordine.setCitta(cliente.getCitta());
            ordine.setCAP(cliente.getCAP());
        }
       
        ordine.setCliente(cliente.getEmail());
        
        request.setAttribute("ordine", ordine);
        request.setAttribute("cliente", cliente);
        
        if (request.getParameter("option") != null && request.getParameter("option").equals("updateSpedizione")) {
        	forward(request, response, "checkout.jsp", "Dati di spedizione aggiornati!", false);
        	return;
        } else {
        	forward(request, response, "checkout.jsp", null, false);
        	return;
        }
    }
    
    private void performAcquista(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException {
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        
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
        
        try {
			orderModel.doSave(ordine);
			forward(request, response, "OrderControl?action=visualizza", "Ordine effettuato!", false);
			cartModel.doDeleteAll(clienteId);
	        request.getSession().removeAttribute("cart");
	        return;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        forward(request, response, "OrderControl?action=visualizza", "Errore nella creazione dell'ordine!", true);

        return;
    }
    
    private void showOrdini(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException, SQLException {
        
        Collection<Ordine> ordini = orderModel.doRetrieveAll(clienteId, true);
        request.setAttribute("ordini", ordini);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("acquisti.jsp");
        dispatcher.forward(request, response);
    }
    
    public void forward(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.setAttribute("feedback-negative", message);
		else request.setAttribute("feedback", message);
		RequestDispatcher dispatcher = request.getRequestDispatcher(redirect);
		dispatcher.forward(request, response);
	}
}
