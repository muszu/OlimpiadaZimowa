
CREATE OR REPLACE FUNCTION sprawdz_plec_kraj() RETURNS trigger AS $sprawdz_plec_kraj$
DECLARE
 kraj_zawodnika INTEGER;
 kraj_druzyny INTEGER;
 plec_zawodnika CHAR;
 r zawodnicy_druzyny%rowtype;
BEGIN
 kraj_zawodnika = (SELECT id_panstwa FROM zawodnicy WHERE id = NEW.id_zawodnika);
 kraj_druzyny = (SELECT id_kraju FROM druzyny WHERE id = NEW.id_druzyny);
 plec_zawodnika = (SELECT plec FROM zawodnicy WHERE id = NEW.id_zawodnika);

 IF(kraj_zawodnika != kraj_druzyny) THEN RAISE EXCEPTION 'Inne narodowosci';
 END IF;

 FOR r IN (SELECT id_zawodnika FROM zawodnicy_druzyny zd WHERE zd.id_druzyny = NEW.id_druzyny)
  LOOP
     IF(plec_zawodnika != (SELECT plec FROM zawodnicy WHERE id = r.id_zawodnika))
     	THEN RAISE EXCEPTION 'Zla plec';
     END IF;
  END LOOP;

RETURN NEW;
END;
$sprawdz_plec_kraj$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_plec_kraj BEFORE INSERT OR UPDATE ON zawodnicy_druzyny
FOR EACH ROW EXECUTE PROCEDURE sprawdz_plec_kraj();