CREATE OR REPLACE FUNCTION skoki_dru_wyniki_f(x integer) 
RETURNS TABLE(	dyscyplina integer, id_druzyny integer, medal integer, suma numeric(5,1) ) AS $$
DECLARE
	suma1 numeric(4,1);
	suma2 numeric(4,1);
	suma3 numeric(4,1);
	tempsuma numeric(4,1);
	iterator integer;
	r record;
BEGIN
	IF x NOT IN (12) THEN
				RAISE EXCEPTION 'Zla dyscyplina';
	END IF;
	suma1=-42;
	suma2=-42;
	suma3=-42;
	iterator = 1;
	tempsuma=-43;
	FOR r IN SELECT  DISTINCT ws.punkty FROM wyniki_skoki_druzynowe(x) ws ORDER BY 1 DESC
	LOOP
		IF (iterator = 1) THEN suma1 = ws.punkty; iterator=iterator+1; END IF;
		IF (iterator = 2) THEN suma2 = ws.punkty; iterator=iterator+1; END IF;
		IF (iterator = 3) THEN suma3 = ws.punkty; iterator=iterator+1; END IF;
	END LOOP;
	IF (suma1 = suma2) THEN suma2 = -42; END IF;
	IF( suma1 = suma3) THEN suma3 = -42; END IF;
	if( suma2 = suma3) THEN suma3 = -42; END IF;
	RETURN QUERY 
	SELECT x, wsd.id_druzyny, CASE WHEN wsd.punkty = suma1 THEN 1
					 WHEN wsd.punkty = suma2 THEN 2
					 WHEN wsd.punkty = suma3 THEN 3
				END,
				wsd.punkty
	FROM wyniki_skoki_druzynowe(x) wsd WHERE wsd.punkty;
END;
$$ LANGUAGE plpgsql;