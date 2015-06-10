begin;

COPY fazy (id, nazwa) FROM stdin;
1	final
2	polfinal
3	cwiercfinal
4	eliminacje
5	playoff
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


commit;