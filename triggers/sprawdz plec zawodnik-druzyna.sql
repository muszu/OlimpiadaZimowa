
CREATE OR REPLACE FUNCTION sprawdz_plec_dr() RETURNS trigger AS $sprawdz_plec_dr$
DECLARE
 plec_zawodnika CHAR;
 r zawodnicy_druzyny%rowtype;
 
BEGIN
 plec_zawodnika = (SELECT plec FROM zawodnicy WHERE id = NEW.id_zawodnika);

 FOR r IN (SELECT id_zawodnika FROM zawodnicy_druzyny zd WHERE zd.id_druzyny = NEW.id_druzyny)
 LOOP
     IF(plec_zawodnika != (SELECT plec FROM zawodnicy WHERE id = r.id_zawodnika))
     	THEN RETURN NEW;
     END IF;
 END LOOP;
RETURN NULL;
END;
$sprawdz_plec_dr$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_plec_dr BEFORE INSERT ON zawodnicy_druzyny
FOR EACH ROW EXECUTE PROCEDURE sprawdz_plec_dr();



