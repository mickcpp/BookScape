package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import utility.ValidationLibraryCliente;

@WebServlet("/Registration")
public class Registration extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static ClienteModelDM model;

    static {
        model = new ClienteModelDM();
    }

    public Registration() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        String dataNascitaParam = request.getParameter("dataNascita");
        String citta = request.getParameter("citta");
        String via = request.getParameter("via");
        String CAP = request.getParameter("CAP");

        String errorMessage = validateInputs(email, username, password, nome, cognome, dataNascitaParam, citta, via, CAP);

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        Cliente cliente = new Cliente();
        cliente.setEmail(email);
        cliente.setUsername(username);
        cliente.setPassword(password);
        cliente.setNome(nome);
        cliente.setCognome(cognome);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate data = LocalDate.parse(dataNascitaParam, formatter);

        Date dataNascitaDate = Date.from(data.atStartOfDay().toInstant(ZoneOffset.UTC));
        GregorianCalendar dataNascita = new GregorianCalendar();
        dataNascita.setTime(dataNascitaDate);

        cliente.setDataNascita(dataNascita);
        cliente.setCitta(citta);
        cliente.setVia(via);
        cliente.setCAP(CAP);
        cliente.setCarta(null);

        try {
            model.doSave(cliente);
            request.getSession().setAttribute("cliente", email);
            response.sendRedirect("./");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private String validateInputs(String email, String username, String password, String nome, String cognome, String dataNascita, String citta, String via, String CAP) {
        if (!ValidationLibraryCliente.validateEmail(email)) {
            return "Inserisci un'email valida.";
        }
        if (!ValidationLibraryCliente.validateUsername(username)) {
        	if (username.length() > 20) {
        		return "L'username può essere lungo al massimo 20 caratteri";
        	} else if (username.length() < 3) {
                return "L'username deve essere lungo almeno 3 caratteri";
            } else {
                return "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.";
            }
        }
        if (password.length() < 8) {
            return "La password deve essere lunga almeno 8 caratteri.";
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
}
