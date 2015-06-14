
CREATE TABLE fazy ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	CONSTRAINT pk_fazy PRIMARY KEY ( id )
 );

CREATE TABLE kategorie ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	nadkategoria         varchar(30)  ,
	CONSTRAINT pk_kategorie PRIMARY KEY ( id )
 );

CREATE TABLE obiekty ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	typ                  varchar(30)  ,
	adres                varchar(50)  ,
	miasto               varchar(30)  NOT NULL,
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

CREATE INDEX idx_zawodnicy ON zawodnicy ( id_panstwa );

CREATE TABLE doping ( 
	id_zawodnika         integer  ,
	data_pobrania        date  ,
	wynik                bool  ,
	CONSTRAINT pk_doping PRIMARY KEY (id_zawodnika, data_pobrania)
 );

CREATE INDEX idx_doping ON doping ( id_zawodnika );

CREATE TABLE dyscypliny (
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	id_kategorii         integer  ,
	zakonczona           bool DEFAULT false ,
	CONSTRAINT pk_dyscypliny PRIMARY KEY ( id )
 );

CREATE INDEX idx_dyscypliny ON dyscypliny ( id_kategorii );

CREATE TABLE dyscypliny_medalisci_ind ( 
	id_dyscypliny        integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medalisci_ind PRIMARY KEY ( id_dyscypliny, id_zawodnika )
 );

CREATE INDEX idx_dyscypliny_medalisci_ind_0 ON dyscypliny_medalisci_ind ( id_dyscypliny );

CREATE INDEX idx_dyscypliny_medalisci_ind_1 ON dyscypliny_medalisci_ind ( id_zawodnika );

CREATE TABLE rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_dyscypliny        integer  ,
	data_rozgrywki       date  ,
	id_obiektu           integer  ,
	id_fazy              integer  NOT NULL,
	CONSTRAINT pk_rozgrywki PRIMARY KEY ( id_rozgrywki )
 );

CREATE INDEX idx_rozgrywki_0 ON rozgrywki ( id_obiektu );

CREATE INDEX idx_rozgrywki_1 ON rozgrywki ( id_dyscypliny );

CREATE INDEX idx_rozgrywki ON rozgrywki ( id_fazy );

CREATE TABLE sedziowie_dyscypliny ( 
	id_sedziego          integer  ,
	id_dyscypliny        integer  ,
	CONSTRAINT pk_sedziowie_dyscypliny PRIMARY KEY (id_sedziego, id_dyscypliny)
 );

CREATE INDEX idx_sedziowie_dyscypliny ON sedziowie_dyscypliny ( id_sedziego );

CREATE INDEX idx_sedziowie_dyscypliny_0 ON sedziowie_dyscypliny ( id_dyscypliny );

CREATE TABLE sedziowie_rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_sedziego          integer  NOT NULL,
	CONSTRAINT pk_sedziowie_rozgrywki PRIMARY KEY (id_rozgrywki,id_sedziego)
 );

CREATE INDEX idx_sedziowie_rozgrywki ON sedziowie_rozgrywki ( id_rozgrywki );

CREATE INDEX idx_sedziowie_rozgrywki_0 ON sedziowie_rozgrywki ( id_sedziego );

CREATE TABLE skoki_narciarskie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	odleglosc            numeric(4,1)  ,
	sedzia1              numeric(3,1)  ,
	sedzia2              numeric(3,1)  ,
	sedzia3              numeric(3,1)  ,
	sedzia4              numeric(3,1)  ,
	sedzia5              numeric(3,1)  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

CREATE INDEX idx_skoki_narciarskie ON skoki_narciarskie ( id_zawodnika );

CREATE INDEX idx_skoki_narciarskie_0 ON skoki_narciarskie ( id_rozgrywki );

CREATE TABLE zawodnicy_dyscypliny ( 
	id_zawodnika         integer  ,
	id_dyscypliny        integer  NOT NULL
 );

CREATE INDEX idx_zawodnicy_dyscypliny ON zawodnicy_dyscypliny ( id_zawodnika );

CREATE INDEX idx_zawodnicy_dyscypliny_0 ON zawodnicy_dyscypliny ( id_dyscypliny );

CREATE TABLE biegi_narciarskie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	czas                 numeric  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

ALTER TABLE biegi_narciarskie ADD CONSTRAINT ck_0 CHECK ( status IN ('OK','DNS','DNF','DSQ') );

CREATE INDEX idx_biegi_narciarskie ON biegi_narciarskie ( id_zawodnika );

CREATE INDEX idx_biegi_narciarskie_0 ON biegi_narciarskie ( id_rozgrywki );

CREATE TABLE druzyny ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  NOT NULL,
	id_dyscypliny        integer  NOT NULL,
	id_kraju             integer  NOT NULL,
	CONSTRAINT pk_druzyny PRIMARY KEY ( id )
 );

CREATE INDEX idx_druzyny ON druzyny ( id_dyscypliny );

CREATE INDEX idx_druzyny_0 ON druzyny ( id_kraju );

CREATE TABLE dyscypliny_medale_zes ( 
	id_dyscypliny        integer  NOT NULL,
	id_druzyny           integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medale_zes PRIMARY KEY ( id_dyscypliny, id_druzyny )
 );

