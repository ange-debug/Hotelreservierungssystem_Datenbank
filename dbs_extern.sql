-- ***************************************************************
-- * File Name:                  dbs_extern.sql                  *
-- * File Creator:               Knolle                          *
-- * LastDate:                   12.01.2024                      *
-- *                                                             *
-- * <ChangeLogDate>             <ChangeLogText>                 *
-- ***************************************************************
--
-- ***************************************************************
-- * Datenbanksysteme WS 2023/24
-- * Uebung 9
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
set 	echo 		on
set 	linesize 	256
set 	pagesize 	50
--
-- Spaltenformatierung (nur fuer die Ausgabe)
--
column 	ho_name     format A20 WORD_WRAPPED
column 	beruf       format A25 WORD_WRAPPED
column 	fb_name     format A25 WORD_WRAPPED
column 	institution format A20 WORD_WRAPPED
column 	strasse     format A20 WORD_WRAPPED
column 	haus_nr     format A5  WORD_WRAPPED
column 	ort         format A15 WORD_WRAPPED
column 	titel       format A10 WORD_WRAPPED
column 	vorname     format A10 WORD_WRAPPED
column 	ort         format A20 WORD_WRAPPED
column 	fachgebiet  format A17 WORD_WRAPPED
column 	pers_nr     format A11 WORD_WRAPPED
column 	NULL        format A6  WORD_WRAPPED
--
-- Protokolldatei
--
-- Systemdatum
--
spool ./dbs_extern.log
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss')
  FROM   dual
  ;
--
-- ***************************************************************
-- * S Q L - B E I S P I E L - V I E W S
--
CREATE OR
REPLACE VIEW
;

DESCRIBE

SELECT	      *
FROM
;

--
--      Erstellen Sie die folgenden Sichten:
--
--      Virtuelle Tabelle „Fachbereich“ mit allen Spalten der
--      korrespondierenden Tabelle der konzeptionellen Ebene
--      (Beispiel einer sehr einfachen View, die exakt der zugrunde
--      liegenden Tabelle entspricht).
--
CREATE OR
REPLACE VIEW  dbs_view_fachbereich
AS SELECT     fb_nr, fb_name, dekan
FROM          dbs_tab_fachbereich
;

DESCRIBE      dbs_view_fachbereich

SELECT	      *
FROM          dbs_view_fachbereich
;

