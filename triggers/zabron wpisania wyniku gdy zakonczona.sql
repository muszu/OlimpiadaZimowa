
CREATE OR REPLACE FUNCTION zabron() RETURNS trigger AS $zabron$
DECLARE
 dysc INTEGER;
BEGIN
 dysc = (SELECT r.id_dyscypliny FROM rozgrywki r WHERE r.id_rozgrywki = NEW.id_rozgrywki);
 IF((SELECT d.zakonczona FROM dyscypliny d WHERE d.id = dysc) = TRUE) THEN RAISE EXCEPTION 'Dyscyplina zakonczona';
 ELSE RETURN NEW;
END IF; 
END;
$zabron$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_h BEFORE INSERT ON hokej
FOR EACH ROW EXECUTE PROCEDURE zabron();

CREATE TRIGGER zabron_l BEFORE INSERT ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE zabron();

CREATE TRIGGER zabron_b BEFORE INSERT ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron();

CREATE TRIGGER zabron_s BEFORE INSERT ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron();