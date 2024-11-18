-- ***************************************************************
-- * File Name:                  eigen_query.sql
-- * File Creator:               Knolle
-- * CreationDate:               8.12.2023
-- *
-- * Student:                    <Who am I>
-- *
-- * <Ihre eigenen Kommentare>
-- *
-- ***************************************************************
--
-- *** Bitte verwenden Sie als Zeichenkodierung immer UTF-8    ***
--
-- ***************************************************************
-- * Datenbanksysteme WS 2023
-- * Anfragen auf der eigenen Datenbank
-- *
-- ***************************************************************
-- * SQL*plus Job Control Section
--
-- <sqlplus>

set echo on
set linesize 80
set pagesize 50

--
-- ***************************************************************
-- * Spaltenformatierung (nur fuer die Formatierung Ihrer Ausgabe)
-- * Beispiele - bitte mit Ihren eigenen Attributen anpassen
--
-- column 	ho_name     format A20 WORD_WRAPPED
-- column 	beruf       format A25 WORD_WRAPPED
-- column 	fb_name     format A25 WORD_WRAPPED
-- column 	institution format A20 WORD_WRAPPED
-- column 	strasse     format A20 WORD_WRAPPED
-- column 	haus_nr     format A5  WORD_WRAPPED
-- column 	ort         format A15 WORD_WRAPPED
-- column 	titel       format A10 WORD_WRAPPED
-- column 	vorname     format A10 WORD_WRAPPED
-- column 	ort         format A20 WORD_WRAPPED
-- column 	fachgebiet  format A17 WORD_WRAPPED
-- column 	pers_nr     format A11 WORD_WRAPPED
column 	NULL        format A6  WORD_WRAPPED
--
-- Protokolldatei
--
spool ./eigen.log

-- Kommentieren Sie den folgenden Befehl ein, damit der SQL-Developer beim ersten Fehler abbricht.
-- whenever sqlerror exit sql.sqlcode
--
-- </sqlplus>
--
-- ***************************************************************
-- * D I E    E I G E N E    D A T E N B A N K
--
--   BITTE BERÜCKSICHTIGEN SIE BEI DER LÖSUNG DER AUFGABEN DEN
--   KONKRETEN TEXT DES AUFGABENBLATTS!
--
--      5.1	Auswahl der Übungstabellen
--
--      Geben Sie die Struktur Ihrer vier ausgewählten Tabellen mit
--      dem „DESCRIBE“-Befehl aus.
--
-- <auswahl>

 DESCRIBE hrs_tab_veranstaltung;

 DESCRIBE hrs_tab_Rezeptionist;

 DESCRIBE hrs_tab_gast;
 
 DESCRIBE hrs_tab_einplanen;


-- </auswahl>

--     Hinweis: Fremdschlüssel-Constraints, die aus der Kette der vier
--     ausgewählten Tabellen herauszeigen, können Sie für die Übung gerne
--     deaktivieren, um keine Datensätze in weitere Tabellen einfügen zu
--     müssen.
--
-- <disable_fk>

ALTER TABLE hrs_tab_veranstaltung DISABLE CONSTRAINT fk_veranstaltung_gebaeude;
ALTER TABLE hrs_tab_Rezeptionist DISABLE CONSTRAINT fk_Rezeptionist_Rezeptionist;
ALTER TABLE hrs_tab_gast DISABLE CONSTRAINT fk_gast_Rezeptionist;



-- </disable_fk>

