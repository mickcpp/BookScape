DROP DATABASE IF EXISTS bookscape;
create schema bookscape;
use bookscape;

create table musica (
ID INT PRIMARY KEY DEFAULT 1000 ,
Nome VARCHAR(50) NOT NULL,
Descrizione VARCHAR(1000) NOT NULL,
Prezzo DECIMAL(6, 2 ) NOT NULL,
Quantità INT UNSIGNED NOT NULL,
Immagine VARCHAR(100) NOT NULL,
Genere VARCHAR(30) NOT NULL,
Formato VARCHAR(15) NOT NULL,
Anno INT UNSIGNED NOT NULL,
`Numero tracce` INT UNSIGNED NOT NULL,
Artista VARCHAR(30) NOT NULL
);

create table gadget (
ID INT PRIMARY KEY DEFAULT 1000 ,
Nome VARCHAR(50) NOT NULL,
Descrizione VARCHAR(1000) NOT NULL,
Prezzo DECIMAL(6, 2 ) NOT NULL,
Quantità INT UNSIGNED NOT NULL,
Immagine VARCHAR(100) NOT NULL,
Materiale VARCHAR(20) NOT NULL,
Lunghezza DECIMAL(5,2) NOT NULL,
Larghezza DECIMAL(5,2) NOT NULL,
Altezza DECIMAL(5,2) NOT NULL
);

create table libro (
ID INT  PRIMARY KEY DEFAULT 1000 ,
Nome VARCHAR(50) NOT NULL,
Descrizione VARCHAR(1000) NOT NULL,
Prezzo DECIMAL(6, 2 ) NOT NULL,
Quantità INT UNSIGNED NOT NULL,
Immagine VARCHAR(100) NOT NULL,
Genere VARCHAR(30) NOT NULL,
Formato VARCHAR(30) NOT NULL,
Anno INT UNSIGNED NOT NULL,
ISBN VARCHAR(15) UNIQUE NOT NULL,
Autore VARCHAR(30) NOT NULL,
`Numero pagine`VARCHAR(5) NOT NULL
);

CREATE TABLE cliente (
Email VARCHAR(50) PRIMARY KEY,
Username VARCHAR(50) UNIQUE NOT NULL,
`Password` VARCHAR(300) NOT NULL,
Nome VARCHAR(50) NOT NULL,
Cognome VARCHAR(50) NOT NULL, 
`Data nascita` DATE NOT NULL,
Città VARCHAR(50) NOT NULL,
Via VARCHAR(50) NOT NULL,
CAP CHAR(5) NOT NULL CHECK (CAP BETWEEN 10000 AND 99999),
`Nome carta`VARCHAR(40) ,
`Numero carta` CHAR(12) ,
`Data scadenza` DATE ,
CVV INT CHECK( CVV BETWEEN 100 AND 999)
);

