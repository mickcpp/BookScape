package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.ProductModelDM;
import net.bookscape.model.TABLE;
import net.bookscape.model.Cart;
import net.bookscape.model.CartItem;
import net.bookscape.model.CartModelDM;

/**
 * Servlet implementation class ProductDetails
 */
@WebServlet("/CartControl")
public class CartControl extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	private static ProductModelDM productModel;
	private static CartModelDM cartModel;
	
	static {
		productModel = new ProductModelDM();
		cartModel =  new CartModelDM();
	}
	
    public CartControl() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
        String userId = (String) request.getSession().getAttribute("cliente");
        Cart cart = (Cart)request.getSession().getAttribute("cart");
        int id = 0;
        
        if(request.getParameter("productId") != null){
        	id = Integer.parseInt(request.getParameter("productId"));
        }
      
        if(userId != null && !userId.equals("")) {
        	try {
				if(cart == null) {
	        		cart = new Cart();
	        		cart.setItems(cartModel.doRetrieveAll(null, userId));
	        		request.getSession().setAttribute("cart", cart);
	        	}
			} catch (SQLException e) {
				e.printStackTrace();
			}
        }
                	
        if(cart == null) {
			cart = new Cart();
			request.getSession().setAttribute("cart", cart);
        }
		
		String action = request.getParameter("action");
		String tableName = request.getParameter("type");
		
		try {
			if (action != null) {
				
				if (action.equalsIgnoreCase("Aggiungi")) {
					CartItem item =  new CartItem(productModel.doRetrieveByKey(id, TABLE.valueOf(tableName)));
					if(cart.isInCart(item)) {
						if(cart.getItem(id).getNumElementi() < 10) {
							cart.incrementItem(item);
							if(userId != null && !userId.equals("")) {
								cartModel.doUpdate(cart.getItem(id), userId);
							}
						} else {
							System.out.println("Raggiunto numero limite del prodotto nel carrello!");
						}
					} else {
						cart.addItem(item);
						if(userId != null && !userId.equals("")) {
							cartModel.doSave(cart.getItem(id), userId);
						}
					}
					
				} else if (action.equalsIgnoreCase("Rimuovi")) {
					CartItem item = new CartItem(productModel.doRetrieveByKey(id, TABLE.valueOf(tableName)));
					cart.deleteItem(item);
					
					if(userId != null && !userId.equals("")) {
						cartModel.doDelete(id, userId);
					}
					
				} else if (action.equalsIgnoreCase("Aggiorna")) {
					CartItem item = new CartItem(productModel.doRetrieveByKey(id, TABLE.valueOf(tableName)));
					int num = Integer.parseInt(request.getParameter("quantity"));
					cart.updateItemNum(item, num);
					
					if(userId != null && !userId.equals("")) {
						cartModel.doUpdate(cart.getItem(id), userId);
					}
				}
			}	
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		
		String redirect = (String)request.getParameter("redirect");
		
		if(redirect != null && !redirect.equals("")) {
			response.sendRedirect(redirect);
		}else {
			response.sendRedirect("./");
		}
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}