package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
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
		
		GregorianCalendar dataNascita = new GregorianCalendar();
		Date date = null;
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(request.getParameter("dataNascita"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		dataNascita.setTime(date);
		
		cliente.setDataNascita(dataNascita);
		
		cliente.setCitta(request.getParameter("citta"));
		cliente.setVia(request.getParameter("via"));
		cliente.setCAP(request.getParameter("CAP"));
		cliente.setCarta(null);
	
		try {
			model.doSave(cliente);
			request.getSession().setAttribute("cliente", request.getParameter("username"));
			response.sendRedirect("./");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
