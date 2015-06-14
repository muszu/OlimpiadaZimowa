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
$$ LANGUAGE SQL

