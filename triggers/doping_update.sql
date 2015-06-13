--UPDATE TABLICY MEDALOWEJ JESZCZE DO ZROBIENIA!!!!!
CREATE OR REPLACE FUNCTION doping_change() RETURNS trigger AS $$
BEGIN
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
	 RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER doping_change AFTER UPDATE OR INSERT ON doping
FOR EACH ROW EXECUTE PROCEDURE doping_change();


