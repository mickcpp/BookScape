package net.bookscape.control;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;

import net.bookscape.model.Cliente;
import net.bookscape.model.CsrfTokens;
import net.bookscape.model.OrderModelDM;
import utility.CardPaymentDetect;

/**
 * Servlet implementation class FatturaDownload
 */
@WebServlet("/FatturaDownload")
public class FatturaDownload extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
      
	private static OrderModelDM orderModel;
	
	static {
		orderModel = new OrderModelDM();
	}
	
    public FatturaDownload() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    	HttpSession session = request.getSession(false);
    	if(session == null) {
    		response.sendRedirect("./");
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
        
    	String dataAcquisto = request.getParameter("dataAcquisto");
    	Cliente clienteFatturazione = null;
    	SimpleDateFormat scadenzaFormatter = new SimpleDateFormat("MM/yyyy");
    	
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        try {
			clienteFatturazione = orderModel.doRetrieveDatiFatturazioneByOrder(orderId);
		} catch (SQLException e) {
			e.printStackTrace();
		}
        

        int fatturaId = Integer.parseInt(request.getParameter("fatturaId"));
        
        // Imposta il tipo di contenuto come PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"fattura" + "-" + fatturaId  + "-" + dataAcquisto + ".pdf\"");
        
        // Percorso dell'immagine del logo
        String percorsoLogo = getServletContext().getRealPath("/img/logo.png");
        
        // Creazione di un nuovo documento PDF
        try (PDDocument document = new PDDocument()){
            // Aggiunta di una pagina vuota al documento
            PDPage pagina = new PDPage();
            document.addPage(pagina);

            // Creazione di un content stream per la pagina
            PDPageContentStream contentStream = new PDPageContentStream(document, pagina);
            		
            try {
                // Caricamento dell'immagine del logo
                PDImageXObject pdImage = PDImageXObject.createFromFile(percorsoLogo, document);
                contentStream.drawImage(pdImage, 532, 721, 65, 50); // Posiziona e ridimensiona il logo

                // Impostazione della formattazione
                float leading = 14.5f;

                // Iniziamo a scrivere il contenuto in basso all'immagine
                float startY = 700;
                float space = 10;
                float margin = 50;
                float bottomMargin = 50;
                float pageHeight = pagina.getMediaBox().getHeight();

                // Aggiunta del nome del sito
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 18);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Bookscape");
                contentStream.endText();
                startY -= 18 * 1.2; // Spostiamo verso il basso per la prossima riga

                // Aggiunta della data attuale
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(450, startY);
                contentStream.showText("Data: " + dataAcquisto);
                contentStream.endText();
                startY -= 12 * 1.2;

                // Aggiunta del titolo della fattura
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 16);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Fattura di Acquisto");
                contentStream.endText();
                startY -= 16 * 1.2;

                // Aggiunta della data di acquisto
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Data di Acquisto: " + dataAcquisto);
                contentStream.endText();
                startY -= 12 * 1.2 + space;

                // Aggiunta dei dati di fatturazione
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Dati di Fatturazione:");
                contentStream.endText();
                startY -= 12 * 1.2;

                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                contentStream.beginText();
                contentStream.setLeading(leading);
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Nome: " + clienteFatturazione.getNome() + " " + clienteFatturazione.getCognome());
                contentStream.newLine();
                contentStream.showText("Indirizzo: " + clienteFatturazione.getVia());
                contentStream.newLine();
                contentStream.showText("Città: " + clienteFatturazione.getCitta());
                contentStream.newLine();
                contentStream.showText("CAP: " + clienteFatturazione.getCAP());
                contentStream.endText();
                startY -= 4 * 12 * 1.2 + space; // 5 righe di testo

                // Aggiunta del metodo di pagamento
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Metodo di Pagamento:");
                contentStream.endText();
                startY -= 12 * 1.2;

                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                
                String cardType = CardPaymentDetect.detectCreditCardType(clienteFatturazione.getCarta().getNumeroCarta());
                if(cardType.equalsIgnoreCase("visa")) {
                	contentStream.showText("Carta di Credito (Visa)");
                } else if(cardType.equalsIgnoreCase("mastercard")){
                	contentStream.showText("Carta di Credito (Mastercard)");
                } else {
                	contentStream.showText("Carta di Credito (Sconosciuta)");
                }
  
                contentStream.newLine();
                contentStream.showText(clienteFatturazione.getCarta().getNomeCarta() + " (**** **** **** " + clienteFatturazione.getCarta().getNumeroCarta().substring(clienteFatturazione.getCarta().getNumeroCarta().length() - 4) + ")");
                contentStream.newLine();
                contentStream.showText("Data scadenza: " + scadenzaFormatter.format(clienteFatturazione.getCarta().getDataScadenza().getTime()));
                contentStream.endText();
                startY -= 3 * 12 * 1.2 + space;

                // Aggiunta dell'indirizzo di consegna
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Indirizzo di Consegna:");
                contentStream.endText();
                startY -= 12 * 1.2;

                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                contentStream.beginText();
                contentStream.setLeading(leading);
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Nome: " + request.getParameter("nomeCompletoConsegna"));
                contentStream.newLine();
                contentStream.showText("Indirizzo: " + request.getParameter("viaConsegna"));
                contentStream.newLine();
                contentStream.showText("Città: " + request.getParameter("cittaConsegna"));
                contentStream.newLine();
                contentStream.showText("CAP: " + request.getParameter("capConsegna"));
                contentStream.endText();
                startY -= 4 * 12 * 1.2 + space; // 4 righe di testo

                // Aggiunta dei dettagli dell'ordine
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Dettagli dell'Ordine:");
                contentStream.endText();
                startY -= 12 * 1.2 + 3;

                int numProdotti = Integer.parseInt(request.getParameter("numeroProdotti"));
                
                for(int i=0; i<numProdotti; i++) {
                    if (startY < bottomMargin + 3 * 12 * 1.2 + space) { // Check if space is left on the page for at least 3 lines of product details
                        contentStream.close(); // Close the current content stream
                        pagina = new PDPage(); // Create a new page
                        document.addPage(pagina); // Add the new page to the document
                        contentStream = new PDPageContentStream(document, pagina); // Start a new content stream
                        startY = pageHeight - margin; // Reset the vertical position
                    }

                    String type = request.getParameter("tipo" + (i+1));
                    String nome = request.getParameter("nome" + (i+1));
                    String quantita = request.getParameter("quantita" + (i+1));
                    String prezzo = request.getParameter("prezzo" + (i+1));
                    
                    contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 12);
                    contentStream.beginText();
                    contentStream.setLeading(leading);
                    contentStream.newLineAtOffset(margin, startY);
                    contentStream.showText((i+1) + ". " + type + ": '" + nome + "'");
                    contentStream.newLine();
                    contentStream.showText("   Quantità: " + quantita);
                    contentStream.newLine();
                    contentStream.showText("   Prezzo: " + prezzo + " EUR");
                    contentStream.endText();
                    startY -= 3 * 12 * 1.2 + 5;
                }
                
                startY -= 16;
                
                // Aggiunta del totale
                if (startY < bottomMargin + 12 * 1.2) { // Check if space is left for the total line
                    contentStream.close(); // Close the current content stream
                    pagina = new PDPage(); // Create a new page
                    document.addPage(pagina); // Add the new page to the document
                    contentStream = new PDPageContentStream(document, pagina); // Start a new content stream
                    startY = pageHeight - margin; // Reset the vertical position
                }
                
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), 12);
                contentStream.beginText();
                contentStream.newLineAtOffset(margin, startY);
                contentStream.showText("Totale: " + request.getParameter("prezzoTotale") + " EUR");
                contentStream.endText();

                // Chiusura del content stream
                contentStream.close();

                // Salvataggio del documento PDF
                document.save(response.getOutputStream());
                
            } catch (IOException i) {
            	System.err.println("Errore durante la creazione di una nuova pagina: " + i.getMessage());
                i.printStackTrace(); 
            }

        } catch (IOException e) {
            System.err.println("Errore durante la creazione del PDF: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
