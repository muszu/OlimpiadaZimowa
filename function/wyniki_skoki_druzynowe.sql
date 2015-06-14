CREATE OR REPLACE FUNCTION wyniki_skoki_druzynowe(INT) RETURNS TABLE (id_druzyny INT, punkty NUMERIC(5,1)) AS $$
SELECT A.id, SUM(punkty)
        FROM (SELECT id FROM druzyny WHERE id_dyscypliny = $1) A
            JOIN zawodnicy_druzyny USING (id_druzyny) B
            JOIN wyniki_skoki($1) USING (id_zawodnika) C
        GROUP BY (id_druzyny)
        ORDER BY 2 desc
$$
LANGUAGE SQL;
