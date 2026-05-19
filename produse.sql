DROP TABLE IF EXISTS produse;
DROP TYPE IF EXISTS categ_moto;
DROP TYPE IF EXISTS tip_utilizare;
DROP TYPE IF EXISTS marca_moto; 
DROP TYPE IF EXISTS tip_permis; 

CREATE TYPE categ_moto AS ENUM('Motociclete_Noi', 'Motociclete_Second-Hand', 'Scutere_Noi', 'Scutere_Second-Hand');

CREATE TYPE tip_utilizare AS ENUM('street', 'off-road', 'touring', 'racing');

CREATE TYPE marca_moto AS ENUM('KTM', 'Honda', 'Yamaha', 'Kawasaki', 'Vespa', 'BMW');

CREATE TYPE tip_permis AS ENUM('AM', 'A1', 'A2', 'A');

CREATE TABLE IF NOT EXISTS produse (
   id SERIAL PRIMARY KEY,
   nume VARCHAR(100) UNIQUE NOT NULL,
   descriere TEXT,
   imagine VARCHAR(300), 
   categorie categ_moto NOT NULL, 
   utilizare tip_utilizare DEFAULT 'street',
   permis tip_permis NOT NULL, 
   pret NUMERIC(10,2) NOT NULL, 
   capacitate_motor INT NOT NULL CHECK (capacitate_motor > 0), 
   data_fabricatie DATE NOT NULL, 
   marca marca_moto NOT NULL, 
   dotari VARCHAR[], 
   in_stoc BOOLEAN NOT NULL DEFAULT TRUE 
);

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO razvansql;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO razvansql;



INSERT INTO produse (nume, descriere, imagine, categorie, utilizare, permis, pret, capacitate_motor, data_fabricatie, marca, dotari, in_stoc) VALUES 

-- === MOTOCICLETE NOI (5) ===
('KTM Super Duke R', 'Aceasta motocicleta KTM Super Duke R reprezinta definitia agresivitatii pe doua roti, fiind supranumita Bestia naked suprema. Motorul generos ofera o putere bruta, sustinuta de o electronica avansata ce include un sistem quickshifter bidirectional pentru schimbari instantanee. Siguranta este garantata de pachetul abs cornering, in timp ce pilotul poate alege diverse moduri de condus pentru a controla cuplul masiv. Tehnologia launch control imprumutata de la circuitele de GP asigura demaraje perfecte, facand din acest model un monstru de performanta pe asfalt.', 'duke1390.png', 'Motociclete_Noi', 'street', 'A', 21500.00, 1350, '2024-03-15', 'KTM', '{"quickshifter", "abs cornering", "moduri condus", "launch control"}', true),

('Honda Africa Twin CRF-L', 'Legenda Honda Africa Twin CRF-L revine cu o configuratie axata pe expeditii transcontinentale si aventura fara limite. Modelul este echipat din fabrica cu un scut motor robust si carcase laterale din aluminiu, fiind gata sa transporte toate bagajele necesare pe drumuri de munte sau nisip. Protectia la vant este asigurata de un parbriz inalt reglabil, oferind un confort superior pe autostrada. Este o motocicleta versatila care combina manevrabilitatea pe teren accidentat cu stabilitatea remarcabila la drum lung, ideala pentru exploratori.', 'africatwin.png', 'Motociclete_Noi', 'off-road', 'A', 15800.00, 1084, '2023-10-20', 'Honda', '{"carcase laterale", "parbriz inalt", "scut motor"}', true),

('Yamaha MT', 'Noul Yamaha MT impresioneaza prin designul sau futuristic si agresiv, axat pe conceptul Hyper Naked. Inima acestei motociclete este motorul CP3 care livreaza un sunet inconfundabil si un cuplu generos la orice turatie. Pachetul de dotari include lumini led de mare intensitate, sistem de control tractiune reglabil si abs de ultima generatie. Este vehiculul ideal pentru jungla urbana, oferind o agilitate uimitoare si un raspuns prompt la acceleratie, transformand fiecare naveta zilnica intr-o doza pura de adrenalina si distractie.', 'mt09.png', 'Motociclete_Noi', 'street', 'A', 11200.00, 890, '2024-01-10', 'Yamaha', '{"abs", "control tractiune", "lumini led"}', true),

('Kawasaki Ninja H SX', 'Daca esti in cautarea luxului extrem combinat cu o acceleratie brutala, Kawasaki Ninja H SX este singura optiune sport-touring dotata cu un compresor mecanic. Tehnologia radar adaptiv si functia de cruise control fac calatoriile pe autostrada extrem de relaxante si sigure. Confortul termic este asigurat de manere incalzite, iar pozitia de condus este optimizata pentru touring pe distante uriase. Este o vitrina tehnologica pe doua roti, oferind o experienta de condus premium pentru cei care nu vor sa faca niciun compromis intre viteza si confort.', 'ninjah2.png', 'Motociclete_Noi', 'touring', 'A', 28500.00, 998, '2024-02-05', 'Kawasaki', '{"radar adaptiv", "cruise control", "manere incalzite"}', true),

