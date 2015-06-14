
CREATE OR REPLACE FUNCTION sprawdz1() RETURNS trigger AS $sprawdz1$
BEGIN
 IF(NEW.status = 'OK' AND NEW.czas IS NULL) 
	THEN RAISE EXCEPTION 'Czas nie moze byc nullem';

 ELSE RETURN NEW;
END IF; 
END;
$sprawdz1$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION sprawdz2() RETURNS trigger AS $sprawdz2$
BEGIN
 IF(NEW.status = 'OK' AND (NEW.odleglosc IS NULL OR NEW.sedzia1 IS NULL 
			OR NEW.sedzia2 IS NULL OR NEW.sedzia3 IS NULL 
			OR NEW.sedzia4 IS NULL OR NEW.sedzi5 IS NULL)) 
	THEN RAISE EXCEPTION 'Punkty nie moga byc nullem';
 ELSE RETURN NEW;
END IF; 
END;
$sprawdz2$ LANGUAGE plpgsql;


CREATE TRIGGER sprawdz_l BEFORE INSERT OR UPDATE ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE sprawdz1();

CREATE TRIGGER sprawdz_b BEFORE INSERT OR UPDATE ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz1();

CREATE TRIGGER sprawdz_s BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE sprawdz2();