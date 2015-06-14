CREATE OR REPLACE FUNCTION wyniki_skoki(INT, INT) RETURNS TABLE (id_zawodnika INT, punkty NUMERIC(5,1)) AS $$
SELECT A.id_zawodnika, COALESCE(A.punkty, 0) + COALESCE(B.punkty, 0)
        FROM wyniki_skoki_seria($1) A LEFT OUTER JOIN wyniki_skoki_seria($2) B;
$$
LANGUAGE SQL;