('BMW R GS', 'BMW R GS stabileste un nou etalon in clasa adventure, fiind proiectata pentru a domina orice tip de teren. Aceasta motocicleta este echipata cu o suspensie electronica inteligenta care se adapteaza automat la greutatea bagajelor si tipul de drum. Navigatia este simplificata de sistemul gps integrat, iar cilindrii motorului boxer sunt protejati de protectii cilindri rezistente. Mai usoara si mai puternica decat generatiile anterioare, acest model ofera o stabilitate incredibila si sisteme inteligente care fac explorarea lumii o placere absoluta.', 'r1300gs.png', 'Motociclete_Noi', 'touring', 'A', 19900.00, 1300, '2023-11-25', 'BMW', '{"suspensie electronica", "gps", "protectii cilindri"}', true),

-- === MOTOCICLETE SH (6) ===
('Honda CBR RR SH', 'Acest exemplar de Honda CBR RR SH reprezinta varful ingineriei japoneze pentru supersport. Este o motocicleta intretinuta maniacal, fiind echipata cu o evacuare Akrapovic ce ofera un sunet de circuit si un plus de putere. Pentru o stabilitate sporita la viteze mari, a fost adaugat un amortizor ghidon profesional. Starea estetica este impecabila, fara urme de accident sau uzura motorului, fiind o alegere ideala pentru pasionatii de track-days care cauta performanta unui model legendar la un pret accesibil.', 'cbr600sh.png', 'Motociclete_Second-Hand', 'racing', 'A', 6500.00, 599, '2018-06-12', 'Honda', '{"evacuare Akrapovic", "amortizor ghidon"}', true),

('Yamaha Tenere Rally', 'Pregatita pentru cele mai dure competitii de amatori, Yamaha Tenere Rally vine intr-o configuratie orientata spre off-road extrem. Dispune de un sistem abs decuplabil manual pentru control total pe coborarile cu nisip sau noroi. Sasiul este protejat de un scut motor heavy duty din otel, iar suspensiile reglabile permit abordarea traseelor montane cu usurinta. Este o motocicleta robusta, cu un istoric curat, perfecta pentru pilotii care vor sa paraseasca asfaltul si sa exploreze zonele salbatice unde drumul se termina.', 'tenere700sh.png', 'Motociclete_Second-Hand', 'off-road', 'A', 9800.00, 689, '2021-04-30', 'Yamaha', '{"abs decuplabil", "scut motor heavy duty"}', true),

('Kawasaki Z SH', 'Acest naked Kawasaki Z SH ofera un echilibru perfect intre puterea unui motor cu patru cilindri si manevrabilitatea necesara in oras. Dotata cu abs de serie si protectii radiator suplimentare, motocicleta a fost folosita preponderent pentru plimbari de weekend. Este o varianta fiabila si economica pentru segmentul de motociclete rulate, avand toate reviziile la zi. Desi prezinta mici semne estetice normale, functionalitatea mecanica este de 100%, fiind un raport pret-performanta imbatabil pentru un rider experimentat sau incepator.', 'z900sh.png', 'Motociclete_Second-Hand', 'street', 'A', 7200.00, 948, '2020-08-15', 'Kawasaki', '{"abs", "protectii radiator"}', false),

('KTM Adventure SH', 'O optiune excelenta pentru posesorii de permis A2, acest KTM Adventure SH este agil si surprinzator de capabil pe drumurile forestiere. Motocicleta beneficiaza de conectivitate bluetooth pentru navigatie si apeluri, oferind un confort tehnologic modern. Siguranta este sporita de sistemul abs si protectiile de maini (handguards) care protejeaza impotriva vantului si a crengilor. Este un vehicul polivalent, usor de intretinut, ideal pentru tinerii care doresc sa imbine naveta urbana cu mici escapade in natura in weekend.', 'ktm390sh.png', 'Motociclete_Second-Hand', 'off-road', 'A2', 5100.00, 373, '2022-05-20', 'KTM', '{"abs", "bluetooth", "handguards"}', true),

('BMW S RR SH', 'Tehnologie de varf si electronica sofisticata, modelul BMW S RR SH ofera o putere masiva intr-un pachet extrem de precis. Aceasta motocicleta second-hand este echipata cu jante carbon ultra-usoare si o evacuare titan care reduce greutatea totala. Sistemul quickshifter permite schimbari de viteza fara ambreiaj, optimizand timpul pe circuit. Este alegerea suprema pentru amatorii de viteza si racing care doresc sa detina un model de top, mentinut in conditii tehnice excelente si gata pentru competitie.', 's1000rrsh.png', 'Motociclete_Second-Hand', 'racing', 'A', 16500.00, 999, '2021-09-10', 'BMW', '{"jante carbon", "evacuare titan", "quickshifter"}', true),