CREATE INDEX idx_dyscypliny_medale_zes_0 ON dyscypliny_medale_zes ( id_dyscypliny );

CREATE INDEX idx_dyscypliny_medale_zes_1 ON dyscypliny_medale_zes ( id_druzyny );

CREATE TABLE hokej ( 
	id_zawodnika         integer  NOT NULL,
	id_rozgrywki         integer  ,
	bramki               integer  ,
	bramki_samobojcze    integer  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

CREATE INDEX idx_hokej_0 ON hokej ( id_rozgrywki );

CREATE INDEX idx_hokej ON hokej ( id_zawodnika );

CREATE TABLE lyzwiarstwo_szybkie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	czas                 numeric  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

CREATE INDEX idx_lyzwiarstwo_szybkie ON lyzwiarstwo_szybkie ( id_zawodnika );

CREATE INDEX idx_lyzwiarstwo_szybkie_0 ON lyzwiarstwo_szybkie ( id_rozgrywki );

CREATE TABLE zawodnicy_druzyny ( 
	id_druzyny           integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	CONSTRAINT idx_zawodnicy_druzyny PRIMARY KEY ( id_zawodnika, id_druzyny )
 );

CREATE INDEX idx_zawodnicy_druzyny ON zawodnicy_druzyny ( id_zawodnika );

CREATE INDEX idx_zawodnicy_druzyny_0 ON zawodnicy_druzyny ( id_druzyny );


ALTER TABLE biegi_narciarskie ADD CONSTRAINT fk_biegi_narciarskie 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE biegi_narciarskie ADD CONSTRAINT fk_biegi_narciarskie_0 
FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE doping ADD CONSTRAINT fk_doping 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE druzyny ADD CONSTRAINT fk_druzyny 
FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE druzyny ADD CONSTRAINT fk_druzyny_0 
FOREIGN KEY ( id_kraju ) REFERENCES panstwa( id );

ALTER TABLE dyscypliny ADD CONSTRAINT fk_dyscypliny 
FOREIGN KEY ( id_kategorii ) REFERENCES kategorie( id );

ALTER TABLE dyscypliny_medale_zes ADD CONSTRAINT fk_dyscypliny_medale_zes_0 
FOREIGN KEY ( id_druzyny ) REFERENCES druzyny( id );

ALTER TABLE dyscypliny_medale_zes ADD CONSTRAINT fk_dyscypliny_medale_zes_1 
FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE dyscypliny_medalisci_ind ADD CONSTRAINT fk_dyscypliny_medalisci_ind 
FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE dyscypliny_medalisci_ind ADD CONSTRAINT fk_dyscypliny_medalisci_ind_0 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE hokej ADD CONSTRAINT fk_hokej_0 
FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE hokej ADD CONSTRAINT fk_hokej 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE lyzwiarstwo_szybkie ADD CONSTRAINT fk_lyzwiarstwo_szybkie 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE lyzwiarstwo_szybkie ADD CONSTRAINT fk_lyzwiarstwo_szybkie_0 
FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE rozgrywki ADD CONSTRAINT fk_rozgrywki_0 
FOREIGN KEY ( id_obiektu ) REFERENCES obiekty( id );

ALTER TABLE rozgrywki ADD CONSTRAINT fk_rozgrywki_1 
FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE rozgrywki ADD CONSTRAINT fk_rozgrywki 
FOREIGN KEY ( id_fazy ) REFERENCES fazy( id );

ALTER TABLE sedziowie_dyscypliny ADD CONSTRAINT fk_sedziowie_dyscypliny 
FOREIGN KEY ( id_sedziego ) REFERENCES sedziowie( id );

ALTER TABLE sedziowie_dyscypliny ADD CONSTRAINT fk_sedziowie_dyscypliny_0 
FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

ALTER TABLE sedziowie_rozgrywki ADD CONSTRAINT fk_sedziowie_rozgrywki 
FOREIGN KEY ( id_sedziego ) REFERENCES sedziowie( id );

ALTER TABLE sedziowie_rozgrywki ADD CONSTRAINT fk_sedziowie_rozgrywki_0 
FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE skoki_narciarskie ADD CONSTRAINT fk_skoki_narciarskie 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE skoki_narciarskie ADD CONSTRAINT fk_skoki_narciarskie_0 
FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki );

ALTER TABLE zawodnicy ADD CONSTRAINT fk_zawodnicy 
FOREIGN KEY ( id_panstwa ) REFERENCES panstwa( id );

ALTER TABLE zawodnicy_druzyny ADD CONSTRAINT fk_zawodnicy_druzyny 
FOREIGN KEY ( id_druzyny ) REFERENCES druzyny( id );

ALTER TABLE zawodnicy_druzyny ADD CONSTRAINT fk_zawodnicy_druzyny_0 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE zawodnicy_dyscypliny ADD CONSTRAINT fk_zawodnicy_dyscypliny 
FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id );

ALTER TABLE zawodnicy_dyscypliny ADD CONSTRAINT fk_zawodnicy_dyscypliny_0 
FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id );

