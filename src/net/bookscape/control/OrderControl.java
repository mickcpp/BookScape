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
import utility.ValidationLibraryCliente;

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
            
			String errorMessage = validateFormShipping(nome, cognome, input);

	        if (errorMessage != null) {
	        	response.sendRedirect("OrderControl?action=checkout");
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
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("checkout.jsp");
        dispatcher.forward(request, response);
    }
    
    private void performAcquista(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException, SQLException {
        
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
        
        orderModel.doSave(ordine);
        
        cartModel.doDeleteAll(clienteId);
        request.getSession().removeAttribute("cart");
        
        response.sendRedirect("OrderControl?action=visualizza");
    }
    
    private void showOrdini(HttpServletRequest request, HttpServletResponse response, String clienteId)
            throws ServletException, IOException, SQLException {
        
        Collection<Ordine> ordini = orderModel.doRetrieveAll(clienteId, true);
        request.setAttribute("ordini", ordini);
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("acquisti.jsp");
        dispatcher.forward(request, response);
    }
    
    private String validateFormShipping(String nome, String cognome, String indirizzo) {
        
    	String[] parti = indirizzo.split(",\\s*");
     	var via = "";
	    var citta = "";
	    var CAP = "";
			
        if (!ValidationLibraryCliente.validateName(nome)) {
        	if (nome.length() > 50) {
        		return "Il nome può essere lungo al massimo 50 caratteri";
        	} else if (nome.length() < 3) {
	        	return "Il nome deve essere lungo almeno 3 caratteri";
        	} else{
        		return "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)";
        	}
        }

        if (!ValidationLibraryCliente.validateAlpha(cognome)) {
        	if (cognome.length() > 50) {
        		return "Il cognome può essere lungo al massimo 50 caratteri";
        	} else{
        		return "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.";
        	}
        }
        
        if(parti.length == 3){
			via = parti[0].trim();
		    citta = parti[1].trim();
		    CAP = parti[2].trim();
		} else {
			return "Inserisci un indirizzo valido, rispettando il formato.";
		}
        
        if (!ValidationLibraryCliente.validateCAP(CAP)) {
            return "Inserisci un CAP valido.";
        }
        
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(citta)) {
        	if (citta.length() > 50) {
	        	return "La città può essere lunga al massimo 50 caratteri";
        	} else{
        		return "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(via)) {
        	if (via.length() > 50) {
	        	return "La via può essere lunga al massimo 50 caratteri";
        	} else{
        		return "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        return null;
   	}	
}
