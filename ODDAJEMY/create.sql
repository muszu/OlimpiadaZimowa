
CREATE TABLE fazy ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  NOT NULL,
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
	typ                  varchar(30)  NOT NULL,
	adres                varchar(50)  ,
	miasto               varchar(30)  NOT NULL,
	CONSTRAINT pk_obiekty PRIMARY KEY ( id )
 );

CREATE TABLE panstwa ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  NOT NULL,
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
	imie                 varchar(30)  NOT NULL,
	nazwisko             varchar(30)  NOT NULL,
	id_panstwa           integer  NOT NULL,
	plec                 char(1)  NOT NULL,
	data_urodzenia       date  NOT NULL,
	CONSTRAINT pk_table_0 PRIMARY KEY ( id ),
	CONSTRAINT fk_zawodnicy FOREIGN KEY ( id_panstwa ) REFERENCES panstwa( id )    
 );

ALTER TABLE zawodnicy ADD CONSTRAINT ck_plec CHECK ( plec IN ('M','F') );


CREATE TABLE doping ( 
	id_zawodnika         integer  ,
	data_pobrania        date  ,
	wynik                bool  ,
	CONSTRAINT fk_doping FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    
 );


CREATE TABLE dyscypliny ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  NOT NULL,
	id_kategorii         integer  ,
	zakonczona           bool DEFAULT false ,
	CONSTRAINT pk_dyscypliny PRIMARY KEY ( id ),
	CONSTRAINT fk_dyscypliny FOREIGN KEY ( id_kategorii ) REFERENCES kategorie( id )    
 );

CREATE TABLE dyscypliny_medalisci_ind ( 
	id_dyscypliny        integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medalisci_ind PRIMARY KEY ( id_dyscypliny, id_zawodnika ),
	CONSTRAINT fk_dyscypliny_medalisci_ind FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id )    ,
	CONSTRAINT fk_dyscypliny_medalisci_ind_0 FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    
 );

CREATE TABLE rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_dyscypliny        integer  NOT NULL,
	data_rozgrywki       date  ,
	id_obiektu           integer  ,
	id_fazy              integer  NOT NULL,
	CONSTRAINT pk_rozgrywki PRIMARY KEY ( id_rozgrywki ),
	CONSTRAINT fk_rozgrywki_0 FOREIGN KEY ( id_obiektu ) REFERENCES obiekty( id )    ,
	CONSTRAINT fk_rozgrywki_1 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id )    ,
	CONSTRAINT fk_rozgrywki FOREIGN KEY ( id_fazy ) REFERENCES fazy( id )    
 );

CREATE TABLE sedziowie_dyscypliny ( 
	id_sedziego          integer  NOT NULL,
	id_dyscypliny        integer  NOT NULL,
	CONSTRAINT idx_sedziowie_dyscypliny_1 PRIMARY KEY ( id_sedziego, id_dyscypliny ),
	CONSTRAINT fk_sedziowie_dyscypliny FOREIGN KEY ( id_sedziego ) REFERENCES sedziowie( id )    ,
	CONSTRAINT fk_sedziowie_dyscypliny_0 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id )    
 );

CREATE TABLE sedziowie_rozgrywki ( 
	id_rozgrywki         integer  NOT NULL,
	id_sedziego          integer  NOT NULL,
	CONSTRAINT idx_sedziowie_rozgrywki_1 PRIMARY KEY ( id_rozgrywki, id_sedziego ),
	CONSTRAINT fk_sedziowie_rozgrywki FOREIGN KEY ( id_sedziego ) REFERENCES sedziowie( id )    ,
	CONSTRAINT fk_sedziowie_rozgrywki_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki )    
 );

CREATE TABLE skoki_narciarskie ( 
	id_zawodnika         integer  NOT NULL,
	id_rozgrywki         integer  NOT NULL,
	odleglosc            numeric(4,1)  ,
	sedzia1              numeric(3,1)  ,
	sedzia2              numeric(3,1)  ,
	sedzia3              numeric(3,1)  ,
	sedzia4              numeric(3,1)  ,
	sedzia5              numeric(3,1)  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL,
	CONSTRAINT idx_skoki_narciarskie_1 PRIMARY KEY ( id_zawodnika, id_rozgrywki ),
	CONSTRAINT fk_skoki_narciarskie FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    ,
	CONSTRAINT fk_skoki_narciarskie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki )    
 );

CREATE TABLE zawodnicy_dyscypliny ( 
	id_zawodnika         integer  NOT NULL,
	id_dyscypliny        integer  NOT NULL,
	CONSTRAINT idx_zawodnicy_dyscypliny_1 PRIMARY KEY ( id_zawodnika, id_dyscypliny ),
	CONSTRAINT fk_zawodnicy_dyscypliny FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    ,
	CONSTRAINT fk_zawodnicy_dyscypliny_0 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id )    
 );

CREATE TABLE biegi_narciarskie ( 
	id_zawodnika         integer  NOT NULL,
	id_rozgrywki         integer  NOT NULL,
	czas                 numeric  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL,
	CONSTRAINT idx_biegi_narciarskie_1 PRIMARY KEY ( id_zawodnika, id_rozgrywki ),
	CONSTRAINT fk_biegi_narciarskie FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    ,
	CONSTRAINT fk_biegi_narciarskie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki )    
 );

ALTER TABLE biegi_narciarskie ADD CONSTRAINT ck_0 CHECK ( status IN ('OK','DNS','DNF','DSQ') );

CREATE TABLE druzyny ( 
	id                   integer  NOT NULL,
	nazwa                varchar(30)  NOT NULL,
	id_dyscypliny        integer  NOT NULL,
	id_kraju             integer  NOT NULL,
	CONSTRAINT pk_druzyny PRIMARY KEY ( id ),
	CONSTRAINT fk_druzyny FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id )    ,
	CONSTRAINT fk_druzyny_0 FOREIGN KEY ( id_kraju ) REFERENCES panstwa( id )    
 );

CREATE TABLE dyscypliny_medale_zes ( 
	id_dyscypliny        integer  NOT NULL,
	id_druzyny           integer  NOT NULL,
	medal                integer  NOT NULL,
	CONSTRAINT idx_dyscypliny_medale_zes PRIMARY KEY ( id_dyscypliny, id_druzyny ),
	CONSTRAINT fk_dyscypliny_medale_zes_0 FOREIGN KEY ( id_druzyny ) REFERENCES druzyny( id )    ,
	CONSTRAINT fk_dyscypliny_medale_zes_1 FOREIGN KEY ( id_dyscypliny ) REFERENCES dyscypliny( id )    
 );

CREATE TABLE hokej ( 
	id_zawodnika         integer  NOT NULL,
	id_rozgrywki         integer  NOT NULL,
	bramki               integer  NOT NULL,
	bramki_samobojcze    integer  NOT NULL,
	CONSTRAINT idx_hokej_1 PRIMARY KEY ( id_zawodnika, id_rozgrywki ),
	CONSTRAINT fk_hokej_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki )    ,
	CONSTRAINT fk_hokej FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    
 );

CREATE TABLE lyzwiarstwo_szybkie ( 
	id_zawodnika         integer  NOT NULL,
	id_rozgrywki         integer  NOT NULL,
	czas                 numeric  ,
	status               varchar(3) DEFAULT 'OK' NOT NULL,
	CONSTRAINT idx_lyzwiarstwo_szybkie_1 PRIMARY KEY ( id_zawodnika, id_rozgrywki ),
	CONSTRAINT fk_lyzwiarstwo_szybkie FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    ,
	CONSTRAINT fk_lyzwiarstwo_szybkie_0 FOREIGN KEY ( id_rozgrywki ) REFERENCES rozgrywki( id_rozgrywki )    
 );

CREATE TABLE zawodnicy_druzyny ( 
	id_druzyny           integer  NOT NULL,
	id_zawodnika         integer  NOT NULL,
	CONSTRAINT idx_zawodnicy_druzyny PRIMARY KEY ( id_druzyny, id_zawodnika ),
	CONSTRAINT fk_zawodnicy_druzyny FOREIGN KEY ( id_druzyny ) REFERENCES druzyny( id )    ,
	CONSTRAINT fk_zawodnicy_druzyny_0 FOREIGN KEY ( id_zawodnika ) REFERENCES zawodnicy( id )    
 );


BEGIN;


COPY fazy FROM stdin;
1	final
2	polfinal
3	cwiercfinal
4	eliminacje
5	playoff
6	mecz o 3 miejsce
7	seria 1
8	seria 2
\.


