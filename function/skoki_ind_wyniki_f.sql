CREATE OR REPLACE FUNCTION skoki_ind_wyniki_f(x integer) 
RETURNS TABLE(	dyscyplina integer, id_zawodnika integer, medal integer, suma numeric(4,1)) AS $$
DECLARE
	suma1 numeric(4,1);
	suma2 numeric(4,1);
	suma3 numeric(4,1);
	r record;
BEGIN
	IF x NOT IN (9,10,11) THEN
				RAISE EXCEPTION 'Zla dyscyplina';
	END IF;
	suma1=-42;
	suma2=-42;
	suma3=-42;
	FOR r IN SELECT B.suma AS s, row_number() over(order by B.suma DESC) AS rn
	FROM (
	SELECT A.suma AS suma FROM 
		(SELECT DISTINCT s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
											- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
											- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
											+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
											+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) AS suma
		FROM skoki_narciarskie s1
		JOIN skoki_narciarskie s2 ON s1.id_zawodnika = s2.id_zawodnika
		WHERE s1.status = 'OK' AND s2.status = 'OK' 
		AND s1.id_rozgrywki IN (SELECT id_rozgrywki FROM rozgrywki WHERE id_fazy = 7 AND id_dyscypliny = x)
		AND s2.id_rozgrywki IN (SELECT id_rozgrywki	FROM rozgrywki WHERE id_fazy = 8 AND id_dyscypliny = x)
		ORDER BY suma DESC) AS A
		) B
	LOOP
		IF (r.rn = 1) THEN suma1 = r.s; END IF;
		IF (r.rn = 2) THEN suma2 = r.s; END IF;
		IF (r.rn = 3) THEN suma3 = r.s; END IF;
	END LOOP;
	RETURN QUERY 
	SELECT x, s1.id_zawodnika,
				CASE WHEN s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) = suma1 THEN 1
					 WHEN s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) = suma2 THEN 2
					 WHEN s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) = suma3 THEN 3
				END,
				s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) AS suma
			FROM skoki_narciarskie s1
				JOIN skoki_narciarskie s2 ON s1.id_zawodnika = s2.id_zawodnika
			WHERE s1.status = 'OK' AND s2.status = 'OK' 
			AND s1.id_rozgrywki IN (SELECT id_rozgrywki FROM rozgrywki WHERE id_fazy = 7 AND id_dyscypliny = x)
			AND s2.id_rozgrywki IN (SELECT id_rozgrywki	FROM rozgrywki WHERE id_fazy = 8 AND id_dyscypliny = x);
END;
$$ LANGUAGE plpgsql;