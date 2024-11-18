-- ***************************************************************
-- * File Name:                  dbs_manipulation.sql            *
-- * File Creator:               Knolle                          *
-- * LastDate:                   10.01.2024                      *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme WS 2023/24
-- * Uebung 8
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
set 	echo 		on
set 	linesize 	128
set 	pagesize 	50
--
-- Spaltenformatierung (nur für die Ausgabe)
--
column 	lv_name     format A35 WORD_WRAPPED
column 	beruf       format A30 WORD_WRAPPED
column 	fb_name     format A35 WORD_WRAPPED
column 	institution format A20 WORD_WRAPPED
column 	strasse     format A20 WORD_WRAPPED
column 	ort         format A20 WORD_WRAPPED
column 	lv_name     format A30 WORD_WRAPPED
column 	titel       format A20 WORD_WRAPPED
column 	vorname     format A20 WORD_WRAPPED
column 	ort         format A20 WORD_WRAPPED
column 	fachgebiet  format A20 WORD_WRAPPED
column 	pers_nr     format A15 WORD_WRAPPED
column 	ho_name     format A20 WORD_WRAPPED
column 	NULL        format A6  WORD_WRAPPED
--
-- Protokolldatei
--
-- Systemdatum
--
spool ./dbs_manipulation.log
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss')
  FROM   dual
  ;
--
-- ***************************************************************
-- * S Q L - B E I S P I E L M A N I P U L T I O N E N
--
--  Bitte beachten Sie, dass sich die angegebene Anzahl zu aktualisierender Datensätze auf die
--  unveränderte Übungsdatenbank bezieht. Sollten Sie Ihre Datensätze zwischenzeitlich verändert
--  haben, dann besteht jederzeit die Möglichkeit die Übungsdatenbank neu aufzubauen (siehe Übung 6/7).
--
--  3.1   Änderung von Datensätzen
--
--      Ändern Sie die folgenden Datensätze jeweils im Rahmen
--      eines einzelnen SQL-Befehls:
--
--      Ändern Sie die Hausnummer des Gebäudes "A" in "97". (Anzahl zu aktualisierender Zeilen: 1)
--
-- <3.1.1>
UPDATE dbs_tab_gebaeude
SET haus_nr=97
WHERE gebaeude='A';

-- </3.1.1>
--
--      Erhöhen Sie das Gehalt aller Mitarbeiter um 4 Prozent. (Anzahl zu aktualisierender Zeilen: 14)
--
-- <3.1.2>
UPDATE   dbs_tab_mitarbeiter
SET      gehalt = gehalt + gehalt * 4 / 100
;
SELECT * FROM dbs_tab_mitarbeiter;

-- </3.1.2>
--
--      Professor Becker wird neuer Dekan des Fachbereichs Informatik. (Anzahl zu aktualisierender Zeilen: 1)
--
--      Frage: Wie können Sie die zur Beantwortung dieser Änderung
--      erforderlichen beiden SQL-Befehle zu einem Befehl kombinieren?
--
-- <3.1.3>
UPDATE dbs_tab_fachbereich 
set dekan = (SELECT pers_nr 
             from dbs_tab_mitarbeiter m, dbs_tab_hochschulangehoeriger
             where m.ho_nr=h.ho_nr
             and ho_name='Becker')
where fb_name='Informatik';
select pers_n from dbs_tab_mitarbeiter;
-- </3.1.3>
--
--      Ändern Sie die Straßenangabe des Professors mit dem
--      Fachgebiet "Statistik" in "Siegburger Straße 99a" um. (Anzahl zu aktualisierender Zeilen: 1)
--
--      Frage: Was muss beachtet werden, wenn Sie in der
--      SET-Anweisung mit Unteranfrage das "="-Zeichen verwenden?
--
-- <3.1.4>
UPDATE dbs_tab_anschrift
SET strasse='Siegburger Straße ', HAUS_NR='99a'
WHERE ho_nr=(SELECT ho_nr 
            FROM dbs_tab_mitarbeiter
            WHERE pers_nr=(SELECT pers_nr 
                            FROM DBS_TAB_PROFESSOR
                            WHERE fachgebiet='Statistik'));
                            
 SELECT * FROM dbs_tab_anschrift;                           

-- </3.1.4>

--		Alle Teilnehmer der letzten Prüfung in Datenbanksysteme
--		erhalten eine Notenverbesserung um 10%. (Anzahl zu aktualisierender Zeilen: 2)
--
-- <3.1.5>
UPDATE dbs_tab_pruefung
SET note =  note + note * 10 / 100
WHERE lv_nr=(SELECT lv_nr 
            FROM dbs_tab_lehrveranstaltung
            WHERE lv_name='Datenbanksysteme');

