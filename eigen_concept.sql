-- ***************************************************************
-- * File Name:                  eigen_concept.sql               *
-- * File Creator:               <MICHELE NJENKAM>                      *
-- * CreationDate:               <12.12.2023>                         *
-- ***************************************************************
--
-- *** Bitte verwenden Sie als Zeichenkodierung immer UTF-8    ***
--
-- ***************************************************************
-- * Datenbanksysteme WS 2023
-- * Ãœbung 5
--
-- ***************************************************************
-- * SQL*plus Job Control Section
--
-- <sqlplus>

set echo on
set linesize 80
set pagesize 50
spool ./eigen_concept.log

-- Kommentieren Sie die folgende Zeile ein, falls Sie mÃ¶chten, dass der SQL-Developer beim ersten Fehler abbricht:
-- whenever sqlerror exit sql.sqlcodeF

-- </sqlplus>

-- ***************************************************************
-- * Clear Database Section
--
-- <clear>

DROP TABLE hrs_tab_person CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_veranstaltung CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_gebaeude CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_zimmer CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_Rezeptionist CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_einplanen CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_reservierung CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_modifizieren CASCADE CONSTRAINTS;
DROP TABLE hrs_tab_gast CASCADE CONSTRAINTS;


-- </clear>
-- </clear>

-- ***************************************************************
-- * Table Section
--
-- <table>



CREATE TABLE hrs_tab_veranstaltung
( V_nr NUMERIC(10)
,name VARCHAR (10)
,Gastanzahl NUMERIC(10)
,Datum DATE
,gebaeude_nr NUMERIC(2)
);

CREATE TABLE hrs_tab_gebaeude
(   gebaeude_nr NUMERIC(2)
    ,zimmeranzahl NUMERIC(10)
    ,Ort VARCHAR (10)
    ,PLZ VARCHAR(5)
    ,Hausnummer NUMERIC(2)
    ,strasse VARCHAR (10)
);
CREATE TABLE hrs_tab_zimmer
(   zimmer_nr  NUMERIC(2)
    ,Preis NUMERIC(10)
    ,Standing VARCHAR (10)
    ,bettanzahl NUMERIC(2)
    ,Gast_nr NUMERIC(5)
    ,gebaeude_nr NUMERIC (2)
);

CREATE TABLE hrs_tab_Rezeptionist
(   Stelle_id NUMERIC(2)
    ,Arbeitstage VARCHAR (10)
    ,Bekleidung VARCHAR(20)
    ,pers_id NUMERIC(10)
);

CREATE TABLE hrs_tab_einplanen
(   Stelle_id NUMERIC(10)
    ,V_nr NUMERIC(10)
    ,datum DATE
); 

CREATE TABLE hrs_tab_reservierung
(   Reservierung_nr NUMERIC(5)
    ,zimmer_nr NUMERIC(2)
    ,Zeitraum VARCHAR(10)
    ,Grund VARCHAR(32)
);

CREATE TABLE hrs_tab_modifizieren
(   Gast_nr NUMERIC(10)
   ,Stelle_id NUMERIC(10)
   ,Reservierung_nr NUMERIC(10)
);

CREATE TABLE hrs_tab_gast
(   Gast_nr NUMERIC(10)
   ,Stelle_id NUMERIC(10)
   ,Gast_standing VARCHAR(10)
   ,pers_id NUMERIC(10)
);




-- </table>

-- ***************************************************************
-- * NOT NULL Constraint Section
--
-- <notnull>



--hrs_tab_veranstaltung
ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT nn_veranstaltung_V_nr
CHECK ( V_nr IS NOT NULL );

ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT nn_veranstaltung_name
CHECK ( name IS NOT NULL );

ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT nn_veranstaltung_Gastanzahl
CHECK ( Gastanzahl IS NOT NULL );

ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT nn_veranstaltung_Datum
CHECK ( Datum IS NOT NULL );

ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT nn_veranstaltung_gebaeude_nr
CHECK ( gebaeude_nr IS NOT NULL );

--hrs_tab_gebaeude
ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT nn_gebaeude_gebaeude_nr
CHECK ( gebaeude_nr IS NOT NULL );

ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT nn_gebaeude_zimmeranzahl
CHECK ( zimmeranzahl IS NOT NULL );

ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT nn_gebaeude_Ort
CHECK ( Ort IS NOT NULL );

ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT nn_gebaeude_PLZ
CHECK ( PLZ IS NOT NULL );

ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT nn_gebaeude_Hausnummer
CHECK ( Hausnummer IS NOT NULL );

ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT nn_gebaeude_strasse
CHECK ( strasse IS NOT NULL );


