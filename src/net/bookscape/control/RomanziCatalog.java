package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Map;
import java.util.stream.Collectors;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import net.bookscape.model.Libro;
import net.bookscape.model.ProductModelDM;
import net.bookscape.model.RecensioneModelDM;

@WebServlet("/RomanziCatalog")
public class RomanziCatalog extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RomanziCatalog() {
        super();
    }

    private static ProductModelDM model;
    private static RecensioneModelDM recensioneModel;

    static {
        model = new ProductModelDM();
        recensioneModel = new RecensioneModelDM();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Collection<Libro> libri = null;
        Collection<Libro> romanzi = null;
        Map<Integer, Integer> valutazioni = null;

        try {
            libri = model.doRetrieveAllLibro(null);
            valutazioni = recensioneModel.doRetrieveAllRatingAverageBooks();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (libri != null) {
        	romanzi = libri.stream()
                               .filter(l -> l.getDescrizione().contains("romanzo") || l.getDescrizione().contains("Romanzo") || l.getGenere().contains("Romanzo"))
                               .collect(Collectors.toList());
        }

        request.setAttribute("libri", romanzi);
        request.setAttribute("valutazioni", valutazioni);

        RequestDispatcher dispatcher = request.getRequestDispatcher("romanziCatalog.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