create table ordine(
ID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
`Nome consegna` VARCHAR(50) NOT NULL,
`Cognome consegna` VARCHAR(50) NOT NULL,
`Prezzo totale` DECIMAL(10,2) NOT NULL,
`Data consegna` DATE NOT NULL,
`Data ordine` DATE NOT NULL,
Città VARCHAR(50) NOT NULL,
Via VARCHAR(50) NOT NULL,
CAP CHAR(5) NOT NULL CHECK (CAP BETWEEN 10000 AND 99999),
Cliente VARCHAR(30) NOT NULL,
FOREIGN KEY (Cliente)
	REFERENCES cliente (Email)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE amministratore(
ID INT PRIMARY KEY AUTO_INCREMENT,
Email VARCHAR(50),
FOREIGN KEY(Email) REFERENCES cliente (Email)
);

CREATE TABLE `acquisto libro`(
Libro INT  NOT NULL,
Ordine INT UNSIGNED NOT NULL,
Quantità INT UNSIGNED NOT NULL,
`Prezzo acquisto` DECIMAL(6,2) NOT NULL,
`Prezzo totale` DECIMAL(6,2) NOT NULL,
FOREIGN KEY (Libro)
	REFERENCES libro (ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (Ordine)
	REFERENCES ordine (ID)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `acquisto gadget`(
Gadget INT  NOT NULL,
Ordine INT UNSIGNED NOT NULL,
Quantità INT UNSIGNED NOT NULL,
`Prezzo acquisto` DECIMAL(6,2) NOT NULL,
`Prezzo totale` DECIMAL(6,2) NOT NULL,
FOREIGN KEY (Gadget)
	REFERENCES gadget (ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (Ordine)
	REFERENCES ordine (ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (Gadget)
	REFERENCES gadget (ID)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE `acquisto musica`(
Musica INT  NOT NULL,
Ordine INT UNSIGNED NOT NULL,
Quantità INT UNSIGNED NOT NULL,
`Prezzo acquisto` DECIMAL(6,2) NOT NULL,
`Prezzo totale` DECIMAL(6,2) NOT NULL,
FOREIGN KEY (Musica)
	REFERENCES musica (ID)
    ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (Ordine)
	REFERENCES ordine (ID)
    ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER aggiorna_ID_libro
BEFORE INSERT ON libro
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    
    SELECT MAX(ID) INTO max_id FROM
    (
        SELECT ID FROM musica
        UNION ALL
        SELECT ID FROM gadget
        UNION ALL
        SELECT ID FROM libro
    ) AS max_ids;
    
    SET NEW.ID = IFNULL(max_id-999, 0) + 1000;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER aggiorna_ID_musica
BEFORE INSERT ON musica
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    
    SELECT MAX(ID) INTO max_id FROM
    (
        SELECT ID FROM musica
        UNION ALL
        SELECT ID FROM gadget
        UNION ALL
        SELECT ID FROM libro
    ) AS max_ids;
    
    SET NEW.ID = IFNULL(max_id-999, 0) + 1000;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER aggiorna_ID_gadget
BEFORE INSERT ON gadget
FOR EACH ROW
BEGIN
    DECLARE max_id INT;
    
    SELECT MAX(ID) INTO max_id FROM
    (
        SELECT ID FROM musica
        UNION ALL
        SELECT ID FROM gadget
        UNION ALL
        SELECT ID FROM libro
    ) AS max_ids;
    
    SET NEW.ID = IFNULL(max_id-999, 0) + 1000;
END;
//
DELIMITER ;

CREATE TABLE carrello (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Libro INT,
    Musica INT,
    Gadget INT,
    Cliente VARCHAR(50),
    Quantità INT NOT NULL,
    CONSTRAINT UQ_OnlyOneProductID UNIQUE (Libro, Musica, Gadget),
    FOREIGN KEY (Cliente) REFERENCES cliente (Email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Libro) REFERENCES libro (ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Musica) REFERENCES musica (ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Gadget) REFERENCES gadget (ID) ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER trg_check_one_product
BEFORE INSERT ON carrello
FOR EACH ROW
BEGIN
    IF NOT (
        (NEW.Libro IS NOT NULL AND NEW.Musica IS NULL AND NEW.Gadget IS NULL) OR
        (NEW.Libro IS NULL AND NEW.Musica IS NOT NULL AND NEW.Gadget IS NULL) OR
        (NEW.Libro IS NULL AND NEW.Musica IS NULL AND NEW.Gadget IS NOT NULL)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo una delle colonne Libro, Musica o Gadget può essere non nulla.';
    END IF;
END//
DELIMITER ;

CREATE TABLE wishlist (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Libro INT,
    Musica INT,
    Gadget INT,
    Cliente VARCHAR(50),
    CONSTRAINT UQ_OnlyOneProductID UNIQUE (Libro, Musica, Gadget),
    FOREIGN KEY (Cliente) REFERENCES cliente (Email) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Libro) REFERENCES libro (ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Musica) REFERENCES musica (ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Gadget) REFERENCES gadget (ID) ON UPDATE CASCADE ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER trg_check_one_product2
BEFORE INSERT ON wishlist
FOR EACH ROW
BEGIN
    IF NOT (
        (NEW.Libro IS NOT NULL AND NEW.Musica IS NULL AND NEW.Gadget IS NULL) OR
        (NEW.Libro IS NULL AND NEW.Musica IS NOT NULL AND NEW.Gadget IS NULL) OR
        (NEW.Libro IS NULL AND NEW.Musica IS NULL AND NEW.Gadget IS NOT NULL)
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo una delle colonne Libro, Musica o Gadget può essere non nulla.';
    END IF;
END//
DELIMITER ;
