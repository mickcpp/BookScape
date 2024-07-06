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
import utility.ValidationUtilsCliente;

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

        String errorMessage = ValidationUtilsCliente.validateInputsSignup(email, username, password, nome, cognome, dataNascitaParam, citta, via, CAP);

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
            redirect(request, response, "HomePage", "Registrazione effettuata!", false);
        } catch (SQLException e) {
            e.printStackTrace();
            redirect(request, response, "HomePage", e.getMessage(), true);
        }
    }
    
    private void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
        if (negative) request.getSession().setAttribute("feedback-negative", message);
        else request.getSession().setAttribute("feedback", message);
        response.sendRedirect(redirect);
    }
}