('Honda CB X SH', 'Un crossover versatil si fiabil, Honda CB X SH este recunoscut pentru consumul redus de combustibil si pozitia de condus relaxata. Perfecta pentru posesorii de permis A2, motocicleta vine echipata cu un topcase generos pentru depozitare si un cric central util pentru mentenanta. Este partenerul ideal pentru naveta zilnica si calatorii de distanta medie, oferind o protectie decenta la vant si o manevrabilitate sporita in traficul urban. O motocicleta rulata cu grija, fara defecte mecanice ascunse.', 'cb500xsh.png', 'Motociclete_Second-Hand', 'touring', 'A2', 5800.00, 471, '2019-03-05', 'Honda', '{"topcase", "cric central"}', true),

-- === SCUTERE NOI (5) ===
('Vespa Primavera', 'Simbolul elegantei urbane, Vespa Primavera continua traditia italiana intr-un format compact si sofisticat. Acest scuter este echipat cu un portbagaj cromat stralucitor si o mufa usb utila pentru incarcarea dispozitivelor in timpul mersului. Motorul silentios ofera o deplasare fluida prin trafic, in timp ce finisajele premium atrag toate privirile. Este alegerea perfecta pentru persoanele care cauta o mobilitate chic, fara efort, intr-un oras aglomerat unde stilul conteaza la fel de mult ca functionalitatea.', 'vespa_prim.png', 'Scutere_Noi', 'street', 'A1', 4200.00, 124, '2024-01-20', 'Vespa', '{"portbagaj cromat", "mufa usb"}', true),

('Honda PCX', 'Cel mai bine vandut scuter din Europa, Honda PCX este renumit pentru sistemul start-stop eficient care reduce drastic consumul. Dotat cu tehnologie keyless go pentru un pornire rapida si abs pentru o franare sigura, scuterul ofera si un portbagaj spatios sub sa pentru o casca integrala. Este vehiculul ideal pentru naveta zilnica la birou, combinand costurile minime de intretinere cu o fiabilitate legendara. Designul modern si farurile led ii confera o prezenta vizibila si sigura in trafic.', 'hondapcx.png', 'Scutere_Noi', 'street', 'A1', 3600.00, 125, '2024-02-15', 'Honda', '{"keyless go", "abs", "start-stop"}', true),

('Yamaha TMAX Tech MAX', 'Regele maxi-scuterelor, Yamaha TMAX Tech MAX, ofera un nivel de dotari comparabil cu o motocicleta de lux. Parbrizul reglabil electric permite ajustarea fluxului de aer din mers, in timp ce scaunul incalzit asigura confortul in zilele racoroase. Functia de cruise control este perfecta pentru drumurile lungi in afara orasului. Cu o putere remarcabila si o stabilitate de invidiat, acest model sterge granitele dintre scuter si motocicleta, fiind creat pentru cei care vor sa calatoreasca pe distante mari intr-un confort absolut.', 'tmax.png', 'Scutere_Noi', 'touring', 'A2', 14500.00, 562, '2024-03-01', 'Yamaha', '{"parbriz electric", "scaun incalzit", "cruise control"}', true),

('Vespa Elettrica', 'Viitorul mobilitatii urbane este aici cu Vespa Elettrica, un model care redefineste conceptul de scuter prin eliminarea zgomotului si a emisiilor poluante. Aceasta varianta 100% electrica dispune de o functie de marsarier pentru manevre facile in spatii inguste si se conecteaza la o aplicatie smartphone dedicata pentru monitorizarea bateriei. Finisajele sunt de lux, iar acceleratia lina fara trepte de viteza ofera o experienta de condus relaxanta si moderna. Este solutia ideala pentru orasele care incurajeaza transportul ecologic si sustenabil.', 'vespa_el.png', 'Scutere_Noi', 'street', 'AM', 6500.00, 50, '2023-12-10', 'Vespa', '{"marsarier", "aplicatie smartphone"}', true),

('Honda Forza', 'Combinatia ideala intre agilitatea unui scuter de oras si puterea necesara pe autostrada, Honda Forza vine cu un pachet complet de siguranta: abs si control tractiune. Spatiul generos sub sa permite depozitarea a 2 casti, facandu-l extrem de practic pentru cumparaturi sau plimbari in doi. Protectia la vant este excelenta datorita caroseriei aerodinamice, iar motorul modern ofera reprize de acceleratie surprinzatoare. Este un scuter premium, versatil, pregatit sa faca fata oricarei provocari cotidiene.', 'forza350.png', 'Scutere_Noi', 'street', 'A2', 6500.00, 330, '2024-01-05', 'Honda', '{"abs", "control tractiune", "spatiu 2 casti"}', true),

