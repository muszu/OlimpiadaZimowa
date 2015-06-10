DROP SCHEMA IF EXISTS "winter olympics" CASCADE;

CREATE SCHEMA "winter olympics";

CREATE TABLE "winter olympics".fazy ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	CONSTRAINT pk_fazy PRIMARY KEY ( id )
 );

CREATE TABLE "winter olympics".kategorie ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	nadkategoria         integer  ,
	CONSTRAINT pk_kategorie PRIMARY KEY ( id )
 );

CREATE TABLE "winter olympics".obiekty ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	typ                  varchar(30)  ,
	adres                varchar(50)  ,
	CONSTRAINT pk_obiekty PRIMARY KEY ( id )
 );

CREATE TABLE "winter olympics".panstwa ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	CONSTRAINT pk_panstwa PRIMARY KEY ( id )
 );

CREATE TABLE "winter olympics".sedziowie ( 
	id                   integer  NOT NULL,
	imie                 varchar(30)  ,
	nazwisko             varchar(30)  ,
	CONSTRAINT pk_sedziowie PRIMARY KEY ( id )
 );

CREATE TABLE "winter olympics".dyscypliny ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  ,
	id_kategorii         integer  ,
	CONSTRAINT pk_dyscypliny PRIMARY KEY ( id )
 );

CREATE INDEX idx_dyscypliny ON "winter olympics".dyscypliny ( id_kategorii );

CREATE TABLE "winter olympics".rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_dyscypliny        integer  ,
	data_rozgrywki       date  ,
	id_obiektu           integer  ,
	id_fazy              integer  NOT NULL,
	CONSTRAINT pk_rozgrywki PRIMARY KEY ( id_rozgrywki )
 );

CREATE INDEX idx_rozgrywki_0 ON "winter olympics".rozgrywki ( id_obiektu );

CREATE INDEX idx_rozgrywki_1 ON "winter olympics".rozgrywki ( id_dyscypliny );

CREATE INDEX idx_rozgrywki ON "winter olympics".rozgrywki ( id_fazy );

CREATE TABLE "winter olympics".sedziowie_dyscypliny ( 
	id_sedziego          integer  ,
	id_dyscypliny        integer  
 );

CREATE INDEX idx_sedziowie_dyscypliny ON "winter olympics".sedziowie_dyscypliny ( id_sedziego );

CREATE INDEX idx_sedziowie_dyscypliny_0 ON "winter olympics".sedziowie_dyscypliny ( id_dyscypliny );

CREATE TABLE "winter olympics".sedziowie_rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_sedziego          integer  NOT NULL
 );

CREATE INDEX idx_sedziowie_rozgrywki ON "winter olympics".sedziowie_rozgrywki ( id_rozgrywki );

CREATE INDEX idx_sedziowie_rozgrywki_0 ON "winter olympics".sedziowie_rozgrywki ( id_sedziego );

CREATE TABLE "winter olympics".druzyny ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  NOT NULL,
	id_dyscypliny        integer  NOT NULL,
	id_kraju             integer  NOT NULL,
	CONSTRAINT pk_druzyny PRIMARY KEY ( id )
 );

CREATE INDEX idx_druzyny ON "winter olympics".druzyny ( id_dyscypliny );

CREATE INDEX idx_druzyny_0 ON "winter olympics".druzyny ( id_kraju );

CREATE TABLE "winter olympics".dyscypliny_medale_zes ( 
	id_dyscypliny        integer  NOT NULL,
	id_druzyny           integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medale_zes PRIMARY KEY ( id_dyscypliny, id_druzyny )
 );

CREATE INDEX idx_dyscypliny_medale_zes_0 ON "winter olympics".dyscypliny_medale_zes ( id_dyscypliny );

CREATE INDEX idx_dyscypliny_medale_zes_1 ON "winter olympics".dyscypliny_medale_zes ( id_druzyny );

