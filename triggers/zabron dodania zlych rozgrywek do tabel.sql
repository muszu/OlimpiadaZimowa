
CREATE OR REPLACE FUNCTION zabron_hokej() RETURNS trigger AS $zabron_hokej$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'hokej na lodzie')
	THEN RETURN NULL;
 ELSE RETURN NEW;
 END IF;

END;
$zabron_hokej$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_hokej BEFORE INSERT OR UPDATE ON hokej
FOR EACH ROW EXECUTE PROCEDURE zabron_hokej();

-----------------------------------------------------


CREATE OR REPLACE FUNCTION zabron_lyzw() RETURNS trigger AS $zabron_lyzw$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'lyzwiarstwo szybkie')
	THEN RETURN NULL;
 ELSE RETURN NEW;
 END IF;

END;
$zabron_lyzw$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_lyzw BEFORE INSERT OR UPDATE ON lyzwiarstwo_szybkie
FOR EACH ROW EXECUTE PROCEDURE zabron_lyzw();

------------------------------------------------------

CREATE OR REPLACE FUNCTION zabron_biegi() RETURNS trigger AS $zabron_biegi$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'biegi narciarskie')
	THEN RETURN NULL;
 ELSE RETURN NEW;
 END IF;

END;
$zabron_biegi$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_biegi BEFORE INSERT OR UPDATE ON biegi_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron_biegi();

------------------------------------------------------

CREATE OR REPLACE FUNCTION zabron_skoki() RETURNS trigger AS $zabron_skoki$
BEGIN
 
 IF((SELECT k.nazwa FROM kategorie k JOIN dyscypliny d ON d.id_kategorii = k.id JOIN rozgrywki r ON d.id = r.id_dyscypliny
 WHERE r.id_rozgrywki = NEW.id_rozgrywki) != 'skoki narciarskie')
	THEN RETURN NULL;
 ELSE RETURN NEW;
 END IF;

END;
$zabron_skoki$ LANGUAGE plpgsql;


CREATE TRIGGER zabron_skoki BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXECUTE PROCEDURE zabron_skoki();
