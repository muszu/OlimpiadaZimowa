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
			SELECT x, si.id_zawodnika, si.medal
			FROM skoki_ind_wyniki_f(x) si
			WHERE si.medal IS NOT NULL;
		--zespolowe
		ELSIF x IN (12) THEN
			x=x-1;
			x=x+1;
	END IF;
	RETURN;
END;
$$ LANGUAGE plpgsql;