--      5.2	Import der Datenbank
--
--      Fügen Sie insgesamt mindestens 20 Datensätze in die von Ihnen
--      ausgewählten vier Tabellen ein. Um bei der Aufgabe 5.3 c) auch den
--      „outer join“ sinnvoll anwenden zu können und damit bei der Aufgabe 5.3 g)
--      mindestens ein Datensatz gefunden wird, achten Sie bitte darauf,
--      dass nicht alle Stammdatensätze der N:M-Beziehung von der
--      N:M-Beziehungstabelle aus referenziert werden.
--
--      Hinweis: Verwenden Sie hier bitte nur die einfache INSERT-Syntax, bei der die
--               Spaltennamen nicht angegeben werden, sondern Werte (und ggf. NULL-Werte)
--               für alle Spalten angegeben werden müssen:
--
--               INSERT INTO <tabelle> VALUES (<Wert1>, <Wert2>, ...);
--
-- <import>
--
--      Tabelle 1:
--

 INSERT INTO hrs_tab_veranstaltung VALUES (01, 'canaval',200, '12.02.2024',1);
 INSERT INTO hrs_tab_veranstaltung VALUES (02, 'silvester',100, '01.01.2024',2);
 INSERT INTO hrs_tab_veranstaltung VALUES (03, 'weinachten',200, '25.12.2023',3);
 INSERT INTO hrs_tab_veranstaltung VALUES (04, 'geburstag',50, '15.05.2024',4);
 INSERT INTO hrs_tab_veranstaltung VALUES (05, 'T_Arbeit',1000, '01.05.2024',5);
 INSERT INTO hrs_tab_veranstaltung VALUES (06, 'D_Einheit',500, '03.10.2024',8);
 INSERT INTO hrs_tab_veranstaltung VALUES (07, 'ostern',75, '12.07.2024',6);
--
--      Tabelle 2:
--

 INSERT INTO hrs_tab_Rezeptionist VALUES (11,'Mo', 'Anzug mit rote M',121);
 INSERT INTO hrs_tab_Rezeptionist VALUES (12,'Sa', 'Anzug mit rote M',122);
 INSERT INTO hrs_tab_Rezeptionist VALUES (13,'Fr', 'Mantel mit rote M',123);
 INSERT INTO hrs_tab_Rezeptionist VALUES (14,'So', 'Mantel mit rote M',188);
 INSERT INTO hrs_tab_Rezeptionist VALUES (15,'Di', 'Mantel mit rote M',199);
 INSERT INTO hrs_tab_Rezeptionist VALUES (16,'Mi', 'Mantel mit rote M',1291);
 INSERT INTO hrs_tab_Rezeptionist VALUES (17,'So un Sa', 'Mantel mit rote M',1891);
 


--
--      Tabelle 3:
--

 INSERT INTO hrs_tab_gast VALUES (20,124, 'VIP',11);
 INSERT INTO hrs_tab_gast VALUES (21,125, 'business',11);
 INSERT INTO hrs_tab_gast VALUES (22,126, 'VIP',12);
 INSERT INTO hrs_tab_gast VALUES (23,127, 'business',13);
 INSERT INTO hrs_tab_gast VALUES (24,128, 'business',12);
 INSERT INTO hrs_tab_gast VALUES (25,129, 'Clasic',12);
 INSERT INTO hrs_tab_gast VALUES (26,1210, 'Clasic',11);
 INSERT INTO hrs_tab_gast VALUES (27,1211, 'VIP',11);
 INSERT INTO hrs_tab_gast VALUES (28,1212, 'Clasic',12);
 INSERT INTO hrs_tab_gast VALUES (29,1213, 'VIP',13);
--
--      Tabelle 4:
--


 INSERT INTO hrs_tab_einplanen VALUES (11,01,'12.02.2024');
 INSERT INTO hrs_tab_einplanen VALUES (12,02,'25.12.2023');
INSERT INTO hrs_tab_einplanen VALUES (13,03,'01.01.2024');
INSERT INTO hrs_tab_einplanen VALUES (13,04,'01.01.2024');
INSERT INTO hrs_tab_einplanen VALUES (13,05,'01.01.2024');
INSERT INTO hrs_tab_einplanen VALUES (13,06,'01.01.2024');



COMMIT;

-- ROLLBACK;
--
-- </import>

--
--      5.3 Lesen der Datensätze
--
--      Testen Sie Ihre Datenbank, indem Sie die folgenden Anfragen
--      durchführen:
--
--      5.3 a)  Jeweils Anzeige aller Daten Ihrer vier Tabellen.
--
--      Tabelle 1:
--
-- <53a>

 SELECT * FROM hrs_tab_veranstaltung;
 