COPY sedziowie FROM stdin;
1	Kamil	Nowak
2	Petr	Iwanow
3	John	Miller
4	Alex	Thomson
5	Michael	Smith
6	Egor	Schmidt
7	Gregor	Fischer
8	Roman	Kowalski
9	Adam	Neuer
10	Daniel	Hoffman
11	Robert	Becker
12	Olivia	White
13	Joanne	Brown
14	Lucia	Hernandez
15	Sofia	Thomas
16	Martha	Evans
17	Anna	Wojcik
18	John	Miller
19	John	Watson
20	Olivia	Evans
21	Ann	Green
\.


COPY panstwa FROM stdin;
1	 Great Britain
2	 Germany
3	 Poland
4	 Russia
5	 United States
6	 Greece
7	 Japan
8	 Latvia
9	 Mexico
10	 Norway
11	 Nigeria
12	 Serbia
13	 Sweden
14	 Turkey
15	 Vietnam
16	 Ukraine
17	 Brazil
18	 Austria
\.


COPY kategorie FROM stdin WITH null AS 'null';
1	 biathlon	biathlon
2	 curling	curling
3	 hokej na lodzie	hokej na lodzie
4	 lyzwiarstwo figurowe	 lyzwiarstwo
5	 lyzwiarstwo szybkie	 lyzwiarstwo
6	 short track	 lyzwiarstwo
7	 biegi narciarskie	 narciarstwo
8	 kombinacja norweska	 narciarstwo
9	 narciarstwo alpejskie	 narciarstwo
10	 narciarstwo dowolne	 narciarstwo
11	 skoki narciarskie	 narciarstwo
12	 snowboarding	 narciarstwo
\.


COPY dyscypliny FROM stdin;
1	 10 000 m mezczyzn	 5	false
2	 1000 m kobiet	 5	true
3	 1000 m mezczyzn	5	false
4	 500 m kobiet	 5	false
5	 bieg druzynowy kobiet	 5	false
6	 bieg druzynowy mezczyzn	 5	false
7	 turniej kobiet	 3	true
8	 turniej mezczyzn	 3	false
9	 skocznia duza mezczyzn	 11	false
10	 skocznia normalna mezczyzn	 11	true
11	 skocznia normalna kobiet	 11	false
12	 konkurs druzynowy mezczyzn	 11	false
13	 bieg indywidualny kobiet	 7	false
14	 bieg indywidualny mezczyzn	 7	false
15	 bieg laczony kobiet	 7	false
16	 sprint druzynowy kobiet	 7	false
17	 sprint druzynowy mezczyzn	 7	false
18	 sprint kobiet	 7	false
19	 sztafeta mezczyzn	 7	false
\.


COPY druzyny FROM stdin;
1	GBR	8	1
2	GBR	7	1
3	POL	8	3
4	POL	7	3
5	GER	8	2
6	GER	7	2
7	SWE	8	13
8	SWE	7	13
9	AUS1	12	18
10	AUS2	12	18
11	JAP1	12	7
12	JAP2	12	7
13	GER	12	2
14	USA	12	5
15	NOR	12	10
16	NOR1	16	10
17	NOR2	16	10
18	NOR1	17	10
19	NOR2	17	10
20	AUS	16	18
21	AUS	17	18
22	POL	16	3
23	POL	17	3
24	BRA	16	17
25	BRA	17	17
\.


COPY zawodnicy FROM stdin;
1 	Adam	Nowak	1	M	1988-08-30
2 	Jacob	Nowak	1	M	1978-04-20
3 	Steven	Nowak	1	M	1986-01-24
4 	Olivia	Kowalska	1	F	1989-12-05
5 	Caroline	Kowalska	1	F	1995-08-31
6 	Martha	Kowalska	1	F	1982-11-04
7 	Michael	Nowak	3	M	1973-05-24
8 	Thomas	Nowak	3	M	1991-02-13
9 	Alex	Nowak	3	M	1993-08-23
10 	Joanne	Kowalska	3	F	1983-06-14
11	Ann	Kowalska	3	F	1983-07-17
12	Dominique	Kowalska	3	F	1984-04-06
13 	John	Nowak	2	M	1981-02-01
14	Jack	Nowak	2	M	1985-03-30
15	Robert	Nowak	2	M	1986-07-24
16	Claire	Kowalska	2	F	1995-09-22
17	Lisa	Kowalska	2	F	1989-12-31
18	Maria	Kowalska	2	F	1990-01-01
19 	John	Nowak	13	M	1964-04-20
20	Robert	Nowak	13	M	1983-07-30
21	Alex	Nowak	13	M	1976-05-23
22	Jane	Kowalska	13	F	1977-03-16
23	Marie	Kowalska	13	F	1978-01-09
24	Caroline	Kowalska	13	F	1979-02-02
25	Carol	Nowak	18	M	1980-04-25
26	John	Nowak	18	M	1981-06-18
27	Gregory	Nowak	18	M	1982-08-11
28	Gregor	Nowak	18	M	1983-10-04
29	Michal	Nowak	7	M	1984-12-28
30	Antoine	Nowak	7	M	1985-11-21
31	Mark	Nowak	7	M	1986-09-14
32	Jack	Nowak	7	M	1987-07-07
33	Chris	Nowak	2	M	1988-05-31
34	Steven	Nowak	2	M	1989-03-24
35	Eric	Nowak	5	M	1990-01-17
36	Robert	Nowak	5	M	1991-02-10
37	Michael	Nowak	10	M	1992-04-03
38	John	Nowak	10	M	1993-06-26
39	Marie	Kowalska	10	F	1994-08-19
40	Olivia	Kowalska	10	F	1995-10-12
41	Allison	Kowalska	10	F	1996-12-05
42	Diane	Kowalska	10	F	1979-11-28
43	Chris	Nowak	10	M	1978-09-21
44	Robert	Nowak	10	M	1977-07-14
45	Bob	Nowak	10	M	1976-05-07
46	Carol	Nowak	10	M	1975-03-31
47	Alicia	Kowalska	18	F	1974-01-24
48	Jane	Kowalska	18	F	1973-02-17
49	Adam	Nowak	18	M	1980-04-10
50	Mark	Nowak	18	M	1981-06-03
51	Marie	Kowalska	3	F	1982-08-27
52	Maria	Kowalska	3	F	1983-10-20
53	John	Nowak	3	M	1984-12-13
54	Eric	Nowak	3	M	1985-11-06
55	Caroline	Kowalska	17	F	1986-09-29
56	Jane	Kowalska	17	F	1987-07-22
57	Adam	Nowak	17	M	1988-05-15
58	Carol	Nowak	17	M	1989-03-08
59	Michael	Nowak	6	M	1980-01-01
60	Eric	Nowak	8	M	1981-02-22
61	Steven	Nowak	9	M	1982-04-15
62	Adam	Nowak	11	M	1983-06-08
63	Marie	Kowalska	1	F	1984-08-01
64	Alice	Kowalska	2	F	1985-10-24
65	Jane	Kowalska	2	F	1986-12-17
66	Allison	Kowalska	3	F	1987-11-10
67	Francesca	Kowalska	4	F	1988-09-03
68	Diane	Kowalska	5	F	1989-07-27
69	Claire	Kowalska	6	F	1980-05-20
70	Alicia	Kowalska	7	F	1981-03-13
71	Jane	Kowalska	8	F	1982-01-06
72	Francesca	Kowalska	9	F	1983-02-28
73	Joanne	Kowalska	10	F	1984-04-21
74	Caroline	Kowalska	11	F	1985-06-14
75	Martha	Kowalska	12	F	1986-08-07
76	Anne	Kowalska	13	F	1987-10-31
77	Alice	Kowalska	13	F	1988-12-24
78	Marie	Kowalska	13	F	1989-11-17
79	Jane	Kowalska	13	F	1980-09-10
80	Jane	Kowalska	15	F	1981-07-03
81	Caroline	Kowalska	16	F	1982-05-27
82	Martha	Kowalska	17	F	1983-03-20
83	Sophie	Kowalska	18	F	1984-01-13
\.


COPY zawodnicy_druzyny FROM stdin;
1	1
1	2
1	3
2	4
2	5
2	6
3	7
3	8
3	9
4	10
4	11
4	12
5	13
5	14
5	15
6	16
6	17
6	18
7	19
7	20
7	21
8	22
8	23
8	24
9	25
9	26
10	27
10	28
11	29
11	30
12	31
12	32
13	33
13	34
14	35
14	36
15	37
15	38
16	39
16	40
17	41
17	42
18	43
18	44
19	45
19	46
20	47
20	48
21	49
21	50
22	51
22	52
23	53
23	54
24	55
24	56
25	57
25	58
\.


