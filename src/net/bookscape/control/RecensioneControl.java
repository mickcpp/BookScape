package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.bookscape.model.CsrfTokens;
import net.bookscape.model.Product;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.Recensione;
import net.bookscape.model.RecensioneModelDM;
import net.bookscape.model.TABLE;

/**
 * Servlet implementation class RecensioneControl
 */
@WebServlet("/RecensioneControl")
public class RecensioneControl extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public RecensioneControl() {
        super();
    }

    private static RecensioneModelDM model;
    private static ProductModelDM modelProduct;

    static {
        model = new RecensioneModelDM();
        modelProduct = new ProductModelDM();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cliente = (String) request.getSession().getAttribute("cliente");
        if (cliente == null) {
            response.sendRedirect("Login");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || !action.equals("visualizza")) {
            response.sendRedirect("./");
            return;
        }

        int prodotto = getProdotto(request);
        String tableName = request.getParameter("type");

        if (prodotto == 0 || tableName == null) {
            response.sendRedirect("./");
            return;
        }

        showRecensioni(request, response, prodotto, tableName);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cliente = (String) request.getSession().getAttribute("cliente");
        if (cliente == null) {
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
        if (action == null) {
            response.sendRedirect("./");
            return;
        }

        int prodotto = getProdotto(request);
        int rating = getValutazione(request);
        String recensione = request.getParameter("recensione");
        String tableName = request.getParameter("type");

        if (prodotto == 0 || tableName == null) {
            response.sendRedirect("./");
            return;
        }

        String redirect = "ProductDetails?productId=" + prodotto + "&type=" + tableName;

        if (rating == 0 && !action.equals("delete")) {
            request.getSession().setAttribute("errorMessage", "Per favore, seleziona almeno una valutazione");
            response.sendRedirect(redirect);
            return;
        }

        switch (action) {
            case "insert":
                String error = validate(recensione, rating);
                if (error != null) {
                    request.getSession().setAttribute("errorMessage", error);
                    response.sendRedirect(redirect);
                    return;
                }
                insertRecensione(request, response, cliente, prodotto, recensione, rating, tableName, redirect);
                break;
            case "delete":
                deleteRecensione(request, response, cliente, prodotto, tableName, redirect);
                break;
            case "update":
                if (validate(recensione, rating) != null) {
                    response.sendRedirect(redirect);
                    return;
                }
                updateRecensione(response, cliente, prodotto, recensione, rating, tableName, redirect);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    private void insertRecensione(HttpServletRequest request, HttpServletResponse response, String cliente, int prodotto, String recensione, int rating, String tableName, String redirect) throws ServletException, IOException {
        Recensione r = new Recensione(cliente, prodotto, recensione, rating);

        try {
            model.doSave(r, TABLE.valueOf(tableName));
            redirect(request, response, redirect, "Recensione effettuata!", false);
            return;
        } catch (SQLException e) {
            redirect(request, response, redirect, "Errore nell'invio della recensione!", true);
            return;
        }
    }

    private void deleteRecensione(HttpServletRequest request, HttpServletResponse response, String cliente, int prodotto, String tableName, String redirect) throws ServletException, IOException {
        try {
            boolean check = model.doDelete(cliente, prodotto, TABLE.valueOf(tableName));
            if (check) {
                redirect(request, response, redirect, "Recensione eliminata!", false);
                return;
            } else {
                redirect(request, response, redirect, "Errore nell'eliminazione della recensione!", true);
                return;
            }
        } catch (SQLException e) {
            redirect(request, response, redirect, "Errore nell'eliminazione della recensione!", true);
            return;
        }
    }

    private void updateRecensione(HttpServletResponse response, String cliente, int prodotto, String recensione, int rating, String tableName, String redirect) throws ServletException, IOException {
        response.sendRedirect(redirect);
        return;
    }

    private void showRecensioni(HttpServletRequest request, HttpServletResponse response, int productId, String tableName) throws ServletException, IOException {
        Collection<Recensione> recensioni = null;
        Product product = null;

        try {
            recensioni = model.doRetrieveAll(productId, TABLE.valueOf(tableName), "Data");
            product = modelProduct.doRetrieveByKey(productId, TABLE.valueOf(tableName));
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("recensioni", recensioni);
        request.setAttribute("prodotto", product);

        RequestDispatcher dispatcher = request.getRequestDispatcher("Recensioni.jsp");
        dispatcher.forward(request, response);
    }

    private int getProdotto(HttpServletRequest request) throws IOException {
        int prodotto = 0;
        if (request.getParameter("productId") != null) {
            prodotto = Integer.parseInt(request.getParameter("productId"));
        }
        return prodotto;
    }

    private int getValutazione(HttpServletRequest request) throws IOException {
        int rating = 0;
        if (request.getParameter("rating") != null) {
            rating = Integer.parseInt(request.getParameter("rating"));
        }
        return rating;
    }

    private String validate(String recensione, int valutazione) {
        if (valutazione < 1 || valutazione > 5) {
            return "Errore nell'inserimento della valutazione!";
        }
        if (recensione.length() > 1000) {
            return "La recensione può essere lunga al massimo 1000 caratteri.";
        }
        return null;
    }

    public void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
        if (negative) request.getSession().setAttribute("feedback-negative", message);
        else request.getSession().setAttribute("feedback", message);
        response.sendRedirect(redirect);
    }
}