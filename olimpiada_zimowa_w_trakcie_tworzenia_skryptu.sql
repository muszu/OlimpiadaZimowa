DO $$DECLARE r record;
    BEGIN
        FOR r IN SELECT table_name,constraint_name
                 FROM information_schema.constraint_table_usage
                 WHERE table_name IN ('fazy', 'kategorie', 'obiekty', 'panstwa', 'sedziowie', 'dyscypliny', 'rozgrywki', 'sedziowie_dyscypliny',
				 'sedziowie_rozgrywki', 'druzyny', 'dyscypliny_medale_zes', 'dyscypliny_medalisci_ind', 'hokej', 'zawodnicy', 'zawodnicy_druzyny', 
				 'zawodnicy_dyscypliny', 'biegi_narciarskie', 'skoki_narciarskie', 'lyzwiarstwo_szybkie', 'doping')
        LOOP
			EXECUTE 'ALTER TABLE IF EXISTS ' || quote_ident(r.table_name)|| ' DROP CONSTRAINT '|| quote_ident(r.constraint_name) || ';';
        END LOOP;
    END$$;
	
DO $$DECLARE r record;
    BEGIN
        FOR r IN SELECT table_name
                 FROM information_schema.tables
                 WHERE table_name IN ('fazy', 'kategorie', 'obiekty', 'panstwa', 'sedziowie', 'dyscypliny', 'rozgrywki', 'sedziowie_dyscypliny',
				 'sedziowie_rozgrywki', 'druzyny', 'dyscypliny_medale_zes', 'dyscypliny_medalisci_ind', 'hokej', 'zawodnicy', 'zawodnicy_druzyny', 
				 'zawodnicy_dyscypliny', 'biegi_narciarskie', 'skoki_narciarskie', 'lyzwiarstwo_szybkie', 'doping')
        LOOP
			EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.table_name)|| ' CASCADE;';
        END LOOP;
    END$$;
	
SELECT table_name
  FROM information_schema.tables
 WHERE table_schema='public';
	
DROP TABLE IF EXISTS fazy  CASCADE;
DROP TABLE IF EXISTS kategorie  CASCADE;
DROP TABLE IF EXISTS obiekty  CASCADE;
DROP TABLE IF EXISTS panstwa  CASCADE;
DROP TABLE IF EXISTS sedziowie  CASCADE;
DROP TABLE IF EXISTS dyscypliny  CASCADE;
DROP TABLE IF EXISTS rozgrywki  CASCADE;
DROP TABLE IF EXISTS sedziowie_dyscypliny  CASCADE;
DROP TABLE IF EXISTS sedziowie_rozgrywki  CASCADE;
DROP TABLE IF EXISTS druzyny  CASCADE;
DROP TABLE IF EXISTS dyscypliny_medale_zes  CASCADE;
DROP TABLE IF EXISTS dyscypliny_medalisci_ind  CASCADE;
DROP TABLE IF EXISTS hokej  CASCADE;
DROP TABLE IF EXISTS zawodnicy  CASCADE;
DROP TABLE IF EXISTS zawodnicy_druzyny  CASCADE;
DROP TABLE IF EXISTS zawodnicy_dyscypliny  CASCADE;
DROP TABLE IF EXISTS biegi_narciarskie  CASCADE;
DROP TABLE IF EXISTS skoki_narciarskie  CASCADE;
DROP TABLE IF EXISTS lyzwiarstwo_szybkie  CASCADE;
DROP TABLE IF EXISTS doping  CASCADE;


CREATE TABLE fazy ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	CONSTRAINT pk_fazy PRIMARY KEY ( id )
 );

CREATE TABLE kategorie ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	nadkategoria         integer  ,
	CONSTRAINT pk_kategorie PRIMARY KEY ( id )
 );

CREATE TABLE obiekty ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	typ                  varchar(30)  ,
	adres                varchar(50)  ,
	CONSTRAINT pk_obiekty PRIMARY KEY ( id )
 );

CREATE TABLE panstwa ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	CONSTRAINT pk_panstwa PRIMARY KEY ( id )
 );

CREATE TABLE sedziowie ( 
	id                   integer  NOT NULL,
	imie                 varchar(30)  ,
	nazwisko             varchar(30)  ,
	CONSTRAINT pk_sedziowie PRIMARY KEY ( id )
 );

CREATE TABLE dyscypliny ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	id_kategorii         integer  ,
	CONSTRAINT pk_dyscypliny PRIMARY KEY ( id )
 );

CREATE TABLE rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_dyscypliny        integer  ,
	data_rozgrywki       date  ,
	id_obiektu           integer  ,
	id_fazy              integer  NOT NULL,
	CONSTRAINT pk_rozgrywki PRIMARY KEY ( id_rozgrywki )
 );

