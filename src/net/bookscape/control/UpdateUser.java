package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import utility.ValidationUtilsCliente;

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
			
			switch (action) {
				case "updatePagamento":
					if(!updatePagamento(request, response, cliente)) return;
					break;
				case "eliminaPagamento":
					eliminaPagamento(cliente);
					break;
				case "updateDatiPersonali":
					if(!updateDatiPersonali(request, response, cliente)) return;
					break;
				case "updateIndirizzo":
					if(!updateIndirizzo(request, response, cliente)) return;
					break;
			}
			model.doUpdate(cliente);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		redirectAfterUpdate(request, response);
	}
	
	private boolean updatePagamento(HttpServletRequest request, HttpServletResponse response, Cliente cliente) throws ServletException, IOException {
	
		String nome = request.getParameter("nomeCarta");
		String numero = request.getParameter("numeroCarta");
		String data = request.getParameter("dataScadenza");
		String cvv = request.getParameter("cvv");
		
		String errorMessage = ValidationUtilsCliente.validatePagamento(nome, numero, data, cvv);

        if (errorMessage != null) {
        	response.sendRedirect("UserControl");
        	return false;
        }
        
		CartaPagamento carta = new CartaPagamento();
		carta.setNomeCarta(nome);
		carta.setNumeroCarta(numero.replaceAll("\\s+", ""));
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM");
		GregorianCalendar dataScadenza = new GregorianCalendar();
		
		try {
			Date date = dateFormat.parse(data);
			dataScadenza.setTime(date);
			int month = dataScadenza.get(GregorianCalendar.MONTH);
			dataScadenza.set(GregorianCalendar.MONTH, month);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		carta.setDataScadenza(dataScadenza);
		carta.setCvv(Integer.parseInt(cvv));
		cliente.setCarta(carta);
		
		return true;
	}

	private void eliminaPagamento(Cliente cliente) {
		cliente.setCarta(null);
	}

	private boolean updateDatiPersonali(HttpServletRequest request, HttpServletResponse response, Cliente cliente) throws ServletException, IOException {
	
		String username = request.getParameter("username");
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String data = request.getParameter("dataNascita");

		String errorMessage = ValidationUtilsCliente.validateDatiPersonali(username, nome, cognome, data);

        if (errorMessage != null) {
        	response.sendRedirect("UserControl");
        	return false;
        }
        
		cliente.setUsername(username);
		cliente.setNome(nome);
		cliente.setCognome(cognome);
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		GregorianCalendar dataNascita = new GregorianCalendar();
		
		try {
			Date date = dateFormat.parse(data);
			dataNascita.setTime(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		dataNascita.set(Calendar.HOUR_OF_DAY, 12);
		dataNascita.set(Calendar.MINUTE, 0);
		dataNascita.set(Calendar.SECOND, 0);
		dataNascita.set(Calendar.MILLISECOND, 0);
		cliente.setDataNascita(dataNascita);
		
		return true;
	}

	private boolean updateIndirizzo(HttpServletRequest request, HttpServletResponse response, Cliente cliente) throws ServletException, IOException {
		String input = request.getParameter("indirizzo");
		String[] parts = input.split(",\\s*");
		
		if (parts.length == 3) {
			String via = parts[0];
			String citta = parts[1];
			String cap = parts[2];
			
			String errorMessage = ValidationUtilsCliente.validateIndirizzo(via, citta, cap);

	        if (errorMessage != null) {
	        	response.sendRedirect("UserControl");
	        	return false;
	        }
			
			cliente.setVia(via);
			cliente.setCitta(citta);
			cliente.setCAP(cap);
		}
		return true;
	}

	private void redirectAfterUpdate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String redirect = request.getParameter("redirect");
		
		if (redirect != null && !redirect.equals("")) {
			if (redirect.equals("checkout.jsp")) {
				response.sendRedirect("OrderControl?action=checkout");
				return;
			}
			response.sendRedirect(redirect);
			return;
		} else {
			response.sendRedirect("./");
			return;
		}
	}
}