COPY zawodnicy_dyscypliny FROM stdin;
1	8
2	8
3	8
4	7
5	7
6	7
7	8
8	8
9	8
10	7
11	7
12	7
13	8
14	8
15	8
16	7
17	7
18	7
19	8
20	8
21	8
22	7
23	7
24	7
25	12
26	12
27	12
28	12
29	12
30	12
31	12
32	12
33	12
34	12
35	12
36	12
37	12
38	12
39	16
40	16
41	16
42	16
43	17
44	17
45	17
46	17
47	16
48	16
49	17
50	17
51	16
52	16
53	17
54	17
55	16
56	16
57	17
58	17
25	10
26	10
27	10
28	10
29	10
30	10
31	10
32	10
33	10
34	10
35	10
36	10
37	10
38	10
59	10
60	10
61	10
62	10
63	2
63	4
64	2
64	4
65	2
65	4
66	2
66	4
67	2
67	4
68	2
68	4
69	2
69	4
70	2
70	4
71	2
71	4
72	4
73	2
73	4
74	2
74	4
75	4
76	2
76	4
77	2
78	2
78	4
79	2
80	2
80	4
81	2
81	4
82	2
82	4
83	4
58	14
43	14
44	14
45	14
46	14
49	14
50	14
53	14
54	14
57	14
\.



COPY doping FROM stdin WITH null AS 'null';
1	2015-06-23	null
15	2015-06-20	false
8	2015-06-20	null
9	2015-06-20	null
5	2015-06-20	false
1	2015-06-21	null
4	2015-06-21	null
3	2015-06-21	null
2	2015-06-21	false
10	2015-06-21	null
\.

COPY obiekty FROM stdin WITH null AS 'null';
1	Adler-Arena	tor lyzwiarski	null	 Soczi
2	Arena lodowa Szajba	lodowisko	null	 Soczi
3	Russkije Gorki	skocznia narciarska	null	 Krasnaja Polana
4	Kompleks Laura	trasa biegowa	null	Krasnaja Polana
\.

COPY rozgrywki FROM stdin;
1	7	2015-05-12	2	2
2	7	2015-05-13	2	2
3	7	2015-05-14	2	1
4	8	2015-05-14	2	2
5	8	2015-05-15	2	2
6	2	2015-05-10	1	4
7	2	2015-05-15	1	1
8	8	2015-05-14	2	6
9	7	2015-05-16	2	6
10	10	2015-05-25	3	7
11	10	2015-05-25	3	8
12	12	2015-05-30	3	7
13	12	2015-05-30	3	8
14	16	2015-06-01	4	4
15	16	2015-06-05	4	1
16	17	2015-06-10	4	4
17	17	2015-06-15	4	1
18	14	2015-06-02	4	4
\.

COPY lyzwiarstwo_szybkie FROM stdin WITH null AS 'null';
82	6	67.34	OK
81	6	68.76	OK
80	6	68.77	OK
79	6	68.79	OK
78	6	68.80	OK
77	6	69.05	OK
76	6	null	DNF
74	6	null	DNS
73	6	null	NDF
71	6	69.89	OK
70	6	70.80	OK
69	6	70.89	OK
68	6	71.10	OK
67	6	71.40	OK
66	6	71.34	OK
65	6	null	DNS
64	6	null	DNF
63	6	73.34	OK
82	7	66.10	OK
81	7	66.10	OK
80	7	66.77	OK
79	7	66.98	OK
78	7	null	DNF
77	7	68.05	OK
\.

COPY hokej FROM stdin;
12	1	4	0
11	1	1	0
10	1	0	1
6	1	1	0
5	1	1	0
4	1	0	0
18	2	0	0
17	2	0	0
16	2	0	0
22	2	1	0
23	2	0	0
24	2	0	0
10	3	0	0
11	3	1	0
12	3	1	0
22	3	0	0
23	3	0	1
24	3	0	0
7	4	0	0
8	4	0	0
9	4	0	0
13	4	1	0
14	4	1	0
15	4	1	0
1	5	3	0
2	5	0	0
3	5	0	0
19	5	1	1
20	5	1	1
21	5	1	0
9	8	0	0
8	8	1	1
7	8	0	1
21 	8	2	0
20	8	3	0
19	8	1	1
6	9	3	0
5	9	4	0
4	9	5	1
18	9	1	0
17	9	0	0
16	9	1	2
\.

COPY skoki_narciarskie FROM stdin;
25	10	134.5	18.5	18.0	17.5	17.0	16.5	OK
26	10	140.5	18.0	17.0	16.5	18.5	16.5	OK
27	10	134.0	18.0	18.0	17.0	17.0	18.0	OK
28	10	130.5	18.0	16.0	19.5	18.5	16.5	OK
29	10	112.0	18.5	18.5	17.5	17.0	18.0	OK
30	10	117.5	18.5	18.0	19.0	19.0	16.5	OK
31	10	124.5	18.0	19.5	18.5	17.5	18.5	OK
32	10	120.0	18.5	18.0	17.5	17.0	16.0	OK
33	10	130.5	16.5	18.5	19.0	19.0	19.0	OK
34	10	138.0	18.5	16.0	17.5	17.5	16.0	OK
35	10	110.5	17.5	18.5	16.5	17.0	19.5	OK
36	10	98.5	18.5	18.0	17.0	19.0	17.5	OK
37	10	106.5	16.5	17.5	18.5	17.5	16.0	OK
38	10	142.0	18.5	18.0	18.5	17.0	17.5	OK
59	10	146.5	19.5	17.5	20.0	16.0	16.0	OK
60	10	132.0	18.0	18.0	17.5	17.5	17.5	OK
61	10	130.5	18.5	19.5	18.5	16.0	17.0	OK
62	10	131.0	20.0	18.0	17.5	17.0	16.5	OK
59	11	136.0	18.5	18.0	17.5	17.0	16.5	OK
38	11	140.5	18.0	17.0	16.5	18.5	16.5	OK
26	11	134.0	18.0	18.0	17.0	17.0	18.0	OK
34	11	130.5	18.0	16.0	19.5	18.5	16.5	OK
33	11	112.0	18.5	18.5	17.5	17.0	18.0	OK
25	11	117.5	18.5	18.0	19.0	19.0	16.5	OK
27	11	124.5	18.0	19.5	18.5	17.5	18.5	OK
60	11	120.0	18.5	18.0	17.5	17.0	16.0	OK
62	11	130.5	16.5	18.5	19.0	19.0	19.0	OK
25	12	144.5	18.5	18.0	17.5	17.0	19.5	OK
26	12	146.5	18.0	17.0	16.5	18.5	16.5	OK
27	12	147.0	18.0	18.0	17.0	17.0	18.0	OK
28	12	140.5	18.0	16.0	19.5	18.5	16.5	OK
29	12	112.0	18.5	18.5	17.5	17.0	18.0	OK
30	12	117.5	18.5	18.0	19.0	19.0	16.5	OK
31	12	124.5	18.0	19.5	18.5	17.5	18.5	OK
32	12	120.0	18.5	18.0	17.5	17.0	16.0	OK
33	12	130.5	16.5	18.5	19.0	19.0	19.0	OK
34	12	138.0	18.5	16.0	17.5	17.5	16.0	OK
35	12	110.5	17.5	18.5	16.5	17.0	19.5	OK
36	12	98.5	18.5	18.0	17.0	19.0	17.5	OK
37	12	106.5	16.5	17.5	18.5	17.5	16.0	OK
38	12	142.0	18.5	18.0	18.5	17.0	17.5	OK
25	13	147.0	18.0	18.0	17.0	17.0	18.0	OK
26	13	140.5	18.0	16.0	19.5	18.5	16.5	OK
27	13	144.5	18.5	18.0	17.5	17.0	19.5	OK
28	13	146.5	18.0	17.0	16.5	18.5	16.5	OK
33	13	130.5	16.5	18.5	19.0	19.0	19.0	OK
34	13	132.0	18.5	16.0	17.5	17.5	16.0	OK
37	13	106.5	16.5	17.5	18.5	17.5	16.0	OK
38	13	112.0	18.5	18.0	18.5	17.0	17.5	OK
\.

COPY dyscypliny_medale_zes FROM stdin;
7	4	1
7	8	2
7	2	3
\.

COPY dyscypliny_medalisci_ind FROM stdin;
2	82	1
2	81	2
2	80	3
\.

