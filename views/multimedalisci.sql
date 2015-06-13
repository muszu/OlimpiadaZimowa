
CREATE VIEW multimedalisci AS(

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
