package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import net.bookscape.model.CartaPagamento;
import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.CsrfTokens;
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
        
		String action = request.getParameter("action");
		Cliente cliente = null;
		
		String redirect = request.getParameter("redirect");
		if (redirect == null) {
			redirect = "./";
		}
	
		try {
			cliente = model.doRetrieveByKey(clienteId);
			
			switch (action) {
				case "updatePagamento":
					updatePagamento(request, response, cliente, redirect);
					break;
				case "eliminaPagamento":
					eliminaPagamento(request, response, cliente, redirect);
					break;
				case "updateDatiPersonali":
					try {
						updateDatiPersonali(request, response, cliente, redirect);
					} catch (SQLException e) {
						String error = "";
						if (e.getErrorCode() == 1062 && e.getMessage().contains("Username")) {
			            	error = "Errore: username già esistente!";
			            } else {
			            	error = "Si è verificato un errore durante la registrazione.";
			            }
						redirect(request, response, redirect, error, true);
						return;
					}
					break;
				case "updateIndirizzo":
					updateIndirizzo(request, response, cliente, redirect);
					break;
			}
				
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private void updatePagamento(HttpServletRequest request, HttpServletResponse response, Cliente cliente, String redirect) throws ServletException, IOException, SQLException {
	
		String nome = request.getParameter("nomeCarta");
		String numero = request.getParameter("numeroCarta");
		String data = request.getParameter("dataScadenza");
		String cvv = request.getParameter("cvv");
		
		String errorMessage = ValidationUtilsCliente.validatePagamento(nome, numero, data, cvv);

        if (errorMessage != null) {
        	request.setAttribute("errorMessage", errorMessage);
        	response.sendRedirect(redirect);
        	return;
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
	
		if(model.doUpdate(cliente) > 0) {
			redirect(request, response, redirect, "Metodo di pagamento aggiunto!", false);
			return;
		} else {
			redirect(request, response, redirect, "Errore nell'aggiunta del metodo di pagamento!", true);
			return;
		}
	}

	private void eliminaPagamento(HttpServletRequest request, HttpServletResponse response, Cliente cliente, String redirect) throws SQLException, ServletException, IOException {
		cliente.setCarta(null);
		if(model.doUpdate(cliente) > 0) {
			redirect(request, response, redirect, "Metodo di pagamento eliminato!", false);
			return;
		} else {
			redirect(request, response, redirect, "Errore nell'eliminazione del metodo di pagamento!", true);
			return;
		}
	}

	private void updateDatiPersonali(HttpServletRequest request, HttpServletResponse response, Cliente cliente, String redirect) throws ServletException, IOException, SQLException {
	
		String username = request.getParameter("username");
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String data = request.getParameter("dataNascita");

		String errorMessage = ValidationUtilsCliente.validateDatiPersonali(username, nome, cognome, data);

        if (errorMessage != null) {
        	request.setAttribute("errorMessage", errorMessage);
        	response.sendRedirect(redirect);
        	return;
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
		
		if(model.doUpdate(cliente) > 0) {
			redirect(request, response, redirect, "Dati aggiornati correttamente!", false);
			return;
		} else {
			redirect(request, response, redirect, "Errore nell'aggiornamento dei dati!", true);
			return;
		}
	}

	private void updateIndirizzo(HttpServletRequest request, HttpServletResponse response, Cliente cliente, String redirect) throws ServletException, IOException, SQLException {
		String input = request.getParameter("indirizzo");
		String[] parts = input.split(",\\s*");
		
		if (parts.length == 3) {
			String via = parts[0];
			String citta = parts[1];
			String cap = parts[2];
			
			String errorMessage = ValidationUtilsCliente.validateIndirizzo(via, citta, cap);

	        if (errorMessage != null) {
	        	request.setAttribute("errorMessage", errorMessage);
	        	response.sendRedirect(redirect);
	        	return;
	        }
			
			cliente.setVia(via);
			cliente.setCitta(citta);
			cliente.setCAP(cap);
		} else {
			request.setAttribute("errorMessage", "Inserisci un indirizzo valido, rispettando il formato.");
			response.sendRedirect(redirect);
        	return;
		}
		
		if(model.doUpdate(cliente) > 0) {
			redirect(request, response, redirect, "Indirizzo aggiornato correttamente!", false);
			return;
		} else {
			redirect(request, response, redirect, "Errore nell'aggiornamento dell'indirizzo!", true);
			return;
		}
	}
	
	public void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.getSession().setAttribute("feedback-negative", message);
		else request.getSession().setAttribute("feedback", message);
		response.sendRedirect(redirect);
	}
}
