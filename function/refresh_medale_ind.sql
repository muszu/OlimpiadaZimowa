CREATE OR REPLACE FUNCTION refresh_medale_ind(x integer) RETURNS void AS $$
BEGIN
	CASE x
		--biegi narciarskie
		WHEN x IN (7) THEN 
			DELETE
		--lyzwiarstwo szybkie
		WHEN x IN (5) THEN result_2
		--skoki_narciarskie
		WHEN x IN (11)THEN result_n
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