CREATE OR REPLACE FUNCTION wyniki_skoki_druzynowe(INT) RETURNS TABLE (id_druzyny INT, punkty NUMERIC(5,1)) AS $$
SELECT a.id, SUM(punkty)
        FROM (SELECT id FROM druzyny WHERE id_dyscypliny = $1) AS A
            JOIN zawodnicy_druzyny B ON (B.id_druzyny = id)
            JOIN wyniki_skoki($1) C ON (B.id_zawodnika = C.id_zawodnika)
        GROUP BY a.id
        ORDER BY 2 desc
$$
LANGUAGE SQL;