COPY sedziowie_dyscypliny FROM stdin;
1	9
1	10
1	11
1	12
2	9
2	10
2	11
2	12
3	9
3	10
3	11
3	12
4	9
4	10
4	11
4	12
5	9
5	10
5	11
5	12
6	9
6	10
6	11
6	12
7	9
7	10
7	11
7	12
8	7
8	8
9	7
9	8
10	7
10	8
11	7
11	8
12	7
12	8
13	1
13	2
13	3
13	4
14	1
14	2
14	3
14	4
15	1
15	2
15	3
15	4
15	5
15	6
16	1
16	2
16	3
16	4
16	5
16	6
17	1
17	2
17	3
17	4
18	13
18	14
18	15
18	16
18	17
18	18
18	19
19	13
19	14
19	15
19	16
19	17
19	18
19	19
20	13
20	14
20	15
20	16
20	17
20	18
20	19
21	13
21	14
21	15
21	16
21	17
21	18
21	19
\.

COPY sedziowie_rozgrywki FROM stdin;
1	8
1	9
2	10
2	11
3	12
3	8
4	9
4	10
5	11
5	12
8	8
8	9
9	10
9	11
6	12
6	13
6	14
7	15
7	16
7	17
10	1
10	2
10	3
10	4
10	5
11	1
11	2
11	3
11	4
11	5
12	6
12	7
12	5
12	4
12	3
13	6
13	7
13	3
13	4
13	5
\.


COPY biegi_narciarskie FROM stdin WITH null AS 'null';
41	14	65.45	OK
42	14	68.85	OK
39	14	63.45	OK
40	14	62.45	OK
47	14	61.75	OK
48	14	60.45	OK
51	14	70.15	OK
52	14	65.45	OK
55	14	null	DNS
56	14	null	DNS
39	15	65.45	OK
40	15	60.45	OK
41	15	65.45	OK
42	15	71.30	OK
47	15	62.55	OK
48	15	63.65	OK
43	16	54.45	OK
44	16	50.25	OK
45	16	52.45	OK
46	16	53.85	OK
49	16	76.45	OK
50	16	61.95	OK
53	16	58.45	OK
54	16	50.15	OK
57	16	null	DNF
58	16	null	DNF
43	17	49.45	OK
44	17	50.25	OK
45	17	51.45	OK
46	17	53.85	OK
53	17	58.45	OK
54	17	50.95	OK
43	18	54.45	OK
44	18	50.25	OK
45	18	52.45	OK
46	18	53.85	OK
49	18	76.45	OK
50	18	61.95	OK
53	18	58.45	OK
54	18	50.15	OK
57	18	null	DSQ
58	18	null	DNF
\.

COMMIT;











CREATE VIEW multimedalisci(imie, nazwisko, panstwo, kategoria, zloto, srebro, braz, suma) AS(

	WITH zesp(id, zloto, srebro, braz) AS
	(SELECT za.id, 
		COUNT(CASE WHEN medal = 1 THEN 1 ELSE NULL END) AS zloto, 
		COUNT(CASE WHEN medal = 2 THEN 2 ELSE NULL END) AS srebro,
		COUNT(CASE WHEN medal = 3 THEN 3 ELSE NULL END) AS braz  
	FROM zawodnicy za JOIN zawodnicy_druzyny zadr ON za.id = zadr.id_zawodnika
	JOIN druzyny dr ON dr.id = zadr.id_druzyny 
	JOIN dyscypliny_medale_zes dmz ON dmz.id_druzyny = dr.id
	GROUP BY za.id),


	ind(id, zloto, srebro, braz) AS
	(SELECT za.id, 
		COUNT(CASE WHEN medal = 1 THEN 1 ELSE NULL END) AS zloto, 
		COUNT(CASE WHEN medal = 2 THEN 2 ELSE NULL END) AS srebro,
		COUNT(CASE WHEN medal = 3 THEN 3 ELSE NULL END) AS braz  
	FROM zawodnicy za JOIN dyscypliny_medalisci_ind dmi ON dmi.id_zawodnika = za.id
	GROUP BY za.id),

	
	zaw_kategorie(id, id_kat, rownumber) AS
	(SELECT zd.id_zawodnika, ka.id, row_number() over (partition by id_zawodnika)
	FROM zawodnicy_dyscypliny zd JOIN dyscypliny dy ON dy.id = zd.id_dyscypliny
	JOIN kategorie ka ON ka.id = dy.id_kategorii)


	SELECT za.imie, za.nazwisko, pa.nazwa AS kraj, ka.nazwa AS kateg,
			COALESCE(zesp.zloto , 0) + COALESCE(ind.zloto , 0) AS zloto, 
			COALESCE(zesp.srebro , 0) + COALESCE(ind.srebro , 0) AS srebro, 
			COALESCE(zesp.braz , 0) + COALESCE(ind.braz , 0) AS braz,
			COALESCE(zesp.zloto , 0) + COALESCE(ind.zloto , 0) + 
				COALESCE(zesp.srebro , 0) + COALESCE(ind.srebro , 0) + 
				COALESCE(zesp.braz , 0) + COALESCE(ind.braz , 0) AS suma
	FROM zawodnicy za JOIN panstwa pa ON pa.id = za.id_panstwa
	LEFT JOIN zesp ON zesp.id = za.id
	LEFT JOIN ind ON ind.id = za.id
	JOIN zaw_kategorie zk ON zk.id = za.id
	JOIN kategorie ka ON ka.id = zk.id_kat
	WHERE zk.rownumber = 1
	ORDER BY 5 DESC, 6 DESC, 7 DESC
);



CREATE VIEW tabela_medalowa(panstwo, zloto, srebro, braz, suma) AS(

	WITH zesp(id, zloto, srebro, braz) AS
	(SELECT pa.id, 
		COUNT(CASE WHEN medal = 1 THEN 1 ELSE NULL END) AS zloto, 
		COUNT(CASE WHEN medal = 2 THEN 2 ELSE NULL END) AS srebro,
		COUNT(CASE WHEN medal = 3 THEN 3 ELSE NULL END) AS braz  
	FROM panstwa pa JOIN druzyny dr ON pa.id = dr.id_kraju 
	JOIN dyscypliny_medale_zes dmz ON dmz.id_druzyny = dr.id
	GROUP BY pa.id),

	ind(id, zloto, srebro, braz) AS
	(SELECT pa.id, 
		COUNT(CASE WHEN medal = 1 THEN 1 ELSE NULL END) AS zloto, 
		COUNT(CASE WHEN medal = 2 THEN 2 ELSE NULL END) AS srebro,
		COUNT(CASE WHEN medal = 3 THEN 3 ELSE NULL END) AS braz  
	FROM panstwa pa JOIN zawodnicy za ON pa.id = za.id_panstwa 
	JOIN dyscypliny_medalisci_ind dmi ON dmi.id_zawodnika = za.id
	GROUP BY pa.id)

	SELECT pa.nazwa, COALESCE(zesp.zloto , 0) + COALESCE(ind.zloto , 0) AS zloto, 
			COALESCE(zesp.srebro , 0) + COALESCE(ind.srebro , 0) AS srebro, 
			COALESCE(zesp.braz , 0) + COALESCE(ind.braz , 0) AS braz,
			COALESCE(zesp.zloto , 0) + COALESCE(ind.zloto , 0) + 
				COALESCE(zesp.srebro , 0) + COALESCE(ind.srebro , 0) + 
				COALESCE(zesp.braz , 0) + COALESCE(ind.braz , 0) AS suma
	FROM panstwa pa LEFT JOIN zesp ON zesp.id = pa.id
	LEFT JOIN ind ON ind.id = pa.id
	ORDER BY 2 DESC, 3 DESC, 4 DESC
);


