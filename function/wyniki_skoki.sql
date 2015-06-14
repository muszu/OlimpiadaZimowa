CREATE OR REPLACE FUNCTION wyniki_skoki(INT) RETURNS TABLE (id_zawodnika INT, punkty NUMERIC(5,1)) AS $$
DECLARE
	Iseria INT;
	IIseria INT;
BEGIN
	SELECT INTO Iseria id_rozgrywki FROM rozgrywki JOIN fazy ON (fazy.id = id_fazy) WHERE id_dyscypliny = $1 AND fazy.nazwa = 'seria 1';
	SELECT INTO IIseria id_rozgrywki FROM rozgrywki JOIN fazy ON (fazy.id = id_fazy) WHERE id_dyscypliny = $1 AND fazy.nazwa = 'seria 2';
	RETURN QUERY (SELECT A.id_zawodnika, COALESCE(A.punkty, 0) + COALESCE(B.punkty, 0)
		FROM wyniki_skoki_seria(Iseria) A LEFT OUTER JOIN wyniki_skoki_seria(IIseria) B USING(id_zawodnika) ORDER BY 2 DESC);
END;
$$
LANGUAGE plpgSQL;
