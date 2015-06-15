begin;

COPY fazy (id, nazwa) FROM stdin;
1	final
2	polfinal
3	cwiercfinal
4	eliminacje
5	playoff
6   I seria
7   final B
\.

-- lub WITH null AS '' wtedy wystarczy tabulator

COPY kategorie (id, nazwa, nadkategoria) FROM stdin WITH null AS 'null';
4	lyzwiarstwo	null
5	lyzwiarstwo 500m	1
\.

COPY obiekty (id, nazwa, typ, adres) FROM stdin WITH null AS 'null';
1	basen Andrzeja	basen	ul. Super
2	lodowisko Błarzeja	lodowisko	ul. Na prawde
3	stok A	stok	plac Zillinger 1
4	skocznia wielka	skocznia	ul Wesola 42
5	skocznia mala	skocznia	ul. Andrzeja
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
72	Francesca	Kowalska	9	F   1983-02-28
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


commit;