-- hrs_tab_zimmer  
ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT nn_zimmer_Preis
CHECK ( Preis IS NOT NULL );

ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT nn_zimmer_Standing
CHECK ( Standing IS NOT NULL );

ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT nn_zimmer_zimmer_nr
CHECK ( zimmer_nr IS NOT NULL );

ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT nn_zimmer_Gast_nr
CHECK ( Gast_nr IS NOT NULL );



ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT nn_zimmer_gebaeude_nr
CHECK ( gebaeude_nr IS NOT NULL );

ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT nn_zimmer_bettanzahl
CHECK ( bettanzahl IS NOT NULL );

--hrs_tab_Rezeptionist 
ALTER TABLE hrs_tab_Rezeptionist
ADD CONSTRAINT nn_Rezeptionist_Stelle_id
CHECK ( Stelle_id IS NOT NULL );

ALTER TABLE hrs_tab_Rezeptionist
ADD CONSTRAINT nn_Rezeptionist_Arbeitstage
CHECK ( Arbeitstage IS NOT NULL );

ALTER TABLE hrs_tab_Rezeptionist
ADD CONSTRAINT nn_Rezeptionist_Bekleidung
CHECK ( Bekleidung IS NOT NULL );

ALTER TABLE hrs_tab_Rezeptionist
ADD CONSTRAINT nn_Rezeptionist_pers_id
CHECK ( pers_id IS NOT NULL );

--hrs_tab_einplanen 
ALTER TABLE hrs_tab_einplanen
ADD CONSTRAINT nn_einplanen_Stelle_id
CHECK ( Stelle_id IS NOT NULL );

ALTER TABLE hrs_tab_einplanen
ADD CONSTRAINT nn_einplanen_V_nr
CHECK ( V_nr IS NOT NULL );

ALTER TABLE hrs_tab_einplanen
ADD CONSTRAINT nn_einplanen_datum
CHECK ( datum IS NOT NULL );

--hrs_tab_reservierung   
ALTER TABLE hrs_tab_reservierung
ADD CONSTRAINT nn_res_Reservierung_nr
CHECK ( Reservierung_nr IS NOT NULL );

ALTER TABLE hrs_tab_reservierung
ADD CONSTRAINT nn_reservierung_Zeitraum
CHECK ( Zeitraum IS NOT NULL );

ALTER TABLE hrs_tab_reservierung
ADD CONSTRAINT nn_reservierung_Grund
CHECK ( Grund IS NOT NULL );

ALTER TABLE hrs_tab_reservierung
ADD CONSTRAINT nn_reser_zimmer_nr
CHECK ( zimmer_nr IS NOT NULL );


--hrs_tab_modifizieren 
ALTER TABLE hrs_tab_modifizieren
ADD CONSTRAINT nn_modifizieren_Gast_nr
CHECK ( Gast_nr IS NOT NULL );

ALTER TABLE hrs_tab_modifizieren
ADD CONSTRAINT nn_modifizieren_Stelle_id
CHECK ( Stelle_id IS NOT NULL );

ALTER TABLE hrs_tab_modifizieren
ADD CONSTRAINT nn_mod_Reservierung_nr
CHECK ( Reservierung_nr IS NOT NULL );

--hrs_tab_gast    
ALTER TABLE hrs_tab_gast
ADD CONSTRAINT nn_gast_Gast_nr
CHECK ( Gast_nr IS NOT NULL );

ALTER TABLE hrs_tab_gast
ADD CONSTRAINT nn_gast_Stelle_id
CHECK ( Stelle_id IS NOT NULL );

ALTER TABLE hrs_tab_gast
ADD CONSTRAINT nn_gast_Gast_standing
CHECK ( Gast_standing IS NOT NULL );

ALTER TABLE hrs_tab_gast
ADD CONSTRAINT nn_gast_pers_id
CHECK ( pers_id IS NOT NULL );

--hrs_tab_rechnung      

-- </notnull>

-- ***************************************************************
-- * Primary Key Constraint Section
--
-- <pk>

ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT pk_veranstaltung
PRIMARY KEY (V_nr);