-- </3.1.5>
--
--      Frage: Worauf muss geachtet werden, wenn die lv_nr der
--		Lehrveranstaltung ermittelt wird?
--


--
--	3.2   Einfügen neuer Datensätze
--
--      Fügen Sie die folgenden Datensätze ein:
--
--      Erfassen Sie die neuen Gebäuden "G" und "H", die in der Straße "Grantham-Allee"
--      noch ohne Hausnummer stehen. (Anzahl einzufügender Zeilen: 2)
--
-- <3.2.1>
INSERT INTO dbs_tab_gebaeude (gebaeude,strasse) VALUES ( 'G' , 'Grantham-Allee');
INSERT INTO dbs_tab_gebaeude (gebaeude,strasse) VALUES ( 'H' , 'Grantham-Allee');


-- </3.2.1>
--
--      Die neue Lehrveranstaltung "Objektrelationale Datenbanken" des
--      Fachbereichs Informatik soll jeden Mittwoch um 11:45 Uhr
--      im Raum 321 des Gebäudes G stattfinden. Dozent ist
--      Prof. Becker. (Anzahl einzufügender Zeilen: 2)
--
--      Frage: Welchen Primärschlüsselwert erhält die
--      neue Lehrveranstaltung?
--
--      Hinweis: Die nächste freie Schlüsselnummer erhält man
--      mit „SELECT MAX(<attribut>)+1 FROM <tabelle>“.
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge
--      eingefügt werden?
--
--      Frage: Wie lassen sich die Values direkt mit einem
--      SELECT-Befehl ermitteln und einfügen?
-- <3.2.2>

INSERT INTO dbs_tab_lehrveranstaltung VALUES ( (SELECT MAX(lv_nr)+1 FROM dbs_tab_lehrveranstaltung) , 'Objektrelationale Datenbanken' , 2);

SELECT * FROM dbs_tab_hochschulangehoeriger;

SELECT * FROM dbs_tab_lehrveranstaltung;

INSERT INTO dbs_tab_lv_ort VALUES ( (SELECT MAX(lv_nr) FROM dbs_tab_lehrveranstaltung) , 'Mi' , '1115' , 'C' ,'321' );

SELECT * FROM  dbs_tab_lv_ort;

INSERT INTO dbs_tab_prof_haelt_LV VALUES ( '508523' , (SELECT MAX(lv_nr) FROM dbs_tab_lehrveranstaltung) , 'Mi' , '1115' );

SELECT * FROM  dbs_tab_prof_haelt_LV;

-- </3.2.2>
--
--      Eine neue Lehrkraft wurde an den Fachbereich Informatik
--      berufen. Es handelt sich um die Professorin "Dr.
--      Roberta Maria Feinbein, 53113 Bonn,
--      Hauptstrasse 99". Sie wird mit einem monatlichen Gehalt
--      von 5.999 € die Forschung und Lehre des Fachgebiets
--      "Rechentechnik" vertreten. Ihre Heimatanschrift lautet
--      "Jahnwiese 19, 47051 Duisburg". (Anzahl einzufügender/zu aktualisierender Zeilen: 8)
--
--      Frage: In welchen Tabellen muss in welcher Reihenfolge
--      eingefügt werden?
--
--      Frage: Wie lasen sich die neuen Primärschlüsselwerte
--      ohne "Auto-Increment“ ermitteln?
--
--      Hinweis: Die nächste freie Schlüsselnummer erhält man
--      mit "SELECT MAX(<attribut>)+1 FROM <tabelle>". Leider
--      ist die Personalnummer als CHAR(10) kein Datentyp, auf
--      dem der "+"-Operator definiert ist. Da aber lediglich
--      Ziffernwerte verwendet werden, kann man sich wie folgt
--      behelfen, ohne die Konsistenz der Daten zu gefährden:
--      "SELECT to_char(MAX(to_number(<attribut>))+1)
--      FROM <tabelle>".
--
-- <3.2.3>

SELECT MAX(ho_nr)+1 FROM dbs_tab_hochschulangehoeriger;
INSERT INTO dbs_tab_hochschulangehoeriger VALUES ( 1031 , 'Feinbein' );

INSERT INTO dbs_tab_mitarbeiter VALUES (602223 , 1031 , 2 , 'Forschung und Lehre' , ' Professor' , 5999 , NULL );

INSERT INTO dbs_tab_professor VALUES ( 'Prof. Dr.' , '602223' , 'Rechentechnik' );

INSERT INTO dbs_tab_vorname Values ( 1031 , 1 , 'Roberta' );

INSERT INTO dbs_tab_vorname Values ( 1031 , 2 , 'Maria' );

INSERT INTO dbs_tab_anschrift VALUES ( 1031 , 1 , 53113 , 'Bonn' , 'Hauptstrasse' , '99' );
INSERT INTO dbs_tab_anschrift VALUES ( 1031 , 2 ,  47051 , 'Duisburg' , 'Jahnwiese' , '19' );


--mit der (rollback;)-befehl kann mann commit, zurück machen

-- </3.2.3>

--
--      3.3    Löschen von Datensätzen
--
--      Löschen Sie die folgenden Datensätze:
--
--      Löschen Sie das oben eingefügte Gebäude "B", das von keiner
--      Lehrveranstaltung belegt wird. (Anzahl zu löschender Zeilen: 1)
--
-- <3.3.1>

DELETE FROM dbs_tab_gebaeude WHERE gebaeude='B';
-- </3.3.1>
--
-- 		Der Studierende Leon Barsch, mit der Matr-Nr. 808603 hat sich
--      von allen Prüfungen abgemeldet. Löschen sie die aktuellen
--      Anmeldungen zu seinen Prüfungen. (Anzahl zu löschender Zeilen: 2)
--
--		Frage: Wie gehen Sie vor, wenn die Matr-Nr. nicht bekannt ist?
--
-- <3.3.2>
DELETE FROM dbs_tab_pruefung WHERE Matr_Nr=808603;


-- </3.3.2>

--
--      Der Professor mit der Personalnummer 508322 hat
--      gekündigt. (Anzahl zu löschender/aktualisierender Zeilen: 10)
--
--      Frage: In welchen Tabellen muss gelöscht werden?
--
--      Frage: Warum ist nicht jede beliebige Löschreihenfolge möglich?
--
--      Frage: Wie können Sie sich die "ho_nr" merken, ohne sie zu wissen?
--
-- <3.3.3>


DELETE FROM dbs_tab_anschrift WHERE ho_nr=(SELECT ho_nr FROM dbs_tab_mitarbeiter WHERE pers_nr=508322) ; --ok
DELETE FROM dbs_tab_vorname WHERE ho_nr=(SELECT ho_nr FROM dbs_tab_mitarbeiter WHERE pers_nr=508322) ; --ok
DELETE FROM dbs_tab_hochschulangehoeriger WHERE ho_nr=(SELECT ho_nr FROM dbs_tab_mitarbeiter WHERE pers_nr=508322);--geht noch nicht
DELETE FROM dbs_tab_prof_haelt_lv WHERE pers_nr=508322; --ok
DELETE FROM dbs_tab_professor WHERE  pers_nr=508322; --ok
DELETE FROM dbs_tab_mitarbeiter WHERE pers_nr=508322; --geh noch nicht
DELETE FROM dbs_tab_pruefung WHERE Matr_Nr=808603;
DELETE FROM dbs_tab_pruefung WHERE Matr_Nr=808603;
DELETE FROM dbs_tab_pruefung WHERE Matr_Nr=808603;
DELETE FROM dbs_tab_pruefung WHERE Matr_Nr=808603;

rollback;
-- </3.3.3>

--
--      Die Lehrveranstaltung "Statistik" ist gestrichen worden. (Anzahl zu löschender Zeilen: 5)
--
-- <3.3.4>
DELETE FROM dbs_tab_gebaeude WHERE gebaeude=(SELECT gebaeude FROM dbs_tab_lv_ort );--NICHT OK
DELETE FROM dbs_tab_lv_ort WHERE lv_nr=(SELECT lv_nr FROM dbs_tab_lehrveranstaltung WHERE lv_name='Statistik');
DELETE FROM dbs_tab_pruefung WHERE lv_nr=(SELECT lv_nr FROM dbs_tab_lehrveranstaltung WHERE lv_name='Statistik');
DELETE FROM dbs_tab_prof_haelt_lv WHERE lv_nr=(SELECT lv_nr FROM dbs_tab_lehrveranstaltung WHERE lv_name='Statistik');
DELETE FROM dbs_tab_lehrveranstaltung WHERE lv_name='Statistik';




-- </3.3.4>

--
-- Systemdatum
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss')
  FROM   dual
  ;
--
--
spool off