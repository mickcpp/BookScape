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

@WebServlet("/FileUpload")
@MultipartConfig
public class FileUpload extends HttpServlet {

	private static final long serialVersionUID = 1L;
    
    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final String[] ALLOWED_EXTENSIONS = { "jpg", "jpeg", "png"};

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	// Ottieni il percorso di upload da web.xml
        final String uploadLocation = getServletContext().getInitParameter("uploadLocation");
        
    	String type = request.getParameter("type");
    	if(type == null) return;
    	if(type.equalsIgnoreCase("libro")) type = "books";
    	if(type.equalsIgnoreCase("musica")) type = "musics";
    	if(type.equalsIgnoreCase("gadget")) type = "gadgets";
    	
        Part filePart = request.getPart("immagine");
        if (filePart == null || filePart.getSize() == 0) {
        	if(request.getParameter("action") != null && request.getParameter("action").equalsIgnoreCase("inserisci")) {
                response.getWriter().println("Nessun file caricato");
                return;
        	} else {
        		 // Inoltro della richiesta alla servlet ProductControl
                RequestDispatcher dispatcher = request.getRequestDispatcher("/ProductControl");
                dispatcher.forward(request, response);
        	}
        }

        // Controllo del tipo MIME
        String mimeType = getServletContext().getMimeType(filePart.getSubmittedFileName());
        if (mimeType == null || !mimeType.startsWith("image/")) {
            response.getWriter().println("Il file caricato non è un'immagine valida.");
            return;
        }

        // Controllo della dimensione del file
        if (filePart.getSize() > MAX_FILE_SIZE) {
            response.getWriter().println("Il file caricato è troppo grande. La dimensione massima consentita è di 5MB.");
            return;
        }

        // Estrazione del nome del file e controllo dell'estensione
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        if (!isAllowedExtension(fileName)) {
            response.getWriter().println("Il file caricato ha un'estensione non consentita.");
            return;
        }

        // Verifica se il contenuto è un'immagine valida
        try (InputStream fileContent = filePart.getInputStream()) {
            BufferedImage image = ImageIO.read(fileContent);
            if (image == null) {
                response.getWriter().println("Il file caricato non è un'immagine valida.");
                return;
            }
        } catch (IOException e) {
            response.getWriter().println("Errore durante la lettura del file caricato.");
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
    
}
