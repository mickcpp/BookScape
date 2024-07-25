package net.bookscape.control;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import net.bookscape.model.CsrfTokens;

@WebServlet("/FileUpload")
@MultipartConfig
public class FileUpload extends HttpServlet {

	private static final long serialVersionUID = 1L;
    
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final String[] ALLOWED_EXTENSIONS = { "jpg", "jpeg", "png", "webp"};

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	// Ottieni il percorso di upload da web.xml
        final String uploadLocation = getServletContext().getInitParameter("uploadLocation");
        
    	String type = request.getParameter("type");
    	if(type == null) return;
    	if(type.equalsIgnoreCase("libro")) type = "books";
    	if(type.equalsIgnoreCase("musica")) type = "musics";
    	if(type.equalsIgnoreCase("gadget")) type = "gadgets";
    	
    	int productId = getProductId(request);
    	String redirectEditPage = "admin/dashboard.jsp";
    	
    	String action = "";
    	if(request.getParameter("action") == null) return;
    	else action = request.getParameter("action");
    	
    	if(action.equalsIgnoreCase("inserisci") && productId >= 0 && type != null) {
    		redirectEditPage = "ProductControl?productId=" + productId + "&action=viewInsert&type=" + request.getParameter("type");
    	} else if(action.equalsIgnoreCase("modifica") && productId != 0 && type != null){
    		redirectEditPage = "ProductControl?productId=" + productId + "&action=viewEdit&type=" + request.getParameter("type");
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
        
        Part filePart = request.getPart("immagine");
        if (filePart == null || filePart.getSize() == 0) {
        	if(action.equalsIgnoreCase("inserisci")) {
        		redirect(request, response, redirectEditPage, "Nessuna immagine caricata!", true);
                return;
        	} else {
        		 // Inoltro della richiesta alla servlet ProductControl
                RequestDispatcher dispatcher = request.getRequestDispatcher("/ProductControl");
                dispatcher.forward(request, response);
                return;
        	}
        }

        // Controllo del tipo MIME
        String mimeType = getServletContext().getMimeType(filePart.getSubmittedFileName());
        if (mimeType == null || !mimeType.startsWith("image/")) {
        	redirect(request, response, redirectEditPage, "Il file caricato non è un'immagine valida.", true);
            return;
        }

        // Controllo della dimensione del file
        if (filePart.getSize() > MAX_FILE_SIZE) {
        	redirect(request, response, redirectEditPage, "Il file caricato è troppo grande. La dimensione massima consentita è di 5MB.", true);
            return;
        }

        // Estrazione del nome del file e controllo dell'estensione
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!isAllowedExtension(fileName)) {
        	redirect(request, response, redirectEditPage, "Il file caricato ha un'estensione non consentita.", true);
            return;
        }
        
        // Verifica se il nome del file è valido
        if (!isValidFileName(fileName)) {
            redirect(request, response, redirectEditPage, "Il nome del file contiene caratteri non validi.", true);
            return;
        }
        
        // Verifica se il contenuto è un'immagine valida
        try (InputStream fileContent = filePart.getInputStream()) {
            BufferedImage image = ImageIO.read(fileContent);
            if(image == null) {
            	redirect(request, response, redirectEditPage, "Il file caricato non è un'immagine valida.", true);
                return;
            }
        } catch (IOException e) {
        	redirect(request, response, redirectEditPage, "Errore durante la lettura del file caricato.", true);
            return;
        }

        // Creazione della directory di destinazione se non esiste
        String uploadFilePath = uploadLocation + File.separator + type;
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
	
	    // Salva il file sul server
        File file = new File(uploadDir, fileName);
        try (InputStream fileContent = filePart.getInputStream();
             FileOutputStream outputStream = new FileOutputStream(file)) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        }

        // Impostazione del nome del file come attributo della richiesta
        request.setAttribute("fileName", fileName);

        // Inoltro della richiesta alla servlet ProductControl
        RequestDispatcher dispatcher = request.getRequestDispatcher("/ProductControl");
        dispatcher.forward(request, response);
    }

    private boolean isAllowedExtension(String fileName) {
        String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
        for (String extension : ALLOWED_EXTENSIONS) {
            if (fileExtension.equals(extension)) {
                return true;
            }
        }
        return false;
    }
    
    public void redirect(HttpServletRequest request, HttpServletResponse response, String redirect, String message, boolean negative) throws ServletException, IOException {
		if(negative) request.getSession().setAttribute("feedback-negative", message);
		else request.getSession().setAttribute("feedback", message);
		response.sendRedirect(redirect);
	}
    
    private int getProductId(HttpServletRequest request) {
		if(request.getParameter("productId") != null) {
			return Integer.parseInt(request.getParameter("productId"));
		}
		return 0;
	}
    
    private boolean isValidFileName(String fileName) {
        // Permette solo lettere, numeri, trattini e punti
    	return fileName.matches("[a-zA-Z0-9._\\- ]+");
    }
}
