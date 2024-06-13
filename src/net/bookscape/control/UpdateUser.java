package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.CartaPagamento;
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;

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
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String clienteId = (String) request.getSession().getAttribute("cliente");
		if(clienteId == null || clienteId.equals("")) {
			response.sendRedirect("Login");
			return;
		}
		
		String action = request.getParameter("action");
		Cliente cliente = null;
	
		try {
			cliente = model.doRetrieveByKey(clienteId);
			
			if(action.equals("updatePagamento")) {
				CartaPagamento carta = new CartaPagamento();
				carta.setNomeCarta(request.getParameter("nomeCarta"));
				carta.setNumeroCarta(request.getParameter("numeroCarta"));
				
		        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
		        GregorianCalendar dataScadenza = new GregorianCalendar();
		        
		        try {
		            // Analizza la stringa in una data (senza giorno)
		            Date date = dateFormat.parse(request.getParameter("dataScadenza"));
		            // Imposta la data analizzata in dataScadenza
		            dataScadenza.setTime(date);
		            // Incrementa il mese di 1 perché GregorianCalendar usa i mesi indicizzati a partire da 0
	                int month = dataScadenza.get(GregorianCalendar.MONTH);
	                dataScadenza.set(GregorianCalendar.MONTH, month + 1);

		        } catch (ParseException e) {
		            e.printStackTrace();
		        }
		        
		        // Imposta dataScadenza in carta
		        carta.setDataScadenza(dataScadenza);
				carta.setCvv(Integer.parseInt(request.getParameter("cvv")));
				
				cliente.setCarta(carta);
				
				model.doUpdate(cliente);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		String redirect = (String)request.getParameter("redirect");
		
		if(redirect != null && !redirect.equals("")) {
			if(redirect.equals("checkout.jsp")) {
				response.sendRedirect("OrderControl?action=checkout");
				return;
			}
			response.sendRedirect(redirect);
		}else {
			response.sendRedirect("./");
		}
		
	}

}
