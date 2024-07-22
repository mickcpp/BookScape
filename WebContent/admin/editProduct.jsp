<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="net.bookscape.model.Product, net.bookscape.model.Libro, net.bookscape.model.Musica, net.bookscape.model.Gadget"%>
<%@ page import="net.bookscape.model.FormatoLibro, net.bookscape.model.FormatoMusica" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Modifica Prodotto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/feedback.css">
    <link rel="icon" href="img/logo.png" type="image/x-icon">
    <style>
       
        #containerMain {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
        }
        .form-container {
            width: 50%;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin: 1% 0;
        }
        .section-menu {
            display: none;
        }
        .error-message {
            color: #e74c3c;
            font-size: 0.9em;
            margin-top: 0.4%;
            margin-bottom: 1.55%;
            text-align: left;
            display: none;
        }
       
    </style>
</head>
<body>
    <%@ include file="/template/navbar.jsp" %>


    <% Product prodotto = (Product) request.getAttribute("prodotto");
        if(prodotto == null){
            System.out.println("prodotto nullo");
            response.sendRedirect("./");
            return;
        }
        String action = (String) request.getAttribute("action");
        if(action != null){
            if(action.equalsIgnoreCase("insert")) action = "inserisci";
            else if(action.equalsIgnoreCase("edit")) action = "modifica";
        } else {
            response.sendRedirect("admin/dashboard.jsp");
            return;
        }
        String feedback = (String) session.getAttribute("feedback");
        String feedbackNegativo = (String) session.getAttribute("feedback-negative");
        session.removeAttribute("feedback");
        session.removeAttribute("feedback-negative");
    %>

    <%@ include file="/template/feedbackSection.jsp" %>

    <div class="container" id="containerMain">
        <div class="form-container bg-light p-4 rounded">
            <h2><%=action.equals("modifica") ? "Modifica" : "Inserisci"%> prodotto</h2>
            <% String serverError = (String) session.getAttribute("errorMessage");
                session.removeAttribute("errorMessage");
                if(serverError != null) { %>
                    <div class="error-message alert alert-danger" style="display: block;"><%= serverError %></div>
            <% } %>

            <form action="FileUpload" method="post" enctype="multipart/form-data" onsubmit="<%= (prodotto instanceof Libro) ? "return validateLibro()" : (prodotto instanceof Musica) ? "return validateMusica()" : "return validateGadget()" %>">
                <input type="hidden" name="action" value="<%=action%>">
                <input type="hidden" name="productId" id="productId" value="<%= prodotto.getId() %>">
                <input type="hidden" name="productImageURL" id="productImageURL" value="<%= prodotto.getImgURL() %>">

                <div class="form-group mb-3">
                    <label for="nome">Nome:</label>
                    <input type="text" class="form-control" id="nome" name="nome" value="${prodotto.getNome()}" required>
                    <div class="error-message"></div>
                </div>

                <div class="form-group mb-3">
                    <label for="descrizione">Descrizione:</label>
                    <textarea id="descrizione" class="form-control" rows="5" cols="25" name="descrizione" required>${prodotto.getDescrizione()}</textarea>
                    <div class="error-message"></div>
                </div>

                <div class="form-group mb-3">
                    <label for="prezzo">Prezzo:</label>
                    <input type="number" class="form-control" id="prezzo" name="prezzo" value="${prodotto.getPrezzo()}" step="any" required>
                    <div class="error-message"></div>
                </div>

                <div class="form-group mb-3">
                    <label for="quantity">Quantità:</label>
                    <input type="number" class="form-control" id="quantity" name="quantity" value="${prodotto.getQuantita()}" required>
                    <div class="error-message"></div>
                </div>

                <div class="form-group mb-3">
                    <label for="immagine">Immagine:</label>
                    <input type="file" class="form-control" id="immagine" name="immagine" accept=".jpg, .jpeg, .png">
                </div>

                <% if (prodotto instanceof Libro) {
                    Libro l = (Libro) prodotto; %>
                    <input type="hidden" name="type" id="libro" value="libro">

                    <div class="form-group mb-3">
                        <label for="genere">Genere:</label>
                        <input type="text" class="form-control" id="genere" name="genere" value="<%= l.getGenere()%>" required>
                        <div class="error-message"></div>
                    </div>

                    <% FormatoLibro formato = l.getFormato();
                    String formatoName = (formato != null) ? formato.name() : ""; %>
                    <div class="form-group mb-3">
                        <label for="formato">Formato:</label>
                        <select id="formato" name="formato" class="form-select" required>
                            <option value="Cartaceo" <% if (formatoName.equals("Cartaceo")) { %>selected<% } %>>Cartaceo</option>
                            <option value="Digitale" <% if (formatoName.equals("Digitale")) { %>selected<% } %>>Digitale</option>
                        </select>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="anno">Anno:</label>
                        <input type="number" class="form-control" id="anno" name="anno" value="<%=l.getAnno() %>" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="ISBN">ISBN:</label>
                        <input type="text" class="form-control" id="ISBN" name="ISBN" value="<%=l.getISBN()%>" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="autore">Autore:</label>
                        <input type="text" class="form-control" id="autore" name="autore" value="<%=l.getAutore()%>" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="numeroPagine">Numero pagine:</label>
                        <input type="number" class="form-control" id="numeroPagine" name="numeroPagine" value="<%=l.getNumeroPagine()%>" required>
                        <div class="error-message"></div>
                    </div>

                <% } else if (prodotto instanceof Musica) {
                    Musica m = (Musica) prodotto; %>
                    <input type="hidden" name="type" id="musica" value="musica">

                    <div class="form-group mb-3">
                        <label for="genere">Genere:</label>
                        <input type="text" class="form-control" id="genere" name="genere" value="<%=m.getGenere()%>" required>
                        <div class="error-message"></div>
                    </div>

                    <% FormatoMusica formato = m.getFormato();
                    String formatoName = (formato != null) ? formato.name() : ""; %>
                    <div class="form-group mb-3">
                        <label for="formato">Formato:</label>
                        <select id="formato" name="formato" class="form-select" required>
                            <option value="Vinile" <% if (formatoName.equals("Vinile")) { %>selected<% } %>>Vinile</option>
                            <option value="CD" <% if (formatoName.equals("CD")) { %>selected<% } %>>CD</option>
                        </select>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="artista">Artista:</label>
                        <input type="text" class="form-control" id="artista" name="artista" value="<%=m.getArtista() %>" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="anno">Anno:</label>
                        <input type="number" class="form-control" id="anno" name="anno" value="<%=m.getAnno()%>" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="numeroTracce">Numero tracce:</label>
                        <input type="number" class="form-control" id="numeroTracce" name="numeroTracce" value="<%=m.getNumeroTracce()%>" required>
                        <div class="error-message"></div>
                    </div>

                <% } else if (prodotto instanceof Gadget) {
                    Gadget g = (Gadget) prodotto; %>
                    <input type="hidden" name="type" id="gadget" value="gadget">

                    <div class="form-group mb-3">
                        <label for="materiale">Materiale:</label>
                        <input type="text" class="form-control" id="materiale" name="materiale" value="<%=g.getMateriale()%>" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="altezza">Altezza:</label>
                        <input type="number" class="form-control" id="altezza" name="altezza" value="<%=g.getAltezza()%>" step="any" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="lunghezza">Lunghezza:</label>
                        <input type="number" class="form-control" id="lunghezza" name="lunghezza" value="<%=g.getLunghezza()%>" step="any" required>
                        <div class="error-message"></div>
                    </div>

                    <div class="form-group mb-3">
                        <label for="larghezza">Larghezza:</label>
                        <input type="number" class="form-control" id="larghezza" name="larghezza" value="<%=g.getLarghezza()%>" step="any" required>
                        <div class="error-message"></div>
                    </div>

                <% } %>

                <button type="submit" class="btn btn-primary"><%=action.equals("modifica") ? "Modifica" : "Inserisci"%></button>
            </form>
        </div>
    </div>

    <%@ include file="/template/footer.jsp"%>

    <script>
        function showError(input, message) {
            const errorElement = input.parentElement.querySelector('.error-message');
            errorElement.textContent = message;
            errorElement.style.display = 'block';
        }
        function resetErrors() {
            const errorMessages = document.querySelectorAll('.error-message');
            errorMessages.forEach(function (error) {
                error.style.display = 'none';
                error.textContent = '';
            });
        }
    </script>

    <script src="js/ValidationUtilsProduct.js"></script>
    <script src="js/ValidationLibraryProduct.js"></script>
    <script src="js/scriptFeedback.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>