CREATE TABLE "winter olympics".hokej ( 
	id_panstwa           integer  ,
	id_rozgrywki         integer  ,
	punkty               integer  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

CREATE INDEX idx_hokej ON "winter olympics".hokej ( id_panstwa );

CREATE INDEX idx_hokej_0 ON "winter olympics".hokej ( id_rozgrywki );

CREATE TABLE "winter olympics".zawodnicy_druzyny ( 
	id_druzyny           integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	CONSTRAINT pk_zawodnicy_druzyny UNIQUE ( id_zawodnika ) 
 );

CREATE INDEX idx_zawodnicy_druzyny ON "winter olympics".zawodnicy_druzyny ( id_druzyny );

CREATE TABLE "winter olympics".zawodnicy ( 
	id                   integer  NOT NULL,
	imie                 varchar(30)  ,
	nazwisko             varchar(30)  ,
	id_panstwa           integer  ,
	plec                 char(1)  NOT NULL,
	data_urodzenia       date  NOT NULL,
	CONSTRAINT pk_table_0 PRIMARY KEY ( id )
 );

ALTER TABLE "winter olympics".zawodnicy ADD CONSTRAINT ck_plec CHECK ( plec IN ('M','F') );

CREATE INDEX idx_zawodnicy ON "winter olympics".zawodnicy ( id_panstwa );

CREATE TABLE "winter olympics".zawodnicy_dyscypliny ( 
	id_zawodnika         integer  ,
	id_dyscypliny        integer  NOT NULL
 );

CREATE INDEX idx_zawodnicy_dyscypliny ON "winter olympics".zawodnicy_dyscypliny ( id_zawodnika );

CREATE INDEX idx_zawodnicy_dyscypliny_0 ON "winter olympics".zawodnicy_dyscypliny ( id_dyscypliny );

CREATE TABLE "winter olympics".biegi_narciarskie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	czas                 numeric  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

ALTER TABLE "winter olympics".biegi_narciarskie ADD CONSTRAINT ck_0 CHECK ( status IN ('OK','DNS','DNF','DSQ') );

CREATE INDEX idx_biegi_narciarskie ON "winter olympics".biegi_narciarskie ( id_zawodnika );

CREATE INDEX idx_biegi_narciarskie_0 ON "winter olympics".biegi_narciarskie ( id_rozgrywki );

CREATE TABLE "winter olympics".doping ( 
	id_zawodnika         integer  ,
	data_pobrania        date  ,
	wynik                bool  
 );

CREATE INDEX idx_doping ON "winter olympics".doping ( id_zawodnika );

CREATE TABLE "winter olympics".dyscypliny_medalisci_ind ( 
	id_dyscypliny        integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medalisci_ind PRIMARY KEY ( id_dyscypliny, id_zawodnika )
 );

CREATE INDEX idx_dyscypliny_medalisci_ind_0 ON "winter olympics".dyscypliny_medalisci_ind ( id_dyscypliny );

CREATE INDEX idx_dyscypliny_medalisci_ind_1 ON "winter olympics".dyscypliny_medalisci_ind ( id_zawodnika );

CREATE TABLE "winter olympics".lyzwiarstwo_szybkie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	czas                 numeric  ,
	status               char(1) DEFAULT 'OK' NOT NULL
 );

CREATE INDEX idx_lyzwiarstwo_szybkie ON "winter olympics".lyzwiarstwo_szybkie ( id_zawodnika );

CREATE INDEX idx_lyzwiarstwo_szybkie_0 ON "winter olympics".lyzwiarstwo_szybkie ( id_rozgrywki );

CREATE TABLE "winter olympics".skoki_narciarskie ( 
	id_zawodnika         integer  ,
	id_rozgrywki         integer  ,
	seria1               numeric(3,2)  ,
	seria2               numeric(3,2)  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL
 );

CREATE INDEX idx_skoki_narciarskie ON "winter olympics".skoki_narciarskie ( id_zawodnika );

CREATE INDEX idx_skoki_narciarskie_0 ON "winter olympics".skoki_narciarskie ( id_rozgrywki );

ALTER TABLE "winter olympics".biegi_narciarskie ADD CONSTRAINT fk_biegi_narciarskie FOREIGN KEY ( id_zawodnika ) REFERENCES "winter olympics".zawodnicy( id );

ALTER TABLE "winter olympics".biegi_narciarskie ADD CONSTRAINT fk_biegi_narciarskie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES "winter olympics".rozgrywki( id_rozgrywki );

ALTER TABLE "winter olympics".doping ADD CONSTRAINT fk_doping FOREIGN KEY ( id_zawodnika ) REFERENCES "winter olympics".zawodnicy( id );

ALTER TABLE "winter olympics".druzyny ADD CONSTRAINT fk_druzyny FOREIGN KEY ( id_dyscypliny ) REFERENCES "winter olympics".dyscypliny( id );

ALTER TABLE "winter olympics".druzyny ADD CONSTRAINT fk_druzyny_0 FOREIGN KEY ( id_kraju ) REFERENCES "winter olympics".panstwa( id );

ALTER TABLE "winter olympics".dyscypliny ADD CONSTRAINT fk_dyscypliny FOREIGN KEY ( id_kategorii ) REFERENCES "winter olympics".kategorie( id );

ALTER TABLE "winter olympics".dyscypliny_medale_zes ADD CONSTRAINT fk_dyscypliny_medale_zes_0 FOREIGN KEY ( id_druzyny ) REFERENCES "winter olympics".druzyny( id );

