package net.bookscape.model;

public class CartItem {
	
	private Product product;
	private int num;
	
	public CartItem(Product product) {
		this.product = product;
		this.num = 1;
	}
	
	public CartItem() {
		this.num = 1;
	}
	
	public Product getProduct() {
		return product;
	}
	
	public void setProduct(Product product) {	
	    if (product instanceof Libro) {
	        Libro libro = (Libro) product;
	        Libro l = new Libro();
	        l.setId(product.getId());
	        l.setNome(libro.getNome());
	        l.setDescrizione(libro.getDescrizione());
	        l.setPrezzo(libro.getPrezzo());
	        l.setQuantita(libro.getQuantita());
	        l.setImgURL(libro.getImgURL());
	        l.setGenere(libro.getGenere());
	        l.setFormato(libro.getFormato());
	        l.setISBN(libro.getISBN());
	        l.setAutore(libro.getAutore());
	        l.setAnno(libro.getAnno());
	        l.setNumeroPagine(libro.getNumeroPagine());
	        
	        this.product = l;
	    } else if (product instanceof Musica) {
	        Musica musica = (Musica) product;
	        Musica m = new Musica();
	        m.setId(product.getId());
	        m.setNome(musica.getNome());
	        m.setDescrizione(musica.getDescrizione());
	        m.setPrezzo(musica.getPrezzo());
	        m.setQuantita(musica.getQuantita());
	        m.setImgURL(musica.getImgURL());
	        m.setGenere(musica.getGenere());
	        m.setFormato(musica.getFormato());
	        m.setArtista(musica.getArtista());
	        m.setAnno(musica.getAnno());
	        m.setNumeroTracce(musica.getNumeroTracce());
	        
	        this.product = m;
	    } else if (product instanceof Gadget) {
	        Gadget gadget = (Gadget) product;
	        Gadget g = new Gadget();
	        g.setId(product.getId());
	        g.setNome(gadget.getNome());
	        g.setDescrizione(gadget.getDescrizione());
	        g.setPrezzo(gadget.getPrezzo());
	        g.setQuantita(gadget.getQuantita());
	        g.setImgURL(gadget.getImgURL());
	        g.setMateriale(gadget.getMateriale());
	        g.setAltezza(gadget.getAltezza());
	        g.setLunghezza(gadget.getLunghezza());
	        g.setLarghezza(gadget.getLarghezza());
	        
	        this.product = g;
	    }
	}

	
	public int getNumElementi() {
		return num;
	}
	
	public void setNumElementi(int num) {
		this.num = num;
	}
	
	public void incrementNum() {
		setNumElementi(getNumElementi() + 1);
    }
	
	public void decrementNum() {
		setNumElementi(getNumElementi() - 1);
    }

	public double getTotalCost() {
	    return(getNumElementi() * product.getPrezzo());
	}

}
