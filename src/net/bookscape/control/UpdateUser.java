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
import utility.ValidationLibraryCliente;

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
					updatePagamento(request, response, cliente);
					break;
				case "eliminaPagamento":
					eliminaPagamento(cliente);
					break;
				case "updateDatiPersonali":
					updateDatiPersonali(request, response, cliente);
					break;
				case "updateIndirizzo":
					updateIndirizzo(request, response, cliente);
					break;
			}
			model.doUpdate(cliente);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		redirectAfterUpdate(request, response);
	}
	
	private void updatePagamento(HttpServletRequest request, HttpServletResponse response, Cliente cliente) throws ServletException, IOException {
	
		String nome = request.getParameter("nomeCarta");
		String numero = request.getParameter("numeroCarta");
		String data = request.getParameter("dataScadenza");
		String cvv = request.getParameter("cvv");
		
		String errorMessage = validatePagamento(nome, numero, data, cvv);

        if (errorMessage != null) {
        	response.sendRedirect("UserControl");
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
			dataScadenza.set(GregorianCalendar.MONTH, month + 1);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		carta.setDataScadenza(dataScadenza);
		carta.setCvv(Integer.parseInt(cvv));
		cliente.setCarta(carta);
	}

	private void eliminaPagamento(Cliente cliente) {
		cliente.setCarta(null);
	}

	private void updateDatiPersonali(HttpServletRequest request, HttpServletResponse response, Cliente cliente) throws ServletException, IOException {
	
		String username = request.getParameter("username");
		String nome = request.getParameter("nome");
		String cognome = request.getParameter("cognome");
		String data = request.getParameter("dataNascita");

		String errorMessage = validateDatiPersonali(username, nome, cognome, data);

        if (errorMessage != null) {
        	response.sendRedirect("UserControl");
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
	}

	private void updateIndirizzo(HttpServletRequest request, HttpServletResponse response, Cliente cliente) throws ServletException, IOException {
		String input = request.getParameter("indirizzo");
		String[] parts = input.split(",\\s*");
		
		if (parts.length == 3) {
			String via = parts[0];
			String citta = parts[1];
			String cap = parts[2];
			
			String errorMessage = validateIndirizzo(via, citta, cap);

	        if (errorMessage != null) {
	        	response.sendRedirect("UserControl");
	        	return;
	        }
			
			cliente.setVia(via);
			cliente.setCitta(citta);
			cliente.setCAP(cap);
		}
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
	
    private String validateDatiPersonali(String username, String nome, String cognome, String dataNascita) {
     
        if (!ValidationLibraryCliente.validateUsername(username)) {
        	if (username.length() > 20) {
        		return "L'username può essere lungo al massimo 20 caratteri";
        	} else if (username.length() < 3) {
                return "L'username deve essere lungo almeno 3 caratteri";
            } else {
                return "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.";
            }
        }
      
        if (!ValidationLibraryCliente.validateName(nome)) {
        	if (nome.length() > 50) {
        		return "Il nome può essere lungo al massimo 50 caratteri";
        	} else if (nome.length() < 3) {
                return "Il nome deve essere lungo almeno 3 caratteri";
            } else {
                return "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)";
            }
        }
        if (!ValidationLibraryCliente.validateAlpha(cognome)) {
        	if (cognome.length() > 50) {
        		return "Il cognome può essere lungo al massimo 50 caratteri";
        	} else {
        		 return "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.";
        	}
        }
        if (!ValidationLibraryCliente.validateDate(dataNascita)) {
            return "Inserisci una data di nascita valida.";
        }
        
        return null;
    }
    
    private String validateIndirizzo(String via, String citta, String CAP) {
    	
    	if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(citta)) {
        	if (citta.length() > 50) {
        		return "La città può essere lunga al massimo 50 caratteri";
        	} else {
                return "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        if (!ValidationLibraryCliente.validateAlphaNumericWithSpaces(via)) {
        	if (via.length() > 50) {
        		return "La via può essere lunga al massimo 50 caratteri";
        	} else {
                return "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        	}
        }
        if (!ValidationLibraryCliente.validateCAP(CAP)) {
            return "Inserisci un CAP valido.";
        }
        
        return null;
    }

    private String validatePagamento(String nomeCarta, String numeroCarta, String dataScadenza, String cvv) {
    	
    	if (!ValidationLibraryCliente.validateName(nomeCarta)) {
        	return "Inserisci un nome valido.";
        }
        if (!ValidationLibraryCliente.isValidCardNumber(numeroCarta)) {
        	return "Inserisci un numero di carta valido (Visa/Mastercard).";
        }
        if (!ValidationLibraryCliente.validateDataScadenza(dataScadenza)) {
        	return "La carta di credito è scaduta o la data di scadenza non è nel formato corretto.";
        }
        if (!ValidationLibraryCliente.validateCvv(cvv)) {
            return "Inserisci un cvv valido.";
        }
        
        return null;
    }
}
