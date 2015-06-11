begin;

COPY fazy FROM stdin;
1	final
2	polfinal
3	cwiercfinal
4	eliminacje
5	playoff
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


COPY obiekty FROM stdin WITH null AS 'null';
1	 Adler-Arena	 tor lyzwiarski	null	 Soczi
2	 Arena lodowa Szajba	 lodowisko	null	 Soczi
3	 Russkije Gorki	 skocznia narciarska	null	 Krasnaja Polana
\.


COPY zawodnicy FROM stdin;
1	 Kamil	 Nowak	 2	M	 1987-12-31
2	 Petr	 Iwanow	 3	M	 1987-12-31
3	 John	 Miller	 4	M	 1988-12-31
4	 Alex	 Thomson	 5	M	 1987-12-31
5	 Michael	 Smith	 6	M	 1983-12-31
6	 Egor	 Schmidt	 7	M	 1982-12-31
7	 Gregor	 Fischer	 8	M	 1987-12-31
8	 Roman	 Kowalski	 9	M	 1981-12-31
9	 Adam	 Neuer	 10	M	 1987-12-31
10	 Daniel	 Hoffman	 11	M	 1957-12-31
11	 Robert	 Becker	 12	M	 1977-12-31
12	 Olivia	 White	 13	F	 1987-12-31
13	 Joanne	 Brown	 14	F	 1993-12-31
14	 Lucia	 Hernandez	 15	F	 1992-12-31
15	 Sofia	 Thomas	 16	F	 1987-12-31
16	 Martha	 Evans	 17	F	 1987-12-31
17	 Anna	 Wojcik	 2	F	 1990-12-31
18	 John	 Miller	 3	M	 1991-12-31
19	 John	 Watson	 4	M	 1987-12-31
20	 Olivia	 Evans	 7	F	 1987-12-31
21	 Ann	 Green	 8	F	 1998-12-31
22	 Karol	 Kowalski	 1	M	 1987-12-31
23	 Matthew	 Black	 3	M	 1994-12-31
24	 Daniel	 Smith	 7	M	 1987-12-31
25	 Kamil	 Nowak	 8	M	 1989-12-31
26	 Mark	 Wilson	 10	M	 1990-12-31
27	 Gregory	 Smith	 12	M	 1987-12-31
28	 Peter	 Schmidt	 13	M	 1988-12-31
29	 Alicia	 Fischer	 14	F	 1985-12-31
30	 Robert	 Jonas	 15	M	 1983-12-31
31	 Alicia	 Fischer	 14	F	 1985-12-31
32	 Francesca	 Thomas	 14	F	 1985-12-31
33	 Marie	 Jonas	 14	F	 1985-12-31
34	 Alice	 Brown	 14	F	 1985-12-31
\.


COPY doping FROM stdin WITH null AS 'null';
1	 2015-06-23	null
15	 2015-06-20	false
8	 2015-06-20	null
9	 2015-06-20	null
5	 2015-06-20	false
1	 2015-06-21	null
4	 2015-06-21	null
3	 2015-06-21	true
2	 2015-06-21	true
10	 2015-06-21	null
\.


COPY kategorie FROM stdin WITH null AS 'null';
1	 biathlon	null
2	 curling	null
3	 hokej na lodzie	null
4	 lyzwiarstwo	null
5	 narciarstwo	null
6	 lyzwiarstwo figurowe	 4
7	 lyzwiarstwo szybkie	 4
8	 short track	 4
9	 biegi narciarskie	 5
10	 kombinacja norweska	 5
11	 narciarstwo alpejskie	 5
12	 narciarstwo dowolne	 5
13	 skoki narciarskie	 5
14	 snowboarding	 5
\.


COPY dyscypliny FROM stdin;
1	 10 000 m mezczyzn	 7
2	 1000 m kobiet	 7
3	 1000 m mezczyzn	 7
4	 500 m kobiet	 7
5	 bieg druzynowy kobiet	 7
6	 bieg druzynowy mezczyzn	 7
7	 turniej kobiet	 5
8	 turniej mezczyzn	 5
9	 skocznia duza mezczyzn	 13
10	 skocznia normalna mezczyzn	 13
11	 skocznia normalna kobiet	 13
12	 konkurs druzynowy mezczyzn	 13
13	 bieg indywidualny kobiet	 9
14	 bieg indywidualny mezczyzn	 9
15	 bieg laczony kobiet	 9
16	 sprint druzynowy kobiet	 9
17	 sprint druzynowy mezczyzn	 9
18	 sprint kobiet	 9
19	 sztafeta mezczyzn	 9
\.


COPY sedziowie_dyscypliny FROM stdin;
1	 2
1	 3
1	 4
1	 5
2	 1
2	 2
2	 5
2	 4
2	 3
3	 7
4	 6
5	 5
6	 7
7	 8
8	 9
9	 10
10	 11
11	 12
12	 13
13	 14
14	 15
15	 16
16	 17
17	 18
18	 18
19	 18
20	 19
21	 19
\.


COPY druzyny FROM stdin;
1	 POL1	  16	 3
2	 POL2	  16	 3
3	 GER1	  16	 2
4	 GER2	  16	 2
5	 NOR1	  16	 10
6	 NOR2	  16	 10
7	 NOR3	  17	 10
8	 NOR4	  17	 10
9	 TUR1	  16	 14
\.

COPY zawodnicy_druzyny FROM stdin;
1	1
1	25
2	23
2	8
\.


commit;