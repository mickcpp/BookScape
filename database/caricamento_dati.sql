use bookscape;
INSERT INTO musica (ID, Nome, Descrizione, Prezzo, Immagine, Quantità, Genere, Formato, Anno, `Numero Tracce`, Artista)
VALUES 
(3001, 'The Dark Side of the Moon', 'Vinile 33 giri', 19.99, 'productImages/musics/VinilePinkFloyd.webp', 200, 'Rock', 'Vinile', 2023, 10, 'Pink Floyd'),
(3002, 'Straight Outta Compton', 'Compact Disc', 12.99, 'productImages/musics/CD NWA.webp', 150, 'Hip-Hop', 'CD', 2023, 12, 'N.W.A.'),
(3003, 'Nevermind', 'Vinile 33 giri', 24.99, 'productImages/musics/Vinile Nirvana.webp', 100, 'Grunge', 'Vinile', 2022, 13, 'Nirvana'),
(3004, 'Greatest Hits', 'Compact Disc', 15.99, 'productImages/musics/CD Lazza.webp', 100, 'Hip-Hop', 'CD', 2021, 17, 'Lazza'),
(3005, 'Starboy', 'Vinile Limited Edition', 29.99, 'productImages/musics/Vinile STARBOY.webp', 75, 'R&B', 'Vinile', 2024, 18, 'The Weeknd'),
(3006, 'Abbey Road', 'Vinile 33 giri', 21.99, 'productImages/musics/Vinile Beatles.webp', 200, 'Rock', 'Vinile', 2023, 17, 'The Beatles'),
(3007, 'Back in Black', 'Compact Disc', 14.99, 'productImages/musics/CD ACDC.webp', 120, 'Rock', 'CD', 2022, 10, 'AC/DC'),
(3008, 'Thriller', 'Vinile 33 giri', 22.99, 'productImages/musics/Vinile MJ.webp', 180, 'Pop', 'Vinile', 2023, 9, 'Michael Jackson'),
(3009, 'The Wall', 'Compact Disc', 16.99, 'productImages/musics/CD PinkFloyd.webp', 110, 'Rock', 'CD', 2022, 26, 'Pink Floyd'),
(3010, 'Born to Run', 'Vinile 33 giri', 18.99, 'productImages/musics/Vinile Bruce.webp', 90, 'Rock', 'Vinile', 2023, 8, 'Bruce Springsteen'),
(3011, 'Greatest Hits', 'Compact Disc', 15.99, 'productImages/musics/CD ElthonJonh.webp', 150, 'Pop', 'CD', 2021, 12, 'Elton John'),
(3012, 'Legend', 'Vinile 33 giri', 20.99, 'productImages/musics/Vinile BobMarley.webp', 160, 'Reggae', 'Vinile', 2023, 14, 'Bob Marley'),
(3013, 'Hotel California', 'Vinile 33 giri', 21.99, 'productImages/musics/Vinile Eagles.webp', 180, 'Rock', 'Vinile', 2023, 9, 'Eagles'),
(3014, 'Purple Rain', 'Compact Disc', 14.99, 'productImages/musics/CD Prince.webp', 130, 'Pop', 'CD', 2022, 9, 'Prince'),
(3015, 'The Chronic', 'Vinile 33 giri', 25.99, 'productImages/musics/Vinile DrDre.webp', 110, 'Hip-Hop', 'Vinile', 2023, 16, 'Dr. Dre'),
(3016, 'Rumours', 'Compact Disc', 13.99, 'productImages/musics/CD FleetwoodMac.webp', 150, 'Rock', 'CD', 2021, 11, 'Fleetwood Mac'),
(3017, 'Bad', 'Vinile 33 giri', 23.99, 'productImages/musics/Vinile MJ Bad.webp', 170, 'Pop', 'Vinile', 2023, 10, 'Michael Jackson'),
(3019, 'In the Court of the Crimson King', 'Vinile 33 giri', 24.99, 'productImages/musics/Vinile KingCrimson.webp', 80, 'Rock', 'Vinile', 2023, 5, 'King Crimson'),
(3020, 'Random Access Memories', 'Compact Disc', 17.99, 'productImages/musics/CD DaftPunk.webp', 110, 'Electronic', 'CD', 2022, 13, 'Daft Punk'),
(3021, 'Tapestry', 'Vinile 33 giri', 19.99, 'productImages/musics/Vinile CaroleKing.webp', 90, 'Pop', 'Vinile', 2023, 12, 'Carole King'),
(3022, '21', 'Compact Disc', 15.99, 'productImages/musics/CD Adele.webp', 150, 'Pop', 'CD', 2021, 11, 'Adele'),
(3024, 'The Slim Shady LP', 'Compact Disc', 14.99, 'productImages/musics/CD Eminem.webp', 130, 'Hip-Hop', 'CD', 2022, 20, 'Eminem'),
(3025, 'A Night at the Opera', 'Vinile 33 giri', 26.99, 'productImages/musics/Vinile Queen.webp', 80, 'Rock', 'Vinile', 2023, 12, 'Queen'),
(3027, 'Brothers in Arms', 'Vinile 33 giri', 24.99, 'productImages/musics/Vinile DireStraits.webp', 150, 'Rock', 'Vinile', 2023, 9, 'Dire Straits'),
(3028, 'Appetite for Destruction', 'Compact Disc', 13.99, 'productImages/musics/CD GnR.webp', 110, 'Rock', 'CD', 2022, 12, 'Guns N Roses'),
(3029, 'London Calling', 'Vinile 33 giri', 23.99, 'productImages/musics/Vinile Clash.webp', 90, 'Rock', 'Vinile', 2023, 19, 'The Clash'),
(3030, 'Sgt. Pepper s Lonely Hearts Club Band', 'Compact Disc', 14.99, 'productImages/musics/CD Beatles SgtPepper.webp', 130, 'Rock', 'CD', 2022, 13, 'The Beatles');

