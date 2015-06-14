CREATE OR REPLACE FUNCTION skoki_dru_wyniki_f(x integer) 
RETURNS TABLE(	dyscyplina integer, id_druzyny integer, medal integer, suma numeric(5,1) ) AS $$
DECLARE
	suma1 numeric(5,1);
	suma2 numeric(5,1);
	suma3 numeric(5,1);
	liczba1 numeric(5,1);
	liczba2 numeric(5,1);
	liczba3 numeric(5,1);
	iterator integer;
	r record;
BEGIN
	IF x NOT IN (12) THEN
				RAISE EXCEPTION 'Zla dyscyplina';
	END IF;
	suma1=-42;
	suma2=-42;
	suma3=-42;
	liczba1 = 0;
	liczba2 = 0;
	liczba3 = 0;
	iterator = 1;
	FOR r IN SELECT  DISTINCT ws.punkty FROM wyniki_skoki_druzynowe(x) ws ORDER BY 1 DESC
	LOOP
		IF (iterator = 1) THEN suma1 = r.punkty; iterator=iterator+1; END IF;
		IF (iterator = 2) THEN suma2 = r.punkty; iterator=iterator+1; END IF;
		IF (iterator = 3) THEN suma3 = r.punkty; iterator=iterator+1; END IF;
	END LOOP;
	FOR r IN SELECT ws.* FROM wyniki_skoki_druzynowe(x) ws
	LOOP
		IF (r.punkty = suma1) THEN liczba1=liczba1+1; END IF;
		IF (r.punkty = suma2) THEN liczba2 = liczba2+1; END IF;
		IF (r.punkty = suma3) THEN liczba3 = liczba3+1; END IF;
	END LOOP;
	IF(liczba1>2) THEN
		suma3 = -42;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba1=2) THEN
		suma3 = suma2;
		suma2 = -42;
		liczba2 = 0;
	END IF;
	IF(liczba2>1) THEN
		suma3=-42;
	END IF;
	RETURN QUERY 
	SELECT x, wsd.id_druzyny, CASE WHEN wsd.punkty = suma1 THEN 1
					 WHEN wsd.punkty = suma2 THEN 2
					 WHEN wsd.punkty = suma3 THEN 3
				END,
				wsd.punkty
	FROM wyniki_skoki_druzynowe(x) wsd;
END;
$$ LANGUAGE plpgsql;