CREATE VIEW wyniki_hokeja(mecz, faza, plec, druzyna1, druzyna2, wynik)
AS(

	WITH punkty(mecz, druzyna, gole, samoboje) AS
	(SELECT ho.id_rozgrywki, dr.id, SUM(ho.bramki), SUM(ho.bramki_samobojcze)
	FROM hokej ho JOIN zawodnicy za ON ho.id_zawodnika = za.id
	JOIN zawodnicy_druzyny zd ON zd.id_zawodnika = za.id
	JOIN druzyny dr ON dr.id = zd.id_druzyny
	JOIN dyscypliny dy ON dr.id_dyscypliny = dy.id
	WHERE dy.nazwa LIKE '%turniej%'
	GROUP BY ho.id_rozgrywki, dr.id
	ORDER BY 1),

	mecze(mecz, dr1, gole1, samoboje1, dr2, gole2, samoboje2) AS
	(SELECT p1.mecz, p1.druzyna, p1.gole, p1.samoboje, p2.druzyna, p2.gole, p2.samoboje
	FROM punkty p1 JOIN punkty p2 ON p1.mecz = p2.mecz
	WHERE p1.druzyna != p2.druzyna),

	wyniki(mecz, dr1, dr2, wynik1, wynik2, rownumber) AS
	(SELECT m.mecz, m.dr1, m.dr2, m.gole1 + m.samoboje2, m.gole2 + m.samoboje1,
	row_number() over (partition by m.mecz)
	FROM mecze m),

	wyniki_dist(mecz, dr1, dr2, wynik1, wynik2) AS
	(SELECT w.mecz, w.dr1, w.dr2, w.wynik1, w.wynik2 
	FROM wyniki w WHERE w.rownumber = 1)
	
	SELECT wd.mecz, fa.nazwa, CASE WHEN dy.nazwa LIKE '%kobiet%' THEN 'kobiet' ELSE 'mezczyzn' END AS plec,
		pa1.nazwa AS p1, pa2.nazwa AS p2, wd.wynik1 || ' : ' || wd.wynik2
	FROM wyniki_dist wd JOIN rozgrywki ro ON ro.id_rozgrywki = wd.mecz
	JOIN fazy fa ON fa.id = ro.id_fazy
	JOIN dyscypliny dy ON dy.id = ro.id_dyscypliny
	JOIN druzyny d1 ON wd.dr1 = d1.id
	JOIN druzyny d2 ON wd.dr2 = d2.id
	JOIN panstwa pa1 ON pa1.id = d1.id_kraju
	JOIN panstwa pa2 ON pa2.id = d2.id_kraju
	ORDER BY plec, CASE WHEN fa.nazwa LIKE 'final' THEN 0 WHEN fa.nazwa LIKE '%mecz%3%' THEN 1 WHEN fa.nazwa LIKE '%polfinal%' THEN 2 ELSE 3 END
);

CREATE VIEW wyniki_lyzwiarstwo
(konkurencja, id_rozgrywki, faza, id_zawodnika, imie, nazwisko, panstwo, czas, status)
AS
(SELECT dy.nazwa, ro.id_rozgrywki, fa.nazwa, ly.id_zawodnika, 
	za.imie, za.nazwisko, pa.nazwa, ly.czas, ly.status
FROM rozgrywki ro JOIN fazy fa ON fa.id = ro.id_fazy
JOIN dyscypliny dy ON dy.id = ro.id_dyscypliny
JOIN lyzwiarstwo_szybkie ly ON ly.id_rozgrywki = ro.id_rozgrywki
JOIN zawodnicy za ON ly.id_zawodnika = za.id
JOIN panstwa pa ON pa.id = za.id_panstwa
ORDER BY dy.nazwa, fa.id, ly.id_rozgrywki, CASE WHEN ly.status = 'OK' THEN 1 ELSE 2 END, ly.czas);

CREATE OR REPLACE FUNCTION dru_wyniki_bezsk_f(x integer) 
RETURNS TABLE(	dyscyplina integer, id_druzyny integer, medal integer, suma numeric ) AS $$
DECLARE
	suma1 numeric;
	suma2 numeric;
	suma3 numeric;
	liczba1 numeric;
	liczba2 numeric;
	liczba3 numeric;
	r record;
BEGIN
	IF x NOT IN (5,6,15,16,17,19) THEN
				RAISE EXCEPTION 'Zla dyscyplina';
	END IF;
	suma1=-42;
	suma2=-42;
	suma3=-42;
	liczba1 = 0;
	liczba2 = 0;
	liczba3 = 0;
	FOR r IN SELECT  DISTINCT ws.czas FROM wyniki_dru_bezsk(x) ws ORDER BY 1
	LOOP
		IF (suma1 = -42) THEN suma1 = r.czas;
		ELSIF (suma2 = -42) THEN suma2 = r.czas;
		ELSIF (suma3 = -42) THEN suma3 = r.czas;
		END IF;
	END LOOP;
	FOR r IN SELECT ws.* FROM wyniki_dru_bezsk(x) ws
	LOOP
		IF (r.czas = suma1) THEN liczba1 = liczba1+1; END IF;
		IF (r.czas = suma2) THEN liczba2 = liczba2+1; END IF;
		IF (r.czas = suma3) THEN liczba3 = liczba3+1; END IF;
	END LOOP;
	IF(liczba1>2) THEN
		suma3 = -42;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba1=2) THEN
		suma3 = suma2;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba2>1) THEN
		suma3=-42;
	END IF;
	RETURN QUERY 
	SELECT x, wsd.id_druzyny, CASE WHEN wsd.czas = suma1 THEN 1
					 WHEN wsd.czas = suma2 THEN 2
					 WHEN wsd.czas = suma3 THEN 3
				END,
				wsd.czas
	FROM wyniki_dru_bezsk(x) wsd;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION odswiez_medale(x integer) RETURNS void AS $$
BEGIN
	DELETE FROM dyscypliny_medale_zes WHERE id_dyscypliny = x;
	DELETE FROM  dyscypliny_medalisci_ind WHERE id_dyscypliny = x;
		--ind bez nart
		IF x IN (1,2,3,4,13,14,18) THEN
		INSERT INTO  dyscypliny_medalisci_ind
			SELECT x, w.id_zawodnika, w.medal
			FROM wyniki_ind(x) w
			WHERE w.medal IS NOT NULL;
		ELSIF x IN (5,6,15,16,17,19) THEN 
			INSERT INTO  dyscypliny_medale_zes
			SELECT x, si.id_druzyny, si.medal
			FROM dru_wyniki_bezsk_f(x) si
			WHERE si.medal IS NOT NULL;
		--skoki_narciarskie ind    7 seria 1    8 seria 2
		ELSIF x IN (9,10,11) THEN
			INSERT INTO  dyscypliny_medalisci_ind
			SELECT x, si.id_zawodnika, si.medal
			FROM skoki_ind_wyniki_f(x) si
			WHERE si.medal IS NOT NULL;
		--zespolowe
		ELSIF x IN (12) THEN
			INSERT INTO  dyscypliny_medale_zes
			SELECT x, si.id_druzyny, si.medal
			FROM skoki_dru_wyniki_f(x) si
			WHERE si.medal IS NOT NULL;
	END IF;
	RETURN;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION skoki_dru_wyniki_f(x integer) 
RETURNS TABLE(	dyscyplina integer, id_druzyny integer, medal integer, suma numeric(5,1) ) AS $$
DECLARE
	suma1 numeric(5,1);
	suma2 numeric(5,1);
	suma3 numeric(5,1);
	liczba1 numeric(5,1);
	liczba2 numeric(5,1);
	liczba3 numeric(5,1);
	r record;
BEGIN
	IF x NOT IN (12) THEN
				RAISE EXCEPTION 'Zla dyscyplina';
	END IF;
	suma1=-42;
	suma2=-42;
	suma3=-42;
	liczba1 = 0;
	liczba2 = 0;
	liczba3 = 0;
	FOR r IN SELECT  DISTINCT ws.punkty FROM wyniki_skoki_druzynowe(x) ws ORDER BY 1 DESC
	LOOP
		IF (suma1 = -42) THEN suma1 = r.punkty;
		ELSIF (suma2 = -42) THEN suma2 = r.punkty;
		ELSIF (suma3 = -42) THEN suma3 = r.punkty;
		END IF;
	END LOOP;
	FOR r IN SELECT ws.* FROM wyniki_skoki_druzynowe(x) ws
	LOOP
		IF (r.punkty = suma1) THEN liczba1 = liczba1+1; END IF;
		IF (r.punkty = suma2) THEN liczba2 = liczba2+1; END IF;
		IF (r.punkty = suma3) THEN liczba3 = liczba3+1; END IF;
	END LOOP;
	IF(liczba1>2) THEN
		suma3 = -42;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba1=2) THEN
		suma3 = suma2;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba2>1) THEN
		suma3=-42;
	END IF;
	RETURN QUERY 
	SELECT x, wsd.id_druzyny, CASE WHEN wsd.punkty = suma1 THEN 1
					 WHEN wsd.punkty = suma2 THEN 2
					 WHEN wsd.punkty = suma3 THEN 3
				END,
				wsd.punkty
	FROM wyniki_skoki_druzynowe(x) wsd;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION skoki_ind_wyniki_f(x integer) 
