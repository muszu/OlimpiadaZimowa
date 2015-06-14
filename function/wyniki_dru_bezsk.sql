CREATE OR REPLACE FUNCTION wyniki_dru_bezsk(INT) RETURNS TABLE (id_druzyny INT, czas NUMERIC) AS $$
BEGIN
IF($1 NOT IN (5,6,15,16,17,19))
	THEN RAISE EXCEPTION 'Zla dyscyplina';
END IF;
RETURN QUERY SELECT a.id, SUM(C.czas)
        FROM (SELECT id FROM druzyny WHERE id_dyscypliny = $1) AS A
            JOIN zawodnicy_druzyny B ON (B.id_druzyny = id)
            JOIN wyniki_ind_bezwyjatku($1) C ON (B.id_zawodnika = C.id_zawodnika)
        GROUP BY a.id
        ORDER BY 2;
END;
$$
LANGUAGE plpgsql;