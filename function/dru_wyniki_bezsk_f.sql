CREATE OR REPLACE FUNCTION dru_wyniki_bezsk_f(x integer) 
RETURNS TABLE(	dyscyplina integer, id_druzyny integer, medal integer, suma numeric ) AS $$
DECLARE
	suma1 numeric;
	suma2 numeric;
	suma3 numeric;
	liczba1 numeric;
	liczba2 numeric;
	liczba3 numeric;
	r record;
BEGIN
	IF x NOT IN (5,6,15,16,17,19) THEN
				RAISE EXCEPTION 'Zla dyscyplina';
	END IF;
	suma1=-42;
	suma2=-42;
	suma3=-42;
	liczba1 = 0;
	liczba2 = 0;
	liczba3 = 0;
	FOR r IN SELECT  DISTINCT ws.czas FROM wyniki_dru_bezsk(x) ws ORDER BY 1
	LOOP
		IF (suma1 = -42) THEN suma1 = r.czas;
		ELSIF (suma2 = -42) THEN suma2 = r.czas;
		ELSIF (suma3 = -42) THEN suma3 = r.czas;
		END IF;
	END LOOP;
	FOR r IN SELECT ws.* FROM wyniki_dru_bezsk(x) ws
	LOOP
		IF (r.czas = suma1) THEN liczba1 = liczba1+1; END IF;
		IF (r.czas = suma2) THEN liczba2 = liczba2+1; END IF;
		IF (r.czas = suma3) THEN liczba3 = liczba3+1; END IF;
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
	SELECT x, wsd.id_druzyny, CASE WHEN wsd.czas = suma1 THEN 1
					 WHEN wsd.czas = suma2 THEN 2
					 WHEN wsd.czas = suma3 THEN 3
				END,
				wsd.czas
	FROM wyniki_dru_bezsk(x) wsd;
END;
$$ LANGUAGE plpgsql;