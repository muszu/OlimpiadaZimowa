CREATE OR REPLACE FUNCTION wyniki_skoki_druzynowe(INT, INT) RETURNS TABLE (id_druzyny INT, punkty NUMERIC(5,1)) AS $$
SELECT id_druzyny, SUM(punkty)
        FROM (SELECT id_druzyny FROM druzyny WHERE id_dyscypliny = ##skoki narciarskie druzynowe##) A
            JOIN zawodnicy_druzyny USING (id_druzyny) B
            JOIN wyniki_skoki($1, $2) USING (id_zawodnika) C
        GROUP BY (id_druzyny)
        ORDER BY 2 desc
$$
LANGUAGE SQL;
