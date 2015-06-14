
CREATE OR REPLACE FUNCTION sprawdz_plec() RETURNS trigger AS $sprawdz_plec$
DECLARE
 plec_zawodnika CHAR; 
 plec_dyscypliny CHAR;
BEGIN
 plec_zawodnika = (SELECT plec FROM zawodnicy WHERE id = NEW.id_zawodnika);
 plec_dyscypliny = (SELECT CASE WHEN nazwa LIKE '%kobiet%' THEN 'F' ELSE 'M' END FROM dyscypliny WHERE id = NEW.id_dyscypliny);

 IF(plec_zawodnika != plec_dyscypliny) THEN RAISE EXCEPTION 'Zla plec';
 ELSE RETURN NEW;
 END IF;
END;
$sprawdz_plec$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_plec BEFORE INSERT OR UPDATE ON zawodnicy_dyscypliny
FOR EACH ROW EXECUTE PROCEDURE sprawdz_plec();