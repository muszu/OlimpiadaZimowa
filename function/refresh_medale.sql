CREATE OR REPLACE FUNCTION refresh_medale_ind(x integer) RETURNS void AS $$
BEGIN
	DELETE FROM dyscypliny_medale_zes WHERE id_dyscypliny = x;
	DELETE FROM  dyscypliny_medalisci_ind WHERE id_dyscypliny = x;
		--biegi narciarskie ind
		IF x IN (13,14,18) THEN
		INSERT INTO  dyscypliny_medalisci_ind
			SELECT x, id_zwodnika,
				CASE WHEN row_number() over( order by czas)=1 THEN 1
					 WHEN row_number() over( order by czas)=2 THEN 2
					 WHEN row_number() over( order by czas)=3 THEN 3
				END
			FROM biegi_narciarskie
			WHERE status = 'OK' AND id_rozgrywki IN (SELECT id_rozgrywki
			FROM rozgrywki
			WHERE id_fazy = 1 AND id_dyscypliny = x)
			LIMIT 3;
		--zespolowe
		ELSIF x IN (15,16,17,19) THEN 
			x=x-1;
			x=x+1;
		--lyzwiarstwo szybkie ind
		ELSIF x IN (1,2,3,4) THEN
			INSERT INTO  dyscypliny_medalisci_ind
			SELECT x,  id_zawodnika,
				CASE WHEN row_number() over( order by czas)=1 THEN 1
					 WHEN row_number() over( order by czas)=2 THEN 2
					 WHEN row_number() over( order by czas)=3 THEN 3
				END
			FROM lyzwiarstwo_szybkie
			WHERE status = 'OK' AND id_rozgrywki IN (SELECT id_rozgrywki
			FROM rozgrywki
			WHERE id_fazy = 1 AND id_dyscypliny = x)
			LIMIT 3;
		--zespolowe
		ELSIF x IN (5,6) THEN
			x=x-1;
			x=x+1;
		--skoki_narciarskie ind    7 seria 1    8 seria 2
		ELSIF x IN (9,10,11) THEN
			INSERT INTO  dyscypliny_medalisci_ind
			SELECT x, s1. id_zawodnika,
				CASE WHEN row_number() over( order by s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) DESC)=1 THEN 1
					 WHEN row_number() over( order by s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5) DESC)=2 THEN 2
					 WHEN row_number() over( order by s1.odleglosc + s1.sedzia1 + s1.sedzia2 + s1.sedzia3 + s1.sedzia4 + s1.sedzia5 + s2.odleglosc + s2.sedzia1 + s2.sedzia2 + s2.sedzia3 + s2.sedzia4 + s2.sedzia5 
												- GREATEST(s1.sedzia1, s1.sedzia2, s1.sedzia3, s1.sedzia4, s1.sedzia5) 
												- GREATEST(s2.sedzia1, s2.sedzia2, s2.sedzia3, s2.sedzia4, s2.sedzia5)
												+ GREATEST(-s1.sedzia1, -s1.sedzia2, -s1.sedzia3, -s1.sedzia4, -s1.sedzia5) 
												+ GREATEST(-s2.sedzia1, -s2.sedzia2, -s2.sedzia3, -s2.sedzia4, -s2.sedzia5)DESC)=3 THEN 3
				END
			FROM skoki_narciarskie s1
				JOIN skoki_narciarskie s2 ON s1.id_zawodnika = s2.id_zawodnika
			WHERE s1.status = 'OK' AND s2.status = 'OK' 
			AND s1.id_rozgrywki IN (SELECT id_rozgrywki FROM rozgrywki WHERE id_fazy = 7 AND id_dyscypliny = x)
			AND s2.id_rozgrywki IN (SELECT id_rozgrywki	FROM rozgrywki WHERE id_fazy = 8 AND id_dyscypliny = x)
			LIMIT 3;
		--zespolowe
		ELSIF x IN (12) THEN
			x=x-1;
			x=x+1;
	END IF;
	RETURN;
END;
$$ LANGUAGE plpgsql;