ALTER TABLE  hrs_tab_gebaeude
ADD CONSTRAINT pk_gebaeude
PRIMARY KEY (gebaeude_nr);

ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT pk_zimmer
PRIMARY KEY (zimmer_nr);

ALTER TABLE hrs_tab_Rezeptionist
ADD CONSTRAINT pk_Rezeptionist
PRIMARY KEY (Stelle_id);

ALTER TABLE hrs_tab_einplanen
ADD CONSTRAINT pk_einplanen
PRIMARY KEY (Stelle_id,V_nr);

ALTER TABLE hrs_tab_reservierung
ADD CONSTRAINT pk_personreservierung
PRIMARY KEY (Reservierung_nr);

ALTER TABLE hrs_tab_modifizieren
ADD CONSTRAINT pk_modifizieren
PRIMARY KEY (Gast_nr,Stelle_id,Reservierung_nr); 

ALTER TABLE hrs_tab_gast
ADD CONSTRAINT pk_gast
PRIMARY KEY (Gast_nr);



-- </pk>

-- ***************************************************************
-- * Unique Key Constraint Section
--
-- <unique>



ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT uk_veranstaltung
UNIQUE (Name);

ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT uk_gebaeude
UNIQUE (Hausnummer);

ALTER TABLE hrs_tab_rezeptionist
ADD CONSTRAINT uk_rezepzionist
UNIQUE (Arbeitstage);

ALTER TABLE hrs_tab_reservierung
ADD CONSTRAINT uk_reservierung
UNIQUE (zeitraum);


-- </unique>

-- ***************************************************************
-- * Foreign Key Constraint Section
--
-- <fk>


--neu


ALTER TABLE hrs_tab_gebaeude
ADD CONSTRAINT fk_gebaeude_gebaeude
FOREIGN KEY (Hausnummer)
REFERENCES hrs_tab_gebaeude(Hausnummer);
--end neu
ALTER TABLE hrs_tab_veranstaltung
ADD CONSTRAINT fk_veranstaltung_gebaeude
FOREIGN KEY (gebaeude_nr)
REFERENCES hrs_tab_gebaeude(gebaeude_nr);

ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT fk_zimmer_gast
FOREIGN KEY (Gast_nr)
REFERENCES hrs_tab_gast(Gast_nr);

ALTER TABLE hrs_tab_zimmer
ADD CONSTRAINT fk_zimmer_gebaeude
FOREIGN KEY (gebaeude_nr)
REFERENCES hrs_tab_gebaeude(gebaeude_nr);

ALTER TABLE hrs_tab_reservierung
ADD CONSTRAINT fk_Reservierung_zimmer
FOREIGN KEY (zimmer_nr)
REFERENCES hrs_tab_zimmer(zimmer_nr);


ALTER TABLE hrs_tab_Rezeptionist
ADD CONSTRAINT fk_Rezeptionist_Rezeptionist
FOREIGN KEY (Stelle_id)
REFERENCES hrs_tab_Rezeptionist(Stelle_id);

ALTER TABLE hrs_tab_einplanen
ADD CONSTRAINT fk_einplanen_veranstalltung
FOREIGN KEY (V_nr)
REFERENCES hrs_tab_veranstaltung(V_nr);

ALTER TABLE hrs_tab_einplanen
ADD CONSTRAINT fk_einplanen_Rezeptionist
FOREIGN KEY (Stelle_id)
REFERENCES hrs_tab_Rezeptionist(Stelle_id);

ALTER TABLE hrs_tab_modifizieren
ADD CONSTRAINT fk_modifizieren_gast
FOREIGN KEY (Gast_nr)
REFERENCES hrs_tab_Gast(Gast_nr);

ALTER TABLE hrs_tab_modifizieren
ADD CONSTRAINT fk_modifizieren_rezeptionist
FOREIGN KEY (Stelle_id)
REFERENCES hrs_tab_rezeptionist(Stelle_id);

ALTER TABLE hrs_tab_modifizieren
ADD CONSTRAINT fk_modifizieren_reservierung
FOREIGN KEY (reservierung_nr)
REFERENCES hrs_tab_reservierung(reservierung_nr);


ALTER TABLE hrs_tab_gast
ADD CONSTRAINT fk_gast_Rezeptionist
FOREIGN KEY (Stelle_id)
REFERENCES hrs_tab_rezeptionist(Stelle_id);




-- </fk>

-- ***************************************************************
-- * SQL*plus Job Control Section
--
-- <sqlplus>

spool off

-- </sqlplus>