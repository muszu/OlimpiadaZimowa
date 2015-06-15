
CREATE OR REPLACE FUNCTION zabron_sedz() RETURNS trigger AS $zabron_sedz$
DECLARE
 r sedziowie_dyscypliny%rowtype;
 dysc_rozgr INTEGER;
BEGIN
 dysc_rozgr = (SELECT id_dyscypliny FROM rozgrywki WHERE id_rozgrywki = NEW.id_rozgrywki);

 FOR r IN (SELECT id_dyscypliny FROM sedziowie_dyscypliny WHERE id_sedziego = NEW.id_sedziego)
 LOOP
	IF(r.id_dyscypliny = dysc_rozgr) THEN RETURN NEW;
	END IF;
 END LOOP;

RAISE EXCEPTION 'Sedzia nie sedziuje tej dyscypliny';
END;
$zabron_sedz$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_sedz BEFORE INSERT OR UPDATE ON sedziowie_rozgrywki
FOR EACH ROW EXECUTE PROCEDURE zabron_sedz();
