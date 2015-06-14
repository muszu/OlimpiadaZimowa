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
2 	Jacob	Nowak	1	M	1988-08-30
3 	Steven	Nowak	1	M	1988-08-30
4 	Olivia	Kowalska	1	F	1988-08-30
5 	Caroline	Kowalska	1	F	1988-08-30
6 	Martha	Kowalska	1	F	1988-08-30
7 	Michael	Nowak	3	M	1988-08-30
8 	Thomas	Nowak	3	M	1988-08-30
9 	Alex	Nowak	3	M	1988-08-30
10 	Joanne	Kowalska	3	F	1988-08-30
11	Ann	Kowalska	3	F	1988-08-30
12	Dominique	Kowalska	3	F	1988-08-30
13 	John	Nowak	2	M	1988-08-30
14	Jack	Nowak	2	M	1988-08-30
15	Robert	Nowak	2	M	1988-08-30
16	Claire	Kowalska	2	F	1988-08-30
17	Lisa	Kowalska	2	F	1988-08-30
18	Maria	Kowalska	2	F	1988-08-30
19 	John	Nowak	13	M	1988-08-30
20	Robert	Nowak	13	M	1988-08-30
21	Alex	Nowak	13	M	1988-08-30
22	Jane	Kowalska	13	F	1988-08-30
23	Marie	Kowalska	13	F	1988-08-30
24	Caroline	Kowalska	13	F	1988-08-30
25	Carol	Nowak	18	M	1988-08-30
26	John	Nowak	18	M	1988-08-30
27	Gregory	Nowak	18	M	1988-08-30
28	Gregor	Nowak	18	M	1988-08-30
29	Michal	Nowak	7	M	1988-08-30
30	Antoine	Nowak	7	M	1988-08-30
31	Mark	Nowak	7	M	1988-08-30
32	Jack	Nowak	7	M	1988-08-30
33	Chris	Nowak	2	M	1988-08-30
34	Steven	Nowak	2	M	1988-08-30
35	Eric	Nowak	5	M	1988-08-30
36	Robert	Nowak	5	M	1988-08-30
37	Michael	Nowak	10	M	1988-08-30
38	John	Nowak	10	M	1988-08-30
39	Marie	Kowalska	10	F	1988-08-30
40	Olivia	Kowalska	10	F	1988-08-30
41	Allison	Kowalska	10	F	1988-08-30
42	Diane	Kowalska	10	F	1988-08-30
43	Chris	Nowak	10	M	1988-08-30
44	Robert	Nowak	10	M	1988-08-30
45	Bob	Nowak	10	M	1988-08-30
46	Carol	Nowak	10	M	1988-08-30
47	Alicia	Kowalska	18	F	1988-08-30
48	Jane	Kowalska	18	F	1988-08-30
49	Adam	Nowak	18	M	1988-08-30
50	Mark	Nowak	18	M	1988-08-30
51	Marie	Kowalska	3	F	1988-08-30
52	Maria	Kowalska	3	F	1988-08-30
53	John	Nowak	3	M	1988-08-30
54	Eric	Nowak	3	M	1988-08-30
55	Caroline	Kowalska	17	F	1988-08-30
56	Jane	Kowalska	17	F	1988-08-30
57	Adam	Nowak	17	M	1988-08-30
58	Carol	Nowak	17	M	1988-08-30
59	Michael	Nowak	6	M	1988-08-30
60	Eric	Nowak	8	M	1988-08-30
61	Steven	Nowak	9	M	1988-08-30
62	Adam	Nowak	11	M	1988-08-30
63	Marie	Kowalska	1	F	1988-08-30
64	Alice	Kowalska	2	F	1988-08-30
65	Jane	Kowalska	2	F	1988-08-30
66	Allison	Kowalska	3	F	1988-08-30
67	Francesca	Kowalska	4	F	1988-08-30
68	Diane	Kowalska	5	F	1988-08-30
69	Claire	Kowalska	6	F	1988-08-30
70	Alicia	Kowalska	7	F	1988-08-30
71	Jane	Kowalska	8	F	1988-08-30
72	Francesca	Kowalska	9	F	1988-08-30
73	Joanne	Kowalska	10	F	1988-08-30
74	Caroline	Kowalska	11	F	1988-08-30
75	Martha	Kowalska	12	F	1988-08-30
76	Anne	Kowalska	13	F	1988-08-30
77	Alice	Kowalska	13	F	1988-08-30
78	Marie	Kowalska	13	F	1988-08-30
79	Jane	Kowalska	13	F	1988-08-30
80	Jane	Kowalska	15	F	1988-08-30
81	Caroline	Kowalska	16	F	1988-08-30
82	Martha	Kowalska	17	F	1988-08-30
83	Sophie	Kowalska	18	F	1988-08-30
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
81	7	66.36	OK
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
59	11	134.5	18.5	18.0	17.5	17.0	16.5	OK
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