CREATE TABLE sedziowie_dyscypliny ( 
	id_sedziego          integer  ,
	id_dyscypliny        integer  
 );

CREATE TABLE sedziowie_rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_sedziego          integer  NOT NULL
 );

CREATE TABLE druzyny ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  NOT NULL,
	id_dyscypliny        integer  NOT NULL,
	id_kraju             integer  NOT NULL,
	CONSTRAINT pk_druzyny PRIMARY KEY ( id )
 );

CREATE TABLE dyscypliny_medale_zes ( 
	id_dyscypliny        integer  NOT NULL,
	id_druzyny           integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medale_zes PRIMARY KEY ( id_dyscypliny, id_druzyny )
 );

CREATE TABLE hokej ( 
	id_panstwa           integer  ,
	id_rozgrywki         integer  ,
	punkty               integer  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

CREATE TABLE zawodnicy_druzyny ( 
	id_druzyny           integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	CONSTRAINT pk_zawodnicy_druzyny UNIQUE ( id_zawodnika ) 
 );


CREATE TABLE zawodnicy ( 
	id                   integer  NOT NULL,
	imie                 varchar(30)  ,
	nazwisko             varchar(30)  ,
	id_panstwa           integer  ,
	plec                 char(1)  NOT NULL,
	data_urodzenia       date  NOT NULL,
	CONSTRAINT pk_table_0 PRIMARY KEY ( id )
 );

ALTER TABLE zawodnicy ADD CONSTRAINT ck_plec CHECK ( plec IN ('M','F') );

CREATE TABLE zawodnicy_dyscypliny ( 
	id_zawodnika         integer  ,
	id_dyscypliny        integer  NOT NULL
 );

CREATE TABLE biegi_narciarskie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	czas                 numeric  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );
 
 ALTER TABLE biegi_narciarskie ADD CONSTRAINT ck_0 CHECK ( status IN ('OK','DNS','DNF','DSQ') );

CREATE TABLE doping ( 
	id_zawodnika         integer  ,
	data_pobrania        date  ,
	wynik                bool  
 );

CREATE TABLE dyscypliny_medalisci_ind ( 
	id_dyscypliny        integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medalisci_ind PRIMARY KEY ( id_dyscypliny, id_zawodnika )
 );

CREATE TABLE lyzwiarstwo_szybkie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	czas                 numeric  ,
	status               char(1) DEFAULT 'OK' NOT NULL
 );

CREATE TABLE skoki_narciarskie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	seria1               numeric(3,2)  ,
	seria2               numeric(3,2)  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );
 
CREATE INDEX idx_dyscypliny ON dyscypliny ( id_kategorii );

CREATE INDEX idx_rozgrywki_0 ON rozgrywki ( id_obiektu );

CREATE INDEX idx_rozgrywki_1 ON rozgrywki ( id_dyscypliny );

CREATE INDEX idx_rozgrywki ON rozgrywki ( id_fazy );

CREATE INDEX idx_sedziowie_dyscypliny ON sedziowie_dyscypliny ( id_sedziego );

CREATE INDEX idx_sedziowie_dyscypliny_0 ON sedziowie_dyscypliny ( id_dyscypliny );

CREATE INDEX idx_sedziowie_rozgrywki ON sedziowie_rozgrywki ( id_rozgrywki );

CREATE INDEX idx_sedziowie_rozgrywki_0 ON sedziowie_rozgrywki ( id_sedziego );

CREATE INDEX idx_druzyny ON druzyny ( id_dyscypliny );

CREATE INDEX idx_druzyny_0 ON druzyny ( id_kraju );

CREATE INDEX idx_hokej ON hokej ( id_panstwa );

CREATE INDEX idx_hokej_0 ON hokej ( id_rozgrywki );

CREATE INDEX idx_dyscypliny_medale_zes_0 ON dyscypliny_medale_zes ( id_dyscypliny );

CREATE INDEX idx_dyscypliny_medale_zes_1 ON dyscypliny_medale_zes ( id_druzyny );

CREATE INDEX idx_zawodnicy_druzyny ON zawodnicy_druzyny ( id_druzyny ); 

CREATE INDEX idx_zawodnicy ON zawodnicy ( id_panstwa );

CREATE INDEX idx_zawodnicy_dyscypliny ON zawodnicy_dyscypliny ( id_zawodnika );

CREATE INDEX idx_zawodnicy_dyscypliny_0 ON zawodnicy_dyscypliny ( id_dyscypliny );
 
