package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import net.bookscape.model.Cliente;
import net.bookscape.model.ClienteModelDM;
import net.bookscape.model.OrderModelDM;
import net.bookscape.model.Ordine;
import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;

/**
 * Servlet implementation class UserControl
 */
@WebServlet("/UserControl")
public class UserControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	private static ClienteModelDM clienteModel;
	private static ProductModelDM productModel;
	private static OrderModelDM orderModel;
	
	static {
		clienteModel = new ClienteModelDM();
		productModel = new ProductModelDM();
		orderModel = new OrderModelDM();
	}
	
    public UserControl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String user = (String) request.getSession().getAttribute("cliente");
		if(user == null || user.equals("")) {
			response.sendRedirect("Login");
		} else {
			try {
				Cliente cliente = (Cliente) clienteModel.doRetrieveByKey(user);
				Collection<Ordine> ordini = orderModel.doRetrieveAll(user, false);
				request.setAttribute("cliente", cliente);
				request.setAttribute("ordini", ordini);
				
				Boolean checkAdmin = (Boolean) request.getSession().getAttribute("adminRole");
			
				if(checkAdmin != null && checkAdmin.booleanValue() && (request.getParameter("personalAreaAdmin") == null)) {
					Collection<Cliente> clienti = clienteModel.doRetrieveAll(null);
					Collection<Product> prodotti = productModel.doRetrieveAll(null);
					Collection<String> listaAdmin = clienteModel.doRetrieveAllAdmin();
					ordini = orderModel.doRetrieveAll(null, false);
					
					request.setAttribute("clienti", clienti);
					request.setAttribute("prodotti", prodotti);
					request.setAttribute("listaAdmin", listaAdmin);
					request.setAttribute("ordini", ordini);
					
					RequestDispatcher dispatcher = request.getRequestDispatcher("admin/dashboard.jsp");
					dispatcher.forward(request, response);
					
				} else {
					RequestDispatcher dispatcher = request.getRequestDispatcher("clientePersonal.jsp");
					dispatcher.forward(request, response);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
}
