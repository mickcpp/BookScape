package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;

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
        if (!validateEmail(email)) {
            return "Inserisci un'email valida.";
        }
        if (!validateUsername(username)) {
            if (username.length() < 3) {
                return "L'username deve essere lungo almeno 3 caratteri";
            } else {
                return "L'username può contenere solo lettere, numeri, underscore (_) e punti (.), senza spazi.";
            }
        }
        if (password.length() < 8) {
            return "La password deve essere lunga almeno 8 caratteri.";
        }
        if (!validateName(nome)) {
            if (nome.length() < 3) {
                return "Il nome deve essere lungo almeno 3 caratteri";
            } else {
                return "Il nome può contenere solo lettere (nel caso di due nomi, entrambi lunghi almeno 3 caratteri)";
            }
        }
        if (!validateAlpha(cognome)) {
            return "Il cognome può contenere solo lettere, lungo almeno 3 caratteri, senza spazi.";
        }
        if (!validateDate(dataNascita)) {
            return "Inserisci una data di nascita valida.";
        }
        if (!validateAlphaNumericWithSpaces(citta)) {
            return "La città può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        }
        if (!validateAlphaNumericWithSpaces(via)) {
            return "La via può contenere solo lettere e numeri, lunga almeno 3 caratteri (non può contenere solo numeri).";
        }
        if (!validateCAP(CAP)) {
            return "Inserisci un CAP valido.";
        }
        return null;
    }

    private boolean validateEmail(String email) {
        String regex = "^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$";
        return Pattern.compile(regex).matcher(email).matches();
    }

    private boolean validateUsername(String username) {
        String regex = "^[a-zA-Z0-9_.]{3,}$";
        return Pattern.compile(regex).matcher(username).matches();
    }

    private boolean validateDate(String date) {
        LocalDate currentDate = LocalDate.now();
        LocalDate inputDate = LocalDate.parse(date, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        return inputDate.isBefore(currentDate);
    }

    private boolean validateCAP(String cap) {
        String regex = "^\\d{5}$";
        return Pattern.compile(regex).matcher(cap).matches();
    }

    private boolean validateAlpha(String input) {
        String regex = "^[a-zA-Z]{3,}$";
        return Pattern.compile(regex).matcher(input).matches();
    }

    private boolean validateName(String input) {
        String trimmedInput = input.trim();
        long spaceCount = trimmedInput.chars().filter(ch -> ch == ' ').count();
        if (spaceCount > 1) {
            return false;
        } else if (spaceCount == 1) {
            return trimmedInput.length() >= 7 && trimmedInput.matches("^[a-zA-Z\\s]+$");
        } else {
            return trimmedInput.length() >= 3 && trimmedInput.matches("^[a-zA-Z]+$");
        }
    }

    private boolean validateAlphaNumericWithSpaces(String input) {
        String regex = "^[a-zA-Z0-9\\s]{3,}$";
        boolean containsLetter = Pattern.compile("[a-zA-Z]").matcher(input).find();
        return containsLetter && Pattern.compile(regex).matcher(input).matches();
    }
}
