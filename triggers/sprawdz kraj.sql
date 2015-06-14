
CREATE OR REPLACE FUNCTION sprawdz_kraj() RETURNS trigger AS $sprawdz_kraj$
DECLARE
 kraj_zawodnika INTEGER = (SELECT id_panstwa FROM zawodnicy WHERE id = NEW.id_zawodnika);
 kraj_druzyny INTEGER = (SELECT id_kraju FROM druzyny WHERE id = NEW.id_druzyny);
BEGIN
 IF(kraj_zawodnika != kraj_druzyny) THEN RETURN NULL;
 ELSE RETURN NEW;
 END IF;
END;
$sprawdz_kraj$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_kraj BEFORE INSERT ON zawodnicy_druzyny
FOR EACH ROW EXECUTE PROCEDURE sprawdz_kraj();