ALTER TABLE "winter olympics".dyscypliny_medale_zes ADD CONSTRAINT fk_dyscypliny_medale_zes_1 FOREIGN KEY ( id_dyscypliny ) REFERENCES "winter olympics".dyscypliny( id );

ALTER TABLE "winter olympics".dyscypliny_medalisci_ind ADD CONSTRAINT fk_dyscypliny_medalisci_ind FOREIGN KEY ( id_dyscypliny ) REFERENCES "winter olympics".dyscypliny( id );

ALTER TABLE "winter olympics".dyscypliny_medalisci_ind ADD CONSTRAINT fk_dyscypliny_medalisci_ind_0 FOREIGN KEY ( id_zawodnika ) REFERENCES "winter olympics".zawodnicy( id );

ALTER TABLE "winter olympics".hokej ADD CONSTRAINT fk_hokej FOREIGN KEY ( id_panstwa ) REFERENCES "winter olympics".panstwa( id );

ALTER TABLE "winter olympics".hokej ADD CONSTRAINT fk_hokej_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES "winter olympics".rozgrywki( id_rozgrywki );

ALTER TABLE "winter olympics".lyzwiarstwo_szybkie ADD CONSTRAINT fk_lyzwiarstwo_szybkie FOREIGN KEY ( id_zawodnika ) REFERENCES "winter olympics".zawodnicy( id );

ALTER TABLE "winter olympics".lyzwiarstwo_szybkie ADD CONSTRAINT fk_lyzwiarstwo_szybkie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES "winter olympics".rozgrywki( id_rozgrywki );

ALTER TABLE "winter olympics".rozgrywki ADD CONSTRAINT fk_rozgrywki_0 FOREIGN KEY ( id_obiektu ) REFERENCES "winter olympics".obiekty( id );

ALTER TABLE "winter olympics".rozgrywki ADD CONSTRAINT fk_rozgrywki_1 FOREIGN KEY ( id_dyscypliny ) REFERENCES "winter olympics".dyscypliny( id );

ALTER TABLE "winter olympics".rozgrywki ADD CONSTRAINT fk_rozgrywki FOREIGN KEY ( id_fazy ) REFERENCES "winter olympics".fazy( id );

ALTER TABLE "winter olympics".sedziowie_dyscypliny ADD CONSTRAINT fk_sedziowie_dyscypliny FOREIGN KEY ( id_sedziego ) REFERENCES "winter olympics".sedziowie( id );

ALTER TABLE "winter olympics".sedziowie_dyscypliny ADD CONSTRAINT fk_sedziowie_dyscypliny_0 FOREIGN KEY ( id_dyscypliny ) REFERENCES "winter olympics".dyscypliny( id );

ALTER TABLE "winter olympics".sedziowie_rozgrywki ADD CONSTRAINT fk_sedziowie_rozgrywki FOREIGN KEY ( id_sedziego ) REFERENCES "winter olympics".sedziowie( id );

ALTER TABLE "winter olympics".sedziowie_rozgrywki ADD CONSTRAINT fk_sedziowie_rozgrywki_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES "winter olympics".rozgrywki( id_rozgrywki );

ALTER TABLE "winter olympics".skoki_narciarskie ADD CONSTRAINT fk_skoki_narciarskie FOREIGN KEY ( id_zawodnika ) REFERENCES "winter olympics".zawodnicy( id );

ALTER TABLE "winter olympics".skoki_narciarskie ADD CONSTRAINT fk_skoki_narciarskie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES "winter olympics".rozgrywki( id_rozgrywki );

ALTER TABLE "winter olympics".zawodnicy ADD CONSTRAINT fk_zawodnicy FOREIGN KEY ( id_panstwa ) REFERENCES "winter olympics".panstwa( id );

ALTER TABLE "winter olympics".zawodnicy ADD CONSTRAINT fk_zawodnicy_0 FOREIGN KEY ( id ) REFERENCES "winter olympics".zawodnicy_druzyny( id_zawodnika );

ALTER TABLE "winter olympics".zawodnicy_druzyny ADD CONSTRAINT fk_zawodnicy_druzyny FOREIGN KEY ( id_druzyny ) REFERENCES "winter olympics".druzyny( id );

ALTER TABLE "winter olympics".zawodnicy_dyscypliny ADD CONSTRAINT fk_zawodnicy_dyscypliny FOREIGN KEY ( id_zawodnika ) REFERENCES "winter olympics".zawodnicy( id );

ALTER TABLE "winter olympics".zawodnicy_dyscypliny ADD CONSTRAINT fk_zawodnicy_dyscypliny_0 FOREIGN KEY ( id_dyscypliny ) REFERENCES "winter olympics".dyscypliny( id );