--
--      Tabelle 2:
--

 SELECT * FROM hrs_tab_Rezeptionist;


--
--      Tabelle 3:
--

-- SELECT ...
 SELECT * FROM hrs_tab_gast;
 
--
--      Tabelle 4:
--

--SELECT ...
 SELECT * FROM hrs_tab_einplanen;


-- </53a>

--
--      5.3 b)  Einen (natürlichen) Verbund, der die Datensätze der vier Tabellen
--              semantisch sinnvoll verbunden ausgibt (Primär- und Fremdschlüsselwerte bitte weglassen).

-- <53b>

SELECT   name, gastanzahl, datum, arbeitstage, bekleidung, gast_standing
FROM  hrs_tab_veranstaltung  
         NATURAL JOIN hrs_tab_einplanen  
         NATURAL JOIN hrs_tab_rezeptionist 
         NATURAL JOIN hrs_tab_gast ;

-- </53b>

--
--      5.3 c)  Einen „vollständigen“ Verbund, der alle Datensätze der an der „N:M“-Beziehung direkt
--              beteiligten drei Tabellen semantisch sinnvoll verbunden ausgibt (Primär- und Fremdschlüssel-
--              werte bitte weglassen). Geben Sie hierbei (im Unterschied zu 5.3 b) ) auch solche
--              Datensätze der „linken“ und „rechten“) Tabelle aus, wenn diese nicht an der Beziehung
--              teilnehmen („outer join“, siehe Hinweis unter 5.2 e) auf dem Übungsblatt.
-- <53c>


SELECT *
FROM hrs_tab_Rezeptionist
FULL OUTER JOIN hrs_tab_einplanen ON hrs_tab_Rezeptionist.Stelle_id = hrs_tab_einplanen.Stelle_id
FULL OUTER JOIN hrs_tab_veranstaltung ON hrs_tab_einplanen.V_nr = hrs_tab_veranstaltung.V_nr;


-- </53c>

--
--      5.3 d)  Eine semantisch sinnvoll aggregierte Ausgabe, die über
--              eine „GROUP BY“- und „HAVING“-Klausel verfügt.
--
-- <53d>

    SELECT name 
    FROM hrs_tab_veranstaltung
    GROUP BY name
    HAVING AVG (gastanzahl )>100;     

-- </53d>

--
--      5.3 e)	Bestimmen (berechnen) Sie den nächsten freien Primärschlüsselwert für die „linke“
--              (oder „rechte“) an der „N:M“-Beziehung beteiligte Tabelle mit Hilfe von SQL.
--              Die nächste freie Schlüsselnummer erhält man mit einem Statement der Form:
--              "SELECT MAX(<spalte>)+1 FROM <tabelle>".
--
-- <53e>

    SELECT MAX(V_nr)+1 FROM hrs_tab_veranstaltung;

-- </53e>

--
--      5.3 f)  Wie lauten die Primärschlüsselwerte der Datensätze der „N:M“-Beziehungstabelle, die über
--              die kleinsten zusammengesetzten Primärschlüssel verfügen (die Summe beider Attributwerte
--              des zusammengesetzten Schlüssels ergibt den kleinsten Wert innerhalb der „N:M“-
--              Beziehungstabelle).
--
-- <53f>


SELECT MIN(Stelle_id), MIN(V_nr)
FROM hrs_tab_einplanen;


-- </53f>


--
--
--      5.3 g)  Zeigen Sie ausschließlich solche Datensätze der „linken“ (oder „rechten“) „N:M“-Tabelle an, die nicht von
--              der „N:M“-Beziehungstabelle referenziert werden (siehe Hinweis unter 5.2 e auf dem Übungsblatt).
--
-- <53g>

    
    SELECT r.*
FROM hrs_tab_Rezeptionist r
LEFT JOIN hrs_tab_einplanen e ON r.Stelle_id = e.Stelle_id
WHERE e.Stelle_id IS NULL;


-- </53g>

-- ***************************************************************
-- * SQL*plus Job Control Section
--
-- <sqlplus>

spool off

-- </sqlplus>
Download Solution