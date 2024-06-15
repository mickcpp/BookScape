package net.bookscape.control;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;

@WebServlet("/RicercaProdotto")
public class RicercaProdotto extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("query");

        Collection<Product> risultato = new ArrayList<>();
        ProductModelDM model = new ProductModelDM();
        Collection<Product> prodotti;

        try {
            prodotti = model.doRetrieveAll(null);
            for(Product p : prodotti) {
                for(int i = 0; i < p.getNome().length() - 1; i++) {
                    for(int j = i + 1; j < p.getNome().length(); j++) {
                        if(((String) p.getNome().subSequence(i, j)).equalsIgnoreCase(query) && !risultato.contains(p)){
                            risultato.add(p);
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String json = new Gson().toJson(risultato);
        response.getWriter().write(json);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}