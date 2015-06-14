CREATE OR REPLACE FUNCTION wyniki_skoki(INT) RETURNS TABLE (id_zawodnika INT, punkty NUMERIC(5,1)) AS $$
DECLARE
	Iseria INT;
	IIseria INT;
BEGIN
	SELECT INTO Iseria id_rozgrywki FROM rozgrywki JOIN fazy USING(id_fazy) WHERE id_dyscypliny = $1 AND fazy.nazwa = "I seria";
	SELECT INTO IIseria id_rozgrywki FROM rozgrywki JOIN fazy USING(id_fazy) WHERE id_dyscypliny = $1 AND fazy.nazwa = "II seria";
	RETURN QUERY (SELECT A.id_zawodnika, COALESCE(A.punkty, 0) + COALESCE(B.punkty, 0)
		FROM wyniki_skoki_seria(Iseria) A LEFT OUTER JOIN wyniki_skoki_seria(IIseria) B USING(id_zawodnika) ORDER BY 2 DESC);
END;
$$
LANGUAGE plpgSQL;