RETURNS TABLE(	dyscyplina integer, id_zawodnika integer, medal integer, suma numeric(4,1)) AS $$
DECLARE
	suma1 numeric(4,1);
	suma2 numeric(4,1);
	suma3 numeric(4,1);
	liczba1 numeric(4,1);
	liczba2 numeric(4,1);
	liczba3 numeric(4,1);
	r record;
BEGIN
	IF x NOT IN (9,10,11) THEN
				RAISE EXCEPTION 'Zla dyscyplina';
	END IF;
	suma1=-42;
	suma2=-42;
	suma3=-42;
	liczba1 = 0;
	liczba2 = 0;
	liczba3 = 0;
	FOR r IN SELECT B.suma AS s, row_number() over(order by B.suma DESC) AS rn
	FROM (
	SELECT A.suma AS suma FROM 
		(SELECT DISTINCT s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
											- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
											- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
											+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
											+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) AS suma
		FROM skoki_narciarskie s1
		JOIN skoki_narciarskie s2 ON s1.id_zawodnika = s2.id_zawodnika
		WHERE s1.status = 'OK' AND s2.status = 'OK' 
		AND s1.id_rozgrywki IN (SELECT id_rozgrywki FROM rozgrywki WHERE id_fazy = 7 AND id_dyscypliny = x)
		AND s2.id_rozgrywki IN (SELECT id_rozgrywki	FROM rozgrywki WHERE id_fazy = 8 AND id_dyscypliny = x)
		ORDER BY suma DESC) AS A
		) B
	LOOP
		IF (r.rn = 1) THEN suma1 = r.s; END IF;
		IF (r.rn = 2) THEN suma2 = r.s; END IF;
		IF (r.rn = 3) THEN suma3 = r.s; END IF;
	END LOOP;
	FOR r IN SELECT B.suma AS s, row_number() over(order by B.suma DESC) AS rn
	FROM (
	SELECT A.suma AS suma FROM 
		(SELECT s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
											- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
											- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
											+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
											+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) AS suma
		FROM skoki_narciarskie s1
		JOIN skoki_narciarskie s2 ON s1.id_zawodnika = s2.id_zawodnika
		WHERE s1.status = 'OK' AND s2.status = 'OK' 
		AND s1.id_rozgrywki IN (SELECT id_rozgrywki FROM rozgrywki WHERE id_fazy = 7 AND id_dyscypliny = x)
		AND s2.id_rozgrywki IN (SELECT id_rozgrywki	FROM rozgrywki WHERE id_fazy = 8 AND id_dyscypliny = x)
		ORDER BY suma DESC) AS A
		) B
	LOOP
		IF (r.s = suma1) THEN liczba1 = liczba1+1; END IF;
		IF (r.s = suma2) THEN liczba2 = liczba2+1; END IF;
		IF (r.s = suma3) THEN liczba3 = liczba3+3; END IF;
	END LOOP;
	IF(liczba1>2) THEN
		suma3 = -42;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba1=2) THEN
		suma3 = suma2;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba2>1) THEN
		suma3=-42;
	END IF;
	RETURN QUERY 
	SELECT x, s1.id_zawodnika,
				CASE WHEN s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) = suma1 THEN 1
					 WHEN s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) = suma2 THEN 2
					 WHEN s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) = suma3 THEN 3
				END,
				s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) AS suma
			FROM skoki_narciarskie s1
				JOIN skoki_narciarskie s2 ON s1.id_zawodnika = s2.id_zawodnika
			WHERE s1.status = 'OK' AND s2.status = 'OK' 
			AND s1.id_rozgrywki IN (SELECT id_rozgrywki FROM rozgrywki WHERE id_fazy = 7 AND id_dyscypliny = x)
			AND s2.id_rozgrywki IN (SELECT id_rozgrywki	FROM rozgrywki WHERE id_fazy = 8 AND id_dyscypliny = x);
END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS tabela_medalowa_nadkategoria(TEXT);
CREATE OR REPLACE FUNCTION tabela_medalowa_nadkategoria(TEXT)
    RETURNS TABLE (panstwo int, zloto int, srebro int, braz int, suma int) AS $$

    SELECT panstwo, COALESCE(A.zloto,0)+COALESCE(B.zloto,0),
            COALESCE(A.srebro,0)+COALESCE(B.srebro,0),
            COALESCE(A.braz,0)+COALESCE(B.braz,0),
            COALESCE(A.suma,0)+COALESCE(B.suma,0)
	FROM (SELECT * FROM tabela_medalowa_nadkategoria_ind($1)) A
            FULL OUTER JOIN (SELECT * FROM tabela_medalowa_nadkategoria_zes($1)) B USING(panstwo)
	ORDER BY 2 DESC, 3 DESC, 4 DESC
$$ LANGUAGE SQL;


DROP FUNCTION IF EXISTS tabela_medalowa_nadkategoria_ind(TEXT);
CREATE OR REPLACE FUNCTION tabela_medalowa_nadkategoria_ind(TEXT)
    RETURNS TABLE (panstwo int, zloto int, srebro int, braz int, suma int) AS $$

    SELECT pa.id,
		COUNT(CASE WHEN medal = 1 THEN 1 ELSE NULL END)::int,
		COUNT(CASE WHEN medal = 2 THEN 2 ELSE NULL END)::int,
		COUNT(CASE WHEN medal = 3 THEN 3 ELSE NULL END)::int,
		COUNT(*)::int
	FROM panstwa pa JOIN zawodnicy za ON pa.id = za.id_panstwa
	JOIN dyscypliny_medalisci_ind dmi ON dmi.id_zawodnika = za.id
	WHERE dmi.id_dyscypliny  = ANY(SELECT dys.id FROM kategorie kat
                                    JOIN dyscypliny dys ON (dys.id_kategorii = kat.id)
                                    WHERE kat.nadkategoria = $1)
	GROUP BY pa.id ORDER BY 2 DESC, 3 DESC, 4 DESC
$$ LANGUAGE SQL;

DROP FUNCTION IF EXISTS tabela_medalowa_nadkategoria_zes(TEXT);
CREATE OR REPLACE FUNCTION tabela_medalowa_nadkategoria_zes(TEXT)
    RETURNS TABLE (panstwo int, zloto int, srebro int, braz int, suma int) AS $$

    SELECT pa.id,
		COUNT(CASE WHEN medal = 1 THEN 1 ELSE NULL END)::int,
		COUNT(CASE WHEN medal = 2 THEN 2 ELSE NULL END)::int,
		COUNT(CASE WHEN medal = 3 THEN 3 ELSE NULL END)::int,
		COUNT(*)::int
	FROM panstwa pa JOIN druzyny dr ON pa.id = dr.id_kraju
	JOIN dyscypliny_medale_zes dmz ON dmz.id_druzyny = dr.id
	WHERE dmz.id_dyscypliny  = ANY(SELECT dys.id FROM kategorie kat
                                    JOIN dyscypliny dys ON (dys.id_kategorii = kat.id)
                                    WHERE kat.nadkategoria = $1)
	GROUP BY pa.id ORDER BY 2 DESC, 3 DESC, 4 DESC
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION wyniki_skoki_seria(INT) RETURNS TABLE (id_zawodnika INT, punkty NUMERIC(5,1)) AS $$
SELECT id_zawodnika,
    CASE WHEN status='OK' THEN odleglosc+sedzia1+sedzia2+sedzia3+sedzia4+sedzia5 -
                                GREATEST(sedzia1, sedzia2, sedzia3, sedzia4, sedzia5) +
                                GREATEST(-sedzia1, -sedzia2, -sedzia3, -sedzia4, -sedzia5)
                         ELSE 0 END AS punkty
                         FROM skoki_narciarskie WHERE id_rozgrywki = $1 ORDER BY 2 DESC;
$$
LANGUAGE SQL;

CREATE OR REPLACE FUNCTION wyniki_dru_bezsk(INT) RETURNS TABLE (id_druzyny INT, czas NUMERIC) AS $$
BEGIN
IF($1 NOT IN (5,6,15,16,17,19))
	THEN RAISE EXCEPTION 'Zla dyscyplina';
END IF;
RETURN QUERY SELECT a.id, SUM(C.czas)
        FROM (SELECT id FROM druzyny WHERE id_dyscypliny = $1) AS A
            JOIN zawodnicy_druzyny B ON (B.id_druzyny = id)
            JOIN wyniki_ind_bezwyjatku($1) C ON (B.id_zawodnika = C.id_zawodnika)
        GROUP BY a.id
        ORDER BY 2;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wyniki_ind(x integer) 
