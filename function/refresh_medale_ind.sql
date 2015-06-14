CREATE OR REPLACE FUNCTION refresh_medale_ind(x integer) RETURNS void AS $$
BEGIN
	DELETE FROM dyscypliny_medale_zes WHERE id_dyscypliny = x;
	DELETE FROM dyscypliny_medale_ind WHERE id_dyscypliny = x;
	CASE x
		--biegi narciarskie ind
		WHEN x IN (13,14,18) THEN
			
		--zespolowe
		WHEN x IN (15,16,17,19) THEN 
			
		--lyzwiarstwo szybkie ind
		WHEN x IN (1,2,3,4) THEN
			
		--zespolowe
		WHEN x IN (5,6) THEN
			
		--skoki_narciarskie ind
		WHEN x IN (9,10,11) THEN
			
		--zespolowe
		WHEN x IN (12) THEN
			
	END
		
		
		
		
	RETURN;
END;
$$ LANGUAGE plpgsql;




IF( x IN () )

	PERFORM refresh_medale_ind(2);
			IF( NEW.wynik )
		THEN
			UPDATE biegi_narciarskie
			SET status='DSQ'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='OK';
			UPDATE skoki_narciarskie
			SET status='DSQ'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='OK';
			UPDATE lyzwiarstwo_szybkie
			SET status='DSQ'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='OK';
		ELSE
			UPDATE biegi_narciarskie
			SET status='OK'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='DSQ';
			UPDATE skoki_narciarskie
			SET status='OK'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='DSQ';
			UPDATE lyzwiarstwo_szybkie
			SET status='OK'
			WHERE id_zawodnika = NEW.id_zawodnika AND status='DSQ';
		END IF;
		FOR r IN SELECT id_dyscypliny FROM rozgrywki
		LOOP
			PERFORM refresh_medale_ind(r.id_dyscypliny);
		END LOOP;