-- Popolare la tabella 'gadget'
INSERT INTO gadget (Nome, Descrizione, Prezzo, Quantità, Materiale, Immagine, Lunghezza, Larghezza, Altezza)
VALUES 
('Portachiavi Batman', 'Portachiavi metallico con logo di Batman', 4.99, 200,  'Metallo', 'productImages/gadgets/portachiavi batman.webp', 5.0, 2.0, 0.5),
('Tazza Star Wars', 'Tazza in ceramica con logo di Star Wars', 9.99, 100,  'Ceramica', 'productImages/gadgets/Tazza Star Wars.webp', 4.0, 3.5, 4.5),
('Penna multicolore', 'Penna a sfera con impugnatura in gomma, con molteplici colori', 1.99, 500,  'Plastica', 'productImages/gadgets/Penna multicolore.webp', 6.0, 0.5, 0.5),
('Porta Cellulare One-Piece', 'Porta cellulare da scrivania con adattatore e presa anti-scivolo', 7.99, 150, 'Plastica', 'productImages/gadgets/Porta cellulare One Piece.webp', 7.5, 4.0, 2.0),
('Tazza Spider-Man', 'Tazza in ceramica con logo di Spider-Man', 9.99, 100,  'Ceramica', 'productImages/gadgets/tazzaSpiderman.webp', 4.0, 3.5, 4.5),
('Tazza Pistola', 'Tazza in ceramica con manico a pistola', 9.99, 100,  'Ceramica', 'productImages/gadgets/tazzaPistola.webp', 4.0, 3.5, 4.5),
('Matita flessibile', 'Matita flessibile compresa di gomma', 1.99, 500,  'Plastica', 'productImages/gadgets/matita.webp', 6.0, 0.5, 0.5),
('Action-Figure Spider-man', 'Action-Figure raffigurante l eroe Spiderman', 24.99, 200,  'Plastica', 'productImages/gadgets/actionFigureSpiderman.webp', 5.0, 5.0, 20.0),
('Action-Figure Hulk', 'Action-Figure raffigurante l eroe Hulk', 24.99, 200,  'Plastica', 'productImages/gadgets/actionFigureHulk.webp', 5.0, 5.0, 20.0),
('Poster Murales', 'Poster largo a parete raffigurante un murales', 19.99, 100,  'Plastica', 'productImages/gadgets/posterMurales.webp', 30.0, 0.5, 22.0),
('Poster City', 'Poster largo a parete raffigurante una citta di notte', 19.99, 100,  'Plastica', 'productImages/gadgets/posterCity.webp', 30.0, 0.5, 22.0),
('Poster Vintage', 'Poster largo a parete raffigurante un immagine stile Vintage', 19.99, 100,  'Plastica', 'productImages/gadgets/posterVintage.webp', 30.0, 0.5, 22.0),
('Cover Spiderman', 'Cover in gomma raffigurante Spider-Man', 9.99, 100,  'Gomma', 'productImages/gadgets/coverSpiderman.webp', 5.0, 3.0, 11.0),
('Cover Art', 'Cover in gomma raffigurante arte mista', 9.99, 100,  'Gomma', 'productImages/gadgets/coverArt.webp', 5.0, 3.0, 11.0),
('Cover Inter', 'Cover in gomma raffigurante la seconda stella dell Inter', 9.99, 100,  'Gomma', 'productImages/gadgets/coverInter.webp', 5.0, 3.0, 11.0),
('Penna FunkoPop', 'Penna a sfera con impugnatura in gomma, raffigurante Capitan America versione FunkoPop', 1.99, 500,  'Plastica', 'productImages/gadgets/pennaFunko.webp', 6.0, 0.5, 0.5),
('Penna Spider-Man', 'Penna a sfera con impugnatura in gomma, raffigurante Spider-Man', 1.99, 500,  'Plastica', 'productImages/gadgets/pennaSpiderman.webp', 6.0, 0.5, 0.5),
('Quaderno Spider-Man', 'Quaderno con copertina flessibile, raffigurante Spider-Man', 1.99, 500,  'Carta', 'productImages/gadgets/quadernoSpiderman.webp', 6.0, 0.5, 0.5),
('Quaderno Bat-Man', 'Quaderno con copertina rigida, raffigurante Bat-Man', 1.99, 500,  'Carta', 'productImages/gadgets/quadernoBatman.webp', 6.0, 0.5, 0.5);

-- Popolare la tabella 'libro'
INSERT INTO libro (Nome, Descrizione, Prezzo, Quantità, Genere, Formato, Anno, Immagine, ISBN, Autore, `Numero pagine`)
VALUES 
('Il Signore degli Anelli', 'Fantasy epico', 29.99, 100, 'Fantasy', 'Cartaceo', 1954, 'productImages/books/Il signore degli anelli.webp', '9788804670696', 'J.R.R. Tolkien', '1200'),
('1984', 'Romanzo distopico', 14.99, 200, 'Fantascienza', 'Digitale', 1949, 'productImages/books/1984.webp', '9788804625733', 'George Orwell', '300'),
('Cronache di Narnia', 'Fantasy per ragazzi', 19.99, 150, 'Fantasy', 'Cartaceo', 1950, 'productImages/books/Le Cronache di Narnia.webp', '9788804661229', 'C.S. Lewis', '1000'),
('Il Piccolo Principe', 'Fiaba filosofica', 9.99, 300, 'Narrativa', 'Digitale', 1943, 'productImages/books/Il Piccolo Principe.webp', '9788804640347', 'Antoine de Saint-Exupéry', '150'),
('Harry Potter', 'Romanzo fantasy', 24.99, 120, 'Fantasy', 'Cartaceo', 1997, 'productImages/books/Harry potter e la pietra filosofale.webp', '9788804668259', 'J.K. Rowling', '700'),
('Dracula', 'Classico romanzo horror', 15.99, 80, 'Horror', 'Cartaceo', 1897, 'productImages/books/Dracula.webp', '9788804678944', 'Bram Stoker', '400'),
('IT', 'Romanzo horror su un clown malefico', 24.99, 50, 'Horror', 'Cartaceo', 1986, 'productImages/books/IT.webp', '9788804679705', 'Stephen King', '1200'),
('Frankenstein', 'Classico gotico horror', 12.99, 60, 'Horror', 'Digitale', 1818, 'productImages/books/Frankenstein.webp', '9788804679507', 'Mary Shelley', '280'),
('L esorcista', 'Romanzo horror su una possessione demoniaca', 19.99, 40, 'Horror', 'Cartaceo', 1971, 'productImages/books/Lesorcista.webp', '9788804679842', 'William Peter Blatty', '340'),
('Pet Sematary', 'Romanzo horror su un cimitero di animali', 18.99, 70, 'Horror', 'Cartaceo', 1983, 'productImages/books/Pet Sematary.webp', '9788804679453', 'Stephen King', '560'),
('Orgoglio e Pregiudizio', 'Un classico della letteratura romantica, racconta la storia di Elizabeth Bennet e del signor Darcy.', 12.99, 150, 'Romantico', 'Cartaceo', 1813, 'productImages/books/orgoglio_pregiudizio.webp', '9788804679195', 'Jane Austen', '432'),
('Il Grande Gatsby', 'Un romanzo che esplora l amore e l ossessione nella società americana degli anni 20.', 14.99, 200, 'Romantico', 'Cartaceo', 1925, 'productImages/books/ilGrandeGatsby.webp', '9788804679133', 'F. Scott Fitzgerald', '180'),
('Anna Karenina', 'Un classico della letteratura russa che racconta la tragica storia d amore di Anna Karenina.', 18.99, 100, 'Romantico', 'Cartaceo', 1877, 'productImages/books/Anna Karenina.webp', '9788804679071', 'Lev Tolstoj', '864'),
('Cime tempestose', 'Un romanzo gotico che esplora la passione e la vendetta tra Heathcliff e Catherine.', 13.99, 80, 'Romantico', 'Cartaceo', 1847, 'productImages/books/cime tempestose.webp', '9788804679125', 'Emily Brontë', '416'),
('Via col Vento', 'Un epica storia d amore ambientata durante la Guerra Civile Americana.', 22.99, 90, 'Romantico', 'Cartaceo', 1936, 'productImages/books/via col vento.webp', '9788804679187', 'Margaret Mitchell', '1037'),
('Blood Meridian', 'Un romanzo epico-storico che segue le vicende del protagonista in un viaggio oscuro e violento nel West.', 17.99, 75, 'Epico-Storico', 'Cartaceo', 1985, 'productImages/books/Blood Meridian.webp', '9788804679309', 'Cormac McCarthy', '384'),
('Guerra e Pace', 'Un vasto racconto epico delle guerre napoleoniche e delle vite degli aristocratici russi.', 19.99, 50, 'Epico-Storico', 'Cartaceo', 1869, 'productImages/books/guerra e pace.webp', '9788804679316', 'Lev Tolstoj', '1225'),
('I Pilastri della Terra', 'Un romanzo epico che racconta la costruzione di una cattedrale nel Medioevo inglese.', 24.99, 60, 'Epico-Storico', 'Cartaceo', 1989, 'productImages/books/i pilastri della terra.webp', '9788804679323', 'Ken Follett', '1030'),
('Shogun', 'Un racconto epico di avventura e intrighi nel Giappone feudale.', 20.99, 40, 'Epico-Storico', 'Cartaceo', 1975, 'productImages/books/Shogun.webp', '9788804679330', 'James Clavell', '1152'),
('Il Nome della Rosa', 'Un romanzo storico ambientato in un monastero benedettino nel Medioevo, che combina elementi di mistero e intrigo.', 14.99, 80, 'Epico-Storico', 'Cartaceo', 1980, 'productImages/books/il nome della rosa.webp', '9788804679347', 'Umberto Eco', '592'),
('I Have No Mouth, and I Must Scream', 'Un racconto di fantascienza distopico che narra la storia di cinque umani superstiti alle prese con un intelligenza artificiale malevola.', 15.99, 50, 'Fantascienza', 'Cartaceo', 1967, 'productImages/books/AM.webp', '9780312567481', 'Harlan Ellison', '320'),
('One Piece', 'Mondo pieno i pirati e avventure', 16.99, 77, 'Manga', 'Cartaceo', 1999, 'productImages/books/Un pezzo.webp', '9788804670621', 'Eichiro Oda', '24'),
('Jujutsu Kaisen', 'Stregoni che combatto maledizioni', 13.99, 93, 'Manga', 'Cartaceo', 2017, 'productImages/books/Jujutsu.webp', '97888046706934', 'Gege Akutami', '22'),
('One Punch Man', 'L eroe piu forte che sia mai esistito', 17.50, 123, 'Manga', 'Cartaceo', 2012, 'productImages/books/ONE.webp', '9788804670635', 'ONE', '43'),
('Sakamoto Days', 'L assassino leggendario oramai ritirato', 10.00, 140, 'Manga', 'Cartaceo', 2020, 'productImages/books/Sakamoto.webp', '9788804670693', 'Suzuki Yuuto', '30'),
('Ken il guerriero', 'Mondo post apocalittico dove regna sovrana la violenza', 29.99, 100, 'Manga', 'Cartaceo', 1983, 'productImages/books/Ken.webp', '9788804670692', 'Buronson', '60'),
('20th Century Boys', 'Ricordi di infanzia diventano realta', 21.49, 37, 'Manga', 'Cartaceo', 1999, 'productImages/books/20th.webp', '9788804670691', 'Naoki Urasawa', '50'),
('Naruto', 'Villagi dove sono presenti Ninja con particolari abilita ', 13.70, 69, 'Manga', 'Cartaceo', 1998, 'productImages/books/Naruto.webp', '9788804670687', 'Masashi Kishimoto', '20');

INSERT INTO cliente (Email, Username, `Password`, Nome, Cognome, `Data nascita`, Città, Via, CAP, `Nome carta`, `Numero carta`, `Data scadenza`, CVV)
VALUES 
('admin@gmail.com', 'admin', SHA2('bookscape',512), 'Admin', 'Admin', '1990-05-15', 'Roma', 'Via Roma', '10100', 'Admin admin', '123456789012', '2025-12-31', '123');

INSERT INTO amministratore (Email)
VALUES
('admin@gmail.com');