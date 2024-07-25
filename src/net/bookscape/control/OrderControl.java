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
import net.bookscape.model.CsrfTokens;
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
                    case "visualizza":
                        showOrdini(request, response, clienteId);
                        break;
                    case "checkout":
                        performCheckout(request, response, clienteId);
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
        String clienteId = (String) request.getSession().getAttribute("cliente");
        if (clienteId == null || clienteId.equals("")) {
            response.sendRedirect("Login");
            return;
        }

        String action = request.getParameter("action");
        
        try {
        	if (action != null) {
                if ("acquista".equals(action)) {
                    performAcquista(request, response, clienteId);
                } else if("checkout".equals(action)){
                	performCheckout(request, response, clienteId);
                } else {
                    response.sendRedirect("error404.jsp");
                }
            } else {
                response.sendRedirect("./");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    private void performCheckout(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException, SQLException {
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if(cart == null) {
        	response.sendRedirect("Cart.jsp");
        	return;
        }
        
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
            	request.getSession().setAttribute("errorMessage", errorMessage);
        		response.sendRedirect("OrderControl?action=checkout&option=false");
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
            
            request.getSession().setAttribute("fatturazioneCheckbox", false);  	
        } else {
        	ordine.setVia(cliente.getVia());
            ordine.setCitta(cliente.getCitta());
            ordine.setCAP(cliente.getCAP());
        }
       
        ordine.setCliente(cliente.getEmail());
        
        request.setAttribute("ordine", ordine);
        request.setAttribute("clienteOrder", cliente);
        
        if (request.getParameter("option") != null && request.getParameter("option").equals("updateSpedizione")) {
        	request.getSession().setAttribute("feedback", "Dati di spedizione aggiornati!");
        	RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
        	dispatcher.forward(request, response);
        	return;
        } else {
        	RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
        	dispatcher.forward(request, response);
        	return;
        }
    }
    
    private void performAcquista(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException {
        
        Cart cart = (Cart) request.getSession().getAttribute("cart");
        if(cart == null) {
        	redirect(request, response, "OrderControl?action=visualizza", "Errore nella creazione dell'ordine!", true);
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
			redirect(request, response, "OrderControl?action=visualizza", "Ordine effettuato!", false);
			cartModel.doDeleteAll(clienteId);
	        request.getSession().removeAttribute("cart");
	        return;
		} catch (SQLException e) {
			e.printStackTrace();
		}
        
        redirect(request, response, "OrderControl?action=visualizza", "Errore nella creazione dell'ordine!", true);
        return;
    }
    
    private void showOrdini(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException, SQLException {
        
        Collection<Ordine> ordini = orderModel.doRetrieveAll(clienteId, true);
        request.setAttribute("ordini", ordini);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("acquisti.jsp");
        dispatcher.forward(request, response);
    }
    
    public void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.getSession().setAttribute("feedback-negative", message);
		else request.getSession().setAttribute("feedback", message);
		response.sendRedirect(redirect);
    }
}