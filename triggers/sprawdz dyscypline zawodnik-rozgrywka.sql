
CREATE OR REPLACE FUNCTION sprawdz_dyscypline() RETURNS trigger AS $sprawdz_dyscypline$
DECLARE
 dysc INTEGER;
 r zawodnicy_dyscypliny%rowtype;
 jest BOOLEAN;
BEGIN
dysc = (SELECT id_dyscypliny FROM rozgrywki WHERE id_rozgrywki = NEW.id_rozgrywki);
jest = false;

FOR r IN (SELECT id_dyscypliny FROM zawodnicy_dyscypliny WHERE id_zawodnika = NEW.id_zawodnika)
LOOP
 IF(r.id_dyscypliny = dysc) THEN jest = TRUE;
 END IF;
END LOOP;

IF(jest = TRUE) THEN RETURN NEW;
ELSE RAISE EXCEPTION 'Zawodnik nie bierze udzialu w tej dyscyplinie';
END IF;
END;
$sprawdz_dyscypline$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_dyscypline_h BEFORE INSERT OR UPDATE ON hokej
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();

CREATE TRIGGER sprawdz_dyscypline_s BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();

CREATE TRIGGER sprawdz_dyscypline_l BEFORE INSERT OR UPDATE ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();

CREATE TRIGGER sprawdz_dyscypline_b BEFORE INSERT OR UPDATE ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz_dyscypline();