RETURNS TABLE(dyscyplina varchar(50), id_zawodnika integer, czas numeric, medal integer) AS $$
DECLARE
 best1 NUMERIC;
 best2 NUMERIC;
 best3 NUMERIC;
 zlota INTEGER;
 srebra INTEGER;
 brazy INTEGER;
	
BEGIN
IF(x NOT IN (1,2,3,4,13,14,18))
	THEN RAISE EXCEPTION 'Zla dyscyplina';
END IF;

IF((SELECT r.id_rozgrywki FROM dyscypliny d LEFT JOIN rozgrywki r ON d.id = r.id_dyscypliny WHERE r.id_dyscypliny = x AND id_fazy = 1) IS NULL)
	THEN RAISE EXCEPTION 'Final jeszcze sie nie odbyl';
END IF;


IF(x IN (1,2,3,4)) THEN 

	best1 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best2 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best3 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best2 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	zlota = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best1 AND ls.status = 'OK');

	srebra = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best2 AND ls.status = 'OK');

	brazy = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best3 AND ls.status = 'OK');

	IF(zlota >= 3) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(zlota = 2) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 3 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(srebra > 1) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;
		
	ELSE RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 WHEN(ls.czas = best3) THEN 3 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	END IF;	

ELSE

	best1 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best2 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best3 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best2 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	zlota = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best1 AND ls.status = 'OK');

	srebra = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best2 AND ls.status = 'OK');

	brazy = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best3 AND ls.status = 'OK');

	IF(zlota >= 3) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(zlota = 2) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 3 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(srebra > 1) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSE RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 WHEN(ls.czas = best3) THEN 3 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	END IF;	

END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION wyniki_ind_bezwyjatku(x integer) 
RETURNS TABLE(dyscyplina varchar(50), id_zawodnika integer, czas numeric, medal integer) AS $$
DECLARE
 best1 NUMERIC;
 best2 NUMERIC;
 best3 NUMERIC;
 zlota INTEGER;
 srebra INTEGER;
 brazy INTEGER;
	
BEGIN
IF((SELECT r.id_rozgrywki FROM dyscypliny d LEFT JOIN rozgrywki r ON d.id = r.id_dyscypliny WHERE r.id_dyscypliny = x AND id_fazy = 1) IS NULL)
	THEN RAISE EXCEPTION 'Final jeszcze sie nie odbyl';
END IF;


IF(x IN (1,2,3,4)) THEN 

	best1 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best2 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best3 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best2 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	zlota = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best1 AND ls.status = 'OK');

	srebra = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best2 AND ls.status = 'OK');

	brazy = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best3 AND ls.status = 'OK');

	IF(zlota >= 3) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(zlota = 2) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 3 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(srebra > 1) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;
		
	ELSE RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 WHEN(ls.czas = best3) THEN 3 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	END IF;	

ELSE

	best1 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best2 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best3 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best2 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	zlota = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best1 AND ls.status = 'OK');

	srebra = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best2 AND ls.status = 'OK');

	brazy = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best3 AND ls.status = 'OK');

	IF(zlota >= 3) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(zlota = 2) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 3 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(srebra > 1) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSE RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 WHEN(ls.czas = best3) THEN 3 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	END IF;	

END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION wyniki_skoki(INT) RETURNS TABLE (id_zawodnika INT, punkty NUMERIC(5,1)) AS $$
DECLARE
	Iseria INT;
	IIseria INT;
BEGIN
	SELECT INTO Iseria id_rozgrywki FROM rozgrywki JOIN fazy ON (fazy.id = id_fazy) WHERE id_dyscypliny = $1 AND fazy.nazwa = 'seria 1';
	SELECT INTO IIseria id_rozgrywki FROM rozgrywki JOIN fazy ON (fazy.id = id_fazy) WHERE id_dyscypliny = $1 AND fazy.nazwa = 'seria 2';
	RETURN QUERY (SELECT A.id_zawodnika, COALESCE(A.punkty, 0) + COALESCE(B.punkty, 0)
		FROM wyniki_skoki_seria(Iseria) A LEFT OUTER JOIN wyniki_skoki_seria(IIseria) B USING(id_zawodnika) ORDER BY 2 DESC);
END;
$$
LANGUAGE plpgSQL;


CREATE OR REPLACE FUNCTION wyniki_skoki_druzynowe(INT) RETURNS TABLE (id_druzyny INT, punkty NUMERIC(5,1)) AS $$
SELECT a.id, SUM(punkty)
        FROM (SELECT id FROM druzyny WHERE id_dyscypliny = $1) AS A
            JOIN zawodnicy_druzyny B ON (B.id_druzyny = id)
            JOIN wyniki_skoki($1) C ON (B.id_zawodnika = C.id_zawodnika)
        GROUP BY a.id
        ORDER BY 2 desc
$$
LANGUAGE SQL;


 CREATE OR REPLACE FUNCTION doping_change() RETURNS trigger AS $$
DECLARE
	r record;
BEGIN
		IF( NEW.wynik )
		THEN
			UPDATE biegi_narciarskie
			SET status='DSQ'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='OK';
			UPDATE skoki_narciarskie
			SET status='DSQ'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='OK';
			UPDATE lyzwiarstwo_szybkie
			SET status='DSQ'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='OK';
		ELSE
			UPDATE biegi_narciarskie
			SET status='OK'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='DSQ';
			UPDATE skoki_narciarskie
			SET status='OK'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='DSQ';
			UPDATE lyzwiarstwo_szybkie
			SET status='OK'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='DSQ';
		END IF;
		FOR r IN SELECT * FROM zawodnicy_dyscypliny zawdy
		WHERE zawdy.id_zawodnika = NEW.id_zawodnika
		LOOP
			PERFORM odswiez_medale(r.id_dyscypliny);
		END LOOP;
	 RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER doping_change AFTER UPDATE OR INSERT ON doping
FOR EACH ROW EXECUTE PROCEDURE doping_change();


CREATE OR REPLACE FUNCTION sedziowie_delete_check() RETURNS trigger AS $sedziowie_delete_check$
DECLARE
	zastepstwo integer;
	r record;
	u record;
BEGIN
	 FOR r IN SELECT * FROM rozgrywki roz1 
		JOIN sedziowie_rozgrywki sr1 ON roz1.id_rozgrywki = sr1.id_rozgrywki 
		WHERE sr1.id_sedziego = OLD.id 
	 LOOP
		zastepstwo=-1;
		FOR u IN SELECT * FROM sedziowie s 
		JOIN sedziowie_dyscypliny sd1 ON s.id = sd1.id_sedziego 
		WHERE sd1.id_dyscypliny=r.id_dyscypliny AND s.id != OLD.id
		LOOP
			IF( (SELECT COALESCE(COUNT(*),0) FROM rozgrywki roz2 
			JOIN sedziowie_rozgrywki sr2 ON roz2.id_rozgrywki = sr2.id_rozgrywki 
			WHERE sr2.id_sedziego=u.id
			AND (roz2.data_rozgrywki > r.data_rozgrywki + interval '5 hours' 
			OR roz2.data_rozgrywki < r.data_rozgrywki - interval '5 hours')) = 0 )
			THEN
				zastepstwo = u.id;
				EXIT;
			END IF;
		END LOOP;
		IF zastepstwo=-1
		THEN
			RAISE EXCEPTION 'Nie monżna usunąć sędziego, brak zastępstwa.';
		ELSE
			UPDATE sedziowie_rozgrywki
			SET id_sedziego = zastepstwo
			WHERE id_sedziego=OLD.id AND id_rozgrywki = r.id_rozgrywki;
		END IF;
	 END LOOP; 
	 DELETE FROM sedziowie_dyscypliny WHERE id_sedziego = OLD.id;
	 RETURN OLD;
END;
$sedziowie_delete_check$ LANGUAGE plpgsql;

CREATE TRIGGER sedziowie_delete_check BEFORE DELETE ON sedziowie
FOR EACH ROW EXECUTE PROCEDURE sedziowie_delete_check();


CREATE OR REPLACE FUNCTION skoki_update() RETURNS trigger AS $skoki_update$
BEGIN
    IF (NEW.odleglosc < 0) THEN NEW.odleglosc := 0; END IF;
    IF (NEW.sedzia1) NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia1'; END IF;
    IF (NEW.sedzia2) NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia2'; END IF;
    IF (NEW.sedzia3) NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia3'; END IF;
    IF (NEW.sedzia4) NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia4'; END IF;
    IF (NEW.sedzia5) NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia5'; END IF;
    RETURN NEW;