CREATE INDEX idx_biegi_narciarskie ON biegi_narciarskie ( id_zawodnika );

CREATE INDEX idx_biegi_narciarskie_0 ON biegi_narciarskie ( id_rozgrywki );

CREATE INDEX idx_doping ON doping ( id_zawodnika );

CREATE INDEX idx_dyscypliny_medalisci_ind_0 ON dyscypliny_medalisci_ind ( id_dyscypliny );

CREATE INDEX idx_dyscypliny_medalisci_ind_1 ON dyscypliny_medalisci_ind ( id_zawodnika );

CREATE INDEX idx_lyzwiarstwo_szybkie ON lyzwiarstwo_szybkie ( id_zawodnika );

CREATE INDEX idx_lyzwiarstwo_szybkie_0 ON lyzwiarstwo_szybkie ( id_rozgrywki );

CREATE INDEX idx_skoki_narciarskie ON skoki_narciarskie ( id_zawodnika );

CREATE INDEX idx_skoki_narciarskie_0 ON skoki_narciarskie ( id_rozgrywki );

ALTER TABLE biegi_narciarskie ADD CONSTRAINT fk_biegi_narciarskie FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE biegi_narciarskie ADD CONSTRAINT fk_biegi_narciarskie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE doping ADD CONSTRAINT fk_doping FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE druzyny ADD CONSTRAINT fk_druzyny FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE druzyny ADD CONSTRAINT fk_druzyny_0 FOREIGN KEY ( id_kraju ) REFERENCES panstwa( id );

ALTER TABLE dyscypliny ADD CONSTRAINT fk_dyscypliny FOREIGN KEY ( id_kategorii ) REFERENCES kategorie( id );

ALTER TABLE dyscypliny_medale_zes ADD CONSTRAINT fk_dyscypliny_medale_zes_0 FOREIGN KEY ( id_druzyny ) REFERENCES druzyny( id );

ALTER TABLE dyscypliny_medale_zes ADD CONSTRAINT fk_dyscypliny_medale_zes_1 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE dyscypliny_medalisci_ind ADD CONSTRAINT fk_dyscypliny_medalisci_ind FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE dyscypliny_medalisci_ind ADD CONSTRAINT fk_dyscypliny_medalisci_ind_0 FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE hokej ADD CONSTRAINT fk_hokej FOREIGN KEY ( id_panstwa ) REFERENCES panstwa( id );

ALTER TABLE hokej ADD CONSTRAINT fk_hokej_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE lyzwiarstwo_szybkie ADD CONSTRAINT fk_lyzwiarstwo_szybkie FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE lyzwiarstwo_szybkie ADD CONSTRAINT fk_lyzwiarstwo_szybkie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE rozgrywki ADD CONSTRAINT fk_rozgrywki_0 FOREIGN KEY ( id_obiektu ) REFERENCES obiekty( id );

ALTER TABLE rozgrywki ADD CONSTRAINT fk_rozgrywki_1 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE rozgrywki ADD CONSTRAINT fk_rozgrywki FOREIGN KEY ( id_fazy ) REFERENCES fazy( id );

ALTER TABLE sedziowie_dyscypliny ADD CONSTRAINT fk_sedziowie_dyscypliny FOREIGN KEY ( id_sedziego ) REFERENCES sedziowie( id );

ALTER TABLE sedziowie_dyscypliny ADD CONSTRAINT fk_sedziowie_dyscypliny_0 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE sedziowie_rozgrywki ADD CONSTRAINT fk_sedziowie_rozgrywki FOREIGN KEY ( id_sedziego ) REFERENCES sedziowie( id );

ALTER TABLE sedziowie_rozgrywki ADD CONSTRAINT fk_sedziowie_rozgrywki_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE skoki_narciarskie ADD CONSTRAINT fk_skoki_narciarskie FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE skoki_narciarskie ADD CONSTRAINT fk_skoki_narciarskie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE zawodnicy ADD CONSTRAINT fk_zawodnicy FOREIGN KEY ( id_panstwa ) REFERENCES panstwa( id );

ALTER TABLE zawodnicy ADD CONSTRAINT fk_zawodnicy_0 FOREIGN KEY ( id ) REFERENCES zawodnicy_druzyny( id_zawodnika );

ALTER TABLE zawodnicy_druzyny ADD CONSTRAINT fk_zawodnicy_druzyny FOREIGN KEY ( id_druzyny ) REFERENCES druzyny( id );

ALTER TABLE zawodnicy_dyscypliny ADD CONSTRAINT fk_zawodnicy_dyscypliny FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE zawodnicy_dyscypliny ADD CONSTRAINT fk_zawodnicy_dyscypliny_0 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