-- === SCUTERE SH (6) ===
('Yamaha NMAX SH', 'Un scuter compact si sportiv, Yamaha NMAX SH este dotat cu motorizarea Blue Core care asigura un consum remarcabil. Pachetul include sistem abs pentru siguranta si stop led pentru o vizibilitate sporita. Este o varianta rulata, dar mentinuta intr-o stare mecanica foarte buna, fiind ideala pentru cineva care doreste o solutie rapida si moderna de strecurat prin traficul aglomerat. Desi este un model la mana a doua, finisajele sunt rezistente iar intretinerea a fost facuta doar in service-uri autorizate.', 'nmaxsh.png', 'Scutere_Second-Hand', 'street', 'A2', 2900.00, 155, '2021-07-20', 'Yamaha', '{"abs", "stop led"}', true),

('Vespa GTS Super SH', 'Vespa GTS Super SH este cel mai puternic model din gama clasica italiana, oferind o prezenta impunatoare. Acest scuter second-hand beneficiaza de sisteme de siguranta precum abs si asr (controlul tractiunii), oferind incredere pe suprafete umede. Protectia la vant este sporita de un parbriz mic, ideal pentru plimbarile relaxante in afara orasului. Caroseria din otel este intr-o stare excelenta, pastrand stralucirea specifica brandului, fiind o piesa de colectie care poate fi folosita zilnic cu placere.', 'gtssh.png', 'Scutere_Second-Hand', 'street', 'A2', 4800.00, 278, '2018-11-12', 'Vespa', '{"abs", "asr", "parbriz mic"}', true),

('Honda Vision SH', 'Solutia economica si practica pentru curierat sau naveta rapida, Honda Vision SH este un model de scuter imbatabil la capitolul fiabilitate. Vine echipat cu un topcase mare pentru livrari sau cumparaturi si un suport telefon robust pe ghidon. Desi are un istoric de utilizare urbana intensa, motorul porneste la sfert si consumul ramane simbolic. Este vehiculul care nu te lasa la greu, oferind costuri de intretinere minime si o manevrabilitate imbatabila in spatiile foarte inguste din parcarile orasului.', 'visionsh.png', 'Scutere_Second-Hand', 'street', 'A1', 1500.00, 108, '2017-05-30', 'Honda', '{"topcase mare", "suport telefon"}', true),

('Vespa LX SH', 'Scuterul Vespa LX SH este ideal pentru incepatori sau tineri exploratori urbani, avand dimensiuni compacte. Acest model rulat dispune de un antifurt mecanic integrat, oferind o siguranta sporita in timpul stationarii. Designul sau retro atemporal il face sa nu para niciodata demodat, in timp ce sasiul din otel asigura o durabilitate pe care scuterele moderne din plastic nu o pot egala. Momentan acest produs este indisponibil in depozit, dar ramane un etalon de stil si simplitate pentru categoria AM.', 'lx50sh.png', 'Scutere_Second-Hand', 'street', 'AM', 1200.00, 49, '2015-04-10', 'Vespa', '{"antifurt mecanic"}', false),

('Yamaha XMAX SH', 'Oferind o capacitate uriasa de depozitare si un confort sporit, Yamaha XMAX SH este un maxi-scuter extrem de popular. Varianta prezentata include un sistem de evacuare sport care ii ofera un sunet mai agresiv si un abs functional pentru siguranta maxima. Este pregatit pentru navetistii de distanta lunga, oferind o protectie foarte buna la intemperii si o pozitie relaxata a picioarelor. O alegere inteligenta pentru cei care vor dotari de top la un pret de vehicul second-hand corect.', 'xmaxsh.png', 'Scutere_Second-Hand', 'touring', 'A2', 5200.00, 395, '2019-10-25', 'Yamaha', '{"abs", "evacuare sport"}', true),

('Kawasaki J SH', 'Kawasaki J SH imbina confortul unui scuter de lux cu spiritul sportiv al brandului Kawasaki. Designul ascutit este completat de un parbriz fumuriu care ofera un aspect agresiv si o protectie eficienta. Dotat cu abs si o ciclistica stabila, scuterul se simte sigur chiar si la viteze de autostrada. Este un model rulat care a beneficiat de o intretinere riguroasa, fiind ideal pentru cei care vor sa se diferentieze in trafic printr-un scuter cu personalitate sportiva si performante dinamice excelente.', 'j300sh.png', 'Scutere_Second-Hand', 'street', 'A2', 3400.00, 299, '2018-02-14', 'Kawasaki', '{"abs", "parbriz fumuriu"}', true);