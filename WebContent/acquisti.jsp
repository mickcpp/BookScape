<%@ page import="net.bookscape.model.Ordine, net.bookscape.model.CartItem, java.util.Collection, java.text.SimpleDateFormat" language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList, java.util.ListIterator, java.util.UUID"%>
<%@ page import="utility.EscaperHTML" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>I miei Acquisti</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="css/feedback.css">
    <style>
    	.section-menu{
    		display: none;
    	}
    	.display-6{
    		font-size: 2.5rem;
    	}
    	@media (max-width: 500px) {
		   .display-6{
    			font-size: 2.3rem;
    		}
		}
    </style>
</head>
<body>
    
    <%@ include file="template/navbar.jsp" %>
    <%
        String id = (String) session.getAttribute("cliente");
        
        String feedback = (String) session.getAttribute("feedback");
        String feedbackNegativo = (String) session.getAttribute("feedback-negative");
        
        session.removeAttribute("feedback");
        session.removeAttribute("feedback-negative");
    %>
    
    <%@ include file="template/feedbackSection.jsp" %>
    
    <div class="container my-4">
        <h1 class="text-center mb-4">I Miei Acquisti</h1>
        
        <%
            @SuppressWarnings("unchecked")
            Collection<Ordine> ordini = (Collection<Ordine>) request.getAttribute("ordini");
        
            if (ordini == null) {
                response.sendRedirect("OrderControl?action=visualizza");
                return;
            }
            
            if (ordini.size() != 0) {
                SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
                
                List<Ordine> ordiniList = new ArrayList<Ordine>(ordini);
                ListIterator<Ordine> listIterator = ordiniList.listIterator(ordini.size());
    
                int index = ordini.size();
                
                String csrfToken = UUID.randomUUID().toString();
                session.setAttribute("csrfToken", csrfToken);
                
                while (listIterator.hasPrevious()) {
                    Ordine ordine = listIterator.previous();
        %>
            <div class="card mb-4">
                <div class="card-body">
                    <h5 class="card-title display-6">Ordine ID: <%= index %></h5>
                    <form id="scaricaFattura<%= index %>" method="post" action="FatturaDownload">
                        <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
                        <input type="hidden" name="orderId" value="<%= ordine.getId() %>">
                        <input type="hidden" name="fatturaId" value="<%= index %>">
                        <input type="hidden" name="dataAcquisto" value="<%= dateFormatter.format(ordine.getDataOrdine().getTime()) %>">
                        <input type="hidden" name="nomeCompletoConsegna" value="<%= ordine.getNomeConsegna() + " " + ordine.getCognomeConsegna() %>">
                        <input type="hidden" name="viaConsegna" value="<%= ordine.getVia() %>">
                        <input type="hidden" name="cittaConsegna" value="<%= ordine.getCitta() %>">
                        <input type="hidden" name="capConsegna" value="<%= ordine.getCAP() %>">
                        <input type="hidden" name="numeroProdotti" value="<%= ordine.getProdotti().size() %>">
                        <%
                            int i = 1;
                            for (CartItem item : ordine.getProdotti()) {
                        %>
                            <input type="hidden" name="tipo<%= i %>" value="<%= item.getProduct().getClass().getSimpleName() %>">
                            <input type="hidden" name="nome<%= i %>" value="<%= item.getProduct().getNome() %>">
                            <input type="hidden" name="quantita<%= i %>" value="<%= item.getNumElementi() %>">
                            <input type="hidden" name="prezzo<%= i %>" value="<%= item.getProduct().getPrezzo() %>">
                        <%
                                i++;
                            }
                        %>
                        <input type="hidden" name="prezzoTotale" value="<%= ordine.getPrezzoTotale() %>">
                        <button type="submit" class="btn btn-success" onclick="submitFormAndRefresh('scaricaFattura<%= index %>'); return false;">Scarica fattura</button>
                    </form>
                    
                    <%
                        index--;
                    %>
                    
                    <p class="mt-2 mb-1">Data Ordine: <%= EscaperHTML.escapeHTML(dateFormatter.format(ordine.getDataOrdine().getTime())) %></p>
                    <p class="mb-1">Prezzo Totale: € <%= ordine.getPrezzoTotale() %></p>
                    <h6 class="mt-3">Prodotti:</h6>
                    <ul class="list-unstyled">
                        <%
                            Collection<CartItem> prodotti = ordine.getProdotti();
                            if (prodotti != null) {
                                for (CartItem item : prodotti) {
                        %>
                            <li class="d-flex align-items-center mb-2">
                                <img src="<%= item.getProduct().getImgURL() %>" alt="<%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %>" class="img-thumbnail me-2" style="width: 60px; height: 60px; object-fit: cover;">
                                <p class="mb-0"><%= EscaperHTML.escapeHTML(item.getProduct().getNome()) %> - Quantità: <%= item.getNumElementi() %> - Prezzo: € <%= item.getProduct().getPrezzo() %></p>
                            </li>
                        <%
                                }
                            }
                        %>
                    </ul>
                </div>
            </div>
        <%
                }
            } else {
        %>
            <p class="text-center">Non hai effettuato nessun acquisto!</p>
            <p class="text-center mb-5"><a href="./" class="btn btn-secondary">Torna al catalogo</a></p>
        <%
            }
        %>
    </div>
    
    <%@ include file="template/footer.jsp"%>
    
    <script>
        // Funzione per gestire il submit del form
        function submitFormAndRefresh(formId) {
            var form = document.getElementById(formId);
            form.submit();
            
            setTimeout(function() {
                location.reload();
            }, 90); // 90 millisecondi di ritardo prima di aggiornare la pagina
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
