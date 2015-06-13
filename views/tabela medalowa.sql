
CREATE VIEW tabela_medalowa AS(

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