--Merkung : mann kann nicht in der view tabelle hinzufügen, weil sie machmal nicht komplet sind, aber wenn diese komplet sind kann mach zum beispiel eine neue Dantensatz hinzufügen
--          mann kann bei der view löschen und die werden auch in der original tabelle löchen( achso mann kann mit eine eindeutig bedingung löschen
--          man kann aucg die dantensaätze duch view modifizieren wenn das prädikat gut defienieren ist
--          view, die min, max, avg haben können nicht modifizieren werden...
SELECT * FROM dbs_v_student;
DESCRIBE dbs_v_student;

SELECT	      *
FROM  dbs_v_student
;

--
--      Virtuelle Tabelle „Fachbereich hat Dekan“. Die View soll
--      nur die Spalten Name des Fachbereichs und Name des Dekans
--      enthalten.
--
CREATE VIEW Fachbereich_hat_Dekan 
AS SELECT fb_name, dekan
FROM dbs_tab_fachbereich;

SELECT * FROM Fachbereich_hat_Dekan;

--
--      Virtuelle Tabelle „Fachbereich beschaeftigt Mitarbeiter“.
--      Die View soll nur die Spalten Name des Fachbereichs und
--      Name des Mitarbeiters enthalten und standardmäßig nach
--      dem Namen des Fachbereichs und bei Gleichheit nach dem
--      Namen des Mitarbeiters sortiert werden.

CREATE VIEW Fachbereich_bietet_M
AS SELECT f.fb_name, h.ho_name 
FROM dbs_tab_fachbereich f, dbs_tab_hochschulangehoeriger h , dbs_tab_mitarbeiter
WHERE dbs_tab_mitarbeiter.ho_nr=h.ho_nr;
--
--      Virtuelle Tabelle „Fachbereich bietet Lehrveranstaltung“.
--      Die View soll lediglich den Namen des Fachbereichs und den
--      Namen der Lehrveranstaltung enthalten und nach dem Namen
--      der Lehrveranstaltung, sowie bei Gleichheit nach dem Namen
--      des Fachbereichs sortiert werden.
--
CREATE VIEW Fachbereich_bietet_L
AS SELECT fb_name, lv_name 
FROM dbs_tab_fachbereich, dbs_tab_lehrveranstaltung
ORDER BY fb_name, lv_name ;

SELECT * FROM Fachbereich_bietet_L;

--
--      Virtuelle Tabelle „Lehrveranstaltungen des Fachbereichs
--      Informatik“. Nutzen Sie zur Erstellung dieser View die zuvor
--      erstellte View „Fachbereich bietet Lehrveranstaltung“.
--


CREATE VIEW Lehrveranstaltungen_F_inf
AS SELECT fb_name , lv_name 
FROM Fachbereich_bietet_L
WHERE fb_name='Informatik';

SELECT * FROM Lehrveranstaltungen_F_inf;
--
--      Virtuelle Tabelle „Hochschulangehoeriger“. Die View soll
--      lediglich die relevanten und objektidentifizierenden Spalten
--      des semantisch ausdrucksstarken Objekts „Hochschulangehoeriger“
--      enthalten (also nicht die Spalten an_nr und vo_nr). Die View
--      soll standardmäßig nach dem Namen des Hochschulangehörigen
--      sortiert werden.
--
--      Frage: Warum ist dieses Sortierkriterium nicht immer
--      hilfreich?
--      Frage: Warum tauchen einige der Hochschulangehörigen
--      offenbar mehrfach auf?
--
CREATE OR
REPLACE VIEW  dbs_view_hochschulangehoeriger
AS SELECT     h.ho_nr, vorname, ho_name,
			  plz, ort, strasse, haus_nr
FROM          dbs_tab_hochschulangehoeriger h,
              dbs_tab_vorname v,
              dbs_tab_anschrift a
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
ORDER BY      ho_name
;


SELECT * FROM dbs_view_hochschulangehoeriger;
--
--      Virtuelle Tabelle „Mitarbeiter“. Die View soll lediglich
--      die relevanten und objektidentifizierenden Spalten des
--      semantisch ausdrucksstarken Objekts „Mitarbeiter“, sowie
--      den Namen des Fachbereichs wo dieser angestellt ist enthalten.
--      Bitte lassen Sie die Spalte Gehalt weg. Die View soll standardmäßig
--      nach dem Namen des Fachbereichs und bei Gleichheit nach dem
--      Namen des Mitarbeiters sortiert werden.
--
--      Frage: Warum wäre ein zweites Sortierkriterium nach der
--      Personalnummer hilfreicher?
--

CREATE OR
REPLACE VIEW  dbs_view_mitarbeiter
AS SELECT     pers_nr, vorname, ho_name, ort,
			  strasse, haus_nr, fb_name,
			  beruf, institution
FROM          dbs_tab_mitarbeiter m,
              dbs_tab_hochschulangehoeriger h,
              dbs_tab_vorname v,
              dbs_tab_anschrift a,
              dbs_tab_fachbereich f
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = m.ho_nr
AND           m.fb_nr = f.fb_nr
ORDER BY      fb_name ASC, h.ho_name ASC;

SELECT * FROM dbs_view_mitarbeiter;
--
--      Virtuelle Tabelle „Professor“. Die View soll lediglich
--      die relevanten und objektidentifizierenden Spalten des
--      semantisch ausdrucksstarken Objekts „Professor“, sowie
--      den Namen des Fachbereichs wo dieser angestellt ist enthalten.
--      Bitte lassen Sie die Spalte Gehalt weg. Die View soll standardmäßig
--      nach dem Namen des Fachbereichs und bei Gleichheit nach der
--      Personalnummer des Professors sortiert werden.
--
--      Frage: Kann man zur Erstellung dieser View auf die zuvor
--      erstellte View „Mitarbeiter“ zurückgreifen?
--
CREATE OR
REPLACE VIEW  dbs_view_professor
AS SELECT     p.pers_nr, titel, vorname,
			  ho_name, ort, strasse, haus_nr,
			  fb_name, fachgebiet, beruf, institution
FROM          dbs_tab_mitarbeiter m,
              dbs_tab_hochschulangehoeriger h,
              dbs_tab_vorname v,
              dbs_tab_anschrift a,
              dbs_tab_fachbereich f,
              dbs_tab_professor p
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = m.ho_nr
AND           m.fb_nr = f.fb_nr
AND           p.pers_nr = m.pers_nr
ORDER BY      fb_name ASC, p.pers_nr ASC
;

SELECT * FROM dbs_view_professor;

--
--      Virtuelle Tabelle „Student“. Die View soll lediglich die relevanten
--      und objektidentifizierenden Spalten des semantisch ausdrucksstarken
--      Objekts „Student“, sowie den Namen des Fachbereichs wo dieser
--      immatrikuliert ist enthalten. Bitte lassen Sie die Spalte Personalnummer
--      weg. Die View soll standardmäßig nach dem Namen des Fachbereichs und
--      bei Gleichheit nach der Matrikelnummer des Studenten sortiert werden.
CREATE OR
REPLACE VIEW  dbs_view_student
AS SELECT     matr_nr, vorname, ho_name,
			  ort, strasse, haus_nr, fb_name
FROM          dbs_tab_hochschulangehoeriger h,
              dbs_tab_vorname v,
              dbs_tab_anschrift a,
              dbs_tab_fachbereich f,
              dbs_tab_student s
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = s.ho_nr
AND           s.fb_nr = f.fb_nr
ORDER BY      fb_name ASC, s.matr_nr ASC
;

SELECT * FROM dbs_view_student;

--
--      Virtuelle Tabelle „Studentischer Mitarbeiter“. Die View soll lediglich
--      die relevanten und objektidentifizierenden Spalten des semantisch
--      ausdrucksstarken Objekts „Student“, sowie den Namen des Fachbereichs
--      wo dieser angestellt ist und den Namen des Fachbereichs wo dieser
--      immatrikuliert ist enthalten. Bitte lassen Sie die Spalten Matrikelnummer
--      und Gehalt weg. Die View soll standardmäßig nach dem Namen des
--      Fachbereichs der Mitarbeiter und bei Gleichheit nach der Personalnummer
--      des Studenten sortiert werden.

--      Frage: Kann man zur Erstellung dieser View auf die zuvor erstellte
--      View „Mitarbeiter“ und / oder „Student“ zurückgreifen?
--
CREATE OR
REPLACE VIEW  dbs_view_stud_mitarbeiter
AS SELECT     s.pers_nr, vorname, ho_name,
			  ort, strasse, haus_nr,
			  mitarb.fb_name AS arbeitet,
			  beruf, institution,
			  stud.fb_name AS studiert
FROM          dbs_tab_mitarbeiter m,
              dbs_tab_hochschulangehoeriger h,
              dbs_tab_vorname v,
              dbs_tab_anschrift a,
              dbs_tab_fachbereich stud,
              dbs_tab_fachbereich mitarb,
              dbs_tab_student s
WHERE         h.ho_nr = v.ho_nr
AND           h.ho_nr = a.ho_nr
AND           h.ho_nr = m.ho_nr
AND           m.fb_nr = mitarb.fb_nr
AND           s.fb_nr = stud.fb_nr
AND           s.pers_nr = m.pers_nr
ORDER BY      mitarb.fb_name ASC, s.matr_nr ASC
;
SELECT * FROM dbs_view_stud_mitarbeiter;
--
--      Virtuelle Tabelle „Professor haelt Lehrveranstaltung“. Die View
--      soll Titel, Namen und Fachgebiet des Professors und den Namen der
--      Lehrveranstaltung enthalten. Die View soll nach der Nummer des
--      Hochschulangehörigen sortiert werden (auch wenn diese nicht
--      Bestandteil der View ist).
--
--      Frage: Warum ist an dieser Stelle ein „distinct“ hilfreich?
--
CREATE OR
REPLACE VIEW  dbs_view_prof_haelt_lv
AS SELECT     distinct titel, ho_name, lv_name
FROM          dbs_tab_hochschulangehoeriger h,
              dbs_tab_mitarbeiter m,
              dbs_tab_professor p,
              dbs_tab_prof_haelt_lv plv,
              dbs_tab_lv_ort lvo,
              dbs_tab_lehrveranstaltung l
WHERE         h.ho_nr = m.ho_nr
AND           m.pers_nr = p.pers_nr
AND           p.pers_nr = plv.pers_nr
AND           plv.lv_nr = lvo.lv_nr
AND           plv.zeit = lvo.zeit
AND           plv.tag = lvo.tag
AND           lvo.lv_nr = l.lv_nr
ORDER BY      h.ho_name
;

SELECT * FROM dbs_view_prof_haelt_lv;
--
--      Virtuelle Tabelle „Pruefungen“. Die View soll lediglich
--	    die relevanten und objektidentifizierenden Spalten des
--	    semantisch ausdrucksstarken Objekts „Pruefungen“ enthalten.
--	    Die View soll namentlich: Lehrveranstaltung, Professor und
--	    Student mit Name und erstem Vornamen in einer Spalte,
--	    in der Form: "Name, ersterVorname"
--	    (Bsp. Konkatenation: „Name || ´,´ || Vorname“), sowie die
--	    Note enthalten. Standardmäßig aufsteigend sortiert nach
--	    Lehrveranstaltung und Professor, absteigend nach Student
--	    und aufsteigend nach Note.
--
--      Frage: Wie lösen Sie das Problem, dass der ho_name sowohl für
--      Professoren als auch für Studenten benötigt wird? In wiefern
--      ist hierbei distinct zu verwenden bzw. welche Gefahr besteht durch
--      die Verwendung?
CREATE OR REPLCE dbs_viewpruefung
AS SELECT l.lv_name, h.ho_name as professor, hs.ho_name ||',' || v.vorname as student , note 
FROM dbs_tab_pruefung,  dbs_tab_hochschulangehoeriger h, dbs_tab_hochschulangehoeriger hs, 
     dbs_tab_vorname v, dbs_tab_lehrveranstaltung v, dbs_tab_student s, dbs_tab_professor, dbs_tab_mitarbeiter m
WHERE h.ho_nr=m.ho_nr
AND m.pers_nr=p.pers_nr
and h.ho_nr=s.ho_nr 
AND v.ho_nr=h.ho_nr
ORDER BY LV_NAME, note desc; 

--      Einfügen in Views
--
--      Testen Sie den Einfügevorgang in der zuvor erstellten View "Fachbereich".
--
--      Frage: Warum ist ein Einfügen möglich?
--

    SELECT * FROM dbs_view_fachbereich;
    
    INSERT INTO dbs_view_fachbereich VALUES ((SELECT MAX(fb_nr)+1 FROM dbs_view_fachbereich ),'Machinenbau', 'Bruehl');
--
--      Testen Sie den Einfügevorgang in die zuvor erstellte View
--      „Hochschulangehoeriger“.
--
--      Frage: Warum ist ein Einfügen hier grundsätzlich nicht möglich?
--

DESCRIBE dbs_view_hochschulangehoeriger;
SELECT * FROM dbs_view_hochschulangehoeriger;
INSERT INTO dbs_view_hochschulangehoeriger VALUES (8888, 'Michele', 'NJEUS',53115,'bonn', 'Endenicher allee', 17);
--
--      Änderung von Datensätzen in Views
--
--      Ändern Sie den Namen eines Fachbereichs in der zuvor erstellten
--      View „Fachbereich“.
--
--      Frage: Warum ist die Änderung möglich?
--
UPDATE dbs_view_fachbereich
SET fb_name='Mechatronik'
where ho_nr=3;

--
--     Ändern Sie den Namen eines Hochschulangehörigen in der zuvor
--     erstellten View "Hochschulangehoeriger".
--
--     Frage: Warum sollte diese Änderung grundsätzlich möglich sein?
--     Welcher Grund wird dennoch für die Ablehnung angegeben?
--

UPDATE dbs_view_hochschulangehoeriger
SET ho_name='Michou'
where ho_nr=1022;
--
--     Löschen von Datensätzen in Views
--
--     Löschen Sie den zuvor erstellten neuen Fachbereich in der View
--     "Fachbereich".
--
--     Frage: Warum ist die Löschung möglich?
--
DELETE FROM dbs_view_fachbereich
WHERE fb_name='Mechatronik';

--
--     Löschen Sie den Hochschulangehörigen mit der Nr. 1020 in der zuvor
--     erstellten View "Hochschulangehoeriger".
--

DELETE FROM dbs_view_hochschulangehoeriger 
WHERE ho_nr=1020;
--     Frage: Warum sollte diese Löschung grundsätzlich möglich sein?
--     Welcher Grund wird dennoch für die Ablehnung angegeben?
--
commit;

--
-- Systemdatum
--
  SELECT user,
         TO_CHAR(SYSDATE, 'dd-mm-yy hh24:mi:ss')
  FROM   dual
  ;
--
spool off