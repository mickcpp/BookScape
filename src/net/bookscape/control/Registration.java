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

/**
 * Servlet implementation class SignUp
 */
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
		
		Cliente cliente = new Cliente();
		
		cliente.setEmail(request.getParameter("email"));
		cliente.setUsername(request.getParameter("username"));
		cliente.setPassword(request.getParameter("password"));
		cliente.setNome(request.getParameter("nome"));
		cliente.setCognome(request.getParameter("cognome"));
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate data = LocalDate.parse(request.getParameter("dataNascita"), formatter);
		
		Date dataNascitaDate = Date.from(data.atStartOfDay().toInstant(ZoneOffset.UTC));
		
		GregorianCalendar dataNascita = new GregorianCalendar();
		dataNascita.setTime(dataNascitaDate);
		
		cliente.setDataNascita(dataNascita);
		
		cliente.setCitta(request.getParameter("citta"));
		cliente.setVia(request.getParameter("via"));
		cliente.setCAP(request.getParameter("CAP"));
		cliente.setCarta(null);
	
		try {
			model.doSave(cliente);
			request.getSession().setAttribute("cliente", request.getParameter("email"));
			response.sendRedirect("./");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