END;
$skoki_update$ LANGUAGE plpgsql;

CREATE TRIGGER skoki_update BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE skoki_update();



CREATE OR REPLACE FUNCTION sprawdz1() RETURNS trigger AS $sprawdz1$
BEGIN
 IF(NEW.status = 'OK' AND NEW.czas IS NULL) 
	THEN RAISE EXCEPTION 'Czas nie moze byc nullem';

 ELSE RETURN NEW;
END IF; 
END;
$sprawdz1$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sprawdz2() RETURNS trigger AS $sprawdz2$
BEGIN
 IF(NEW.status = 'OK' AND (NEW.odleglosc IS NULL OR NEW.sedzia1 IS NULL 
			OR NEW.sedzia2 IS NULL OR NEW.sedzia3 IS NULL 
			OR NEW.sedzia4 IS NULL OR NEW.sedzi5 IS NULL)) 
	THEN RAISE EXCEPTION 'Punkty nie moga byc nullem';
 ELSE RETURN NEW;
END IF; 
END;
$sprawdz2$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_l BEFORE INSERT OR UPDATE ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE sprawdz1();

CREATE TRIGGER sprawdz_b BEFORE INSERT OR UPDATE ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz1();

CREATE TRIGGER sprawdz_s BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz2();



CREATE OR REPLACE FUNCTION sprawdz_dyscypline() RETURNS trigger AS $sprawdz_dyscypline$
DECLARE
 dysc INTEGER;
 r zawodnicy_dyscypliny%rowtype;
 jest BOOLEAN;
BEGIN
dysc = (SELECT id_dyscypliny FROM rozgrywki WHERE id_rozgrywki = NEW.id_rozgrywki);
jest = false;

FOR r IN (SELECT id_dyscypliny FROM zawodnicy_dyscypliny WHERE id_zawodnika = NEW.id_zawodnika)
LOOP
 IF(r.id_dyscypliny = dysc) THEN jest = TRUE;
 END IF;
END LOOP;

IF(jest = TRUE) THEN RETURN NEW;
ELSE RAISE EXCEPTION 'Zawodnik nie bierze udzialu w tej dyscyplinie';
END IF;
END;
$sprawdz_dyscypline$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_dyscypline_h BEFORE INSERT OR UPDATE ON hokej
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();

CREATE TRIGGER sprawdz_dyscypline_s BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();

CREATE TRIGGER sprawdz_dyscypline_l BEFORE INSERT OR UPDATE ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();

CREATE TRIGGER sprawdz_dyscypline_b BEFORE INSERT OR UPDATE ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();



CREATE OR REPLACE FUNCTION sprawdz_plec_kraj() RETURNS trigger AS $sprawdz_plec_kraj$
DECLARE
 kraj_zawodnika INTEGER;
 kraj_druzyny INTEGER;
 plec_zawodnika CHAR;
 r zawodnicy_druzyny%rowtype;
BEGIN
 kraj_zawodnika = (SELECT id_panstwa FROM zawodnicy WHERE id = NEW.id_zawodnika);
 kraj_druzyny = (SELECT id_kraju FROM druzyny WHERE id = NEW.id_druzyny);
 plec_zawodnika = (SELECT plec FROM zawodnicy WHERE id = NEW.id_zawodnika);

 IF(kraj_zawodnika != kraj_druzyny) THEN RAISE EXCEPTION 'Inne narodowosci';
 END IF;

 FOR r IN (SELECT id_zawodnika FROM zawodnicy_druzyny zd WHERE zd.id_druzyny = NEW.id_druzyny)
  LOOP
     IF(plec_zawodnika != (SELECT plec FROM zawodnicy WHERE id = r.id_zawodnika))
     	THEN RAISE EXCEPTION 'Zla plec';
     END IF;
  END LOOP;

RETURN NEW;
END;
$sprawdz_plec_kraj$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_plec_kraj BEFORE INSERT OR UPDATE ON zawodnicy_druzyny
FOR EACH ROW EXECUTE PROCEDURE sprawdz_plec_kraj();



CREATE OR REPLACE FUNCTION sprawdz_plec() RETURNS trigger AS $sprawdz_plec$
DECLARE
 plec_zawodnika CHAR; 
 plec_dyscypliny CHAR;
BEGIN
 plec_zawodnika = (SELECT plec FROM zawodnicy WHERE id = NEW.id_zawodnika);
 plec_dyscypliny = (SELECT CASE WHEN nazwa LIKE '%kobiet%' THEN 'F' ELSE 'M' END FROM dyscypliny WHERE id = NEW.id_dyscypliny);

 IF(plec_zawodnika != plec_dyscypliny) THEN RAISE EXCEPTION 'Zla plec';
 ELSE RETURN NEW;
 END IF;
END;
$sprawdz_plec$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_plec BEFORE INSERT OR UPDATE ON zawodnicy_dyscypliny
FOR EACH ROW EXECUTE PROCEDURE sprawdz_plec();



CREATE OR REPLACE FUNCTION zabron_hokej() RETURNS trigger AS $zabron_hokej$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'hokej na lodzie')
	THEN RAISE EXCEPTION 'Rozgrywka nie jest z tej dyscypliny';
 ELSE RETURN NEW;
 END IF;

END;
$zabron_hokej$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_hokej BEFORE INSERT OR UPDATE ON hokej
FOR EACH ROW EXECUTE PROCEDURE zabron_hokej();

-----------------------------------------------------


CREATE OR REPLACE FUNCTION zabron_lyzw() RETURNS trigger AS $zabron_lyzw$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'lyzwiarstwo szybkie')
	THEN RAISE EXCEPTION 'Rozgrywka nie jest z tej dyscypliny';
 ELSE RETURN NEW;
 END IF;

END;
$zabron_lyzw$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_h BEFORE INSERT ON hokej
FOR EACH ROW EXECUTE PROCEDURE zabron();

CREATE TRIGGER zabron_l BEFORE INSERT ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE zabron();

CREATE TRIGGER zabron_b BEFORE INSERT ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron();

CREATE TRIGGER zabron_s BEFORE INSERT ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron();

CREATE TRIGGER zabron_sedz BEFORE INSERT OR UPDATE ON sedziowie_rozgrywki
FOR EACH ROW EXECUTE PROCEDURE zabron_sedz();



CREATE OR REPLACE FUNCTION zabron() RETURNS trigger AS $zabron$
DECLARE
 dysc INTEGER;
BEGIN
 dysc = (SELECT r.id_dyscypliny FROM rozgrywki r WHERE r.id_rozgrywki = NEW.id_rozgrywki);
 IF((SELECT d.zakonczona FROM dyscypliny d WHERE d.id = dysc) = TRUE) THEN RAISE EXCEPTION 'Dyscyplina zakonczona';
 ELSE RETURN NEW;
END IF; 
END;
$zabron$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION zabron_skoki() RETURNS trigger AS $zabron_skoki$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'skoki narciarskie')
	THEN RAISE EXCEPTION 'Rozgrywka nie jest z tej dyscypliny';
 ELSE RETURN NEW;
 END IF;

END;
$zabron_skoki$ LANGUAGE plpgsql;

CREATE TRIGGER zabron_skoki BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron_skoki();

CREATE OR REPLACE FUNCTION zabron_sedz() RETURNS trigger AS $zabron_sedz$
DECLARE
 r sedziowie_dyscypliny%rowtype;
 dysc_rozgr INTEGER;
BEGIN
 dysc_rozgr = (SELECT id_dyscypliny FROM rozgrywki WHERE id_rozgrywki = NEW.id_rozgrywki);

 FOR r IN (SELECT id_dyscypliny FROM sedziowie_dyscypliny WHERE id_sedziego = NEW.id_sedziego)
 LOOP
	IF(r.id_dyscypliny = dysc_rozgr) THEN RETURN NEW;
	END IF;
 END LOOP;
 
 CREATE TRIGGER zabron_lyzw BEFORE INSERT OR UPDATE ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE zabron_lyzw();

------------------------------------------------------

CREATE OR REPLACE FUNCTION zabron_biegi() RETURNS trigger AS $zabron_biegi$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'biegi narciarskie')
	THEN RAISE EXCEPTION 'Rozgrywka nie jest z tej dyscypliny';
 ELSE RETURN NEW;
 END IF;

END;
$zabron_biegi$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_biegi BEFORE INSERT OR UPDATE ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron_biegi();

------------------------------------------------------






RAISE EXCEPTION 'Sedzia nie sedziuje tej dyscypliny';
END;
$zabron_sedz$ LANGUAGE plpgsql;
