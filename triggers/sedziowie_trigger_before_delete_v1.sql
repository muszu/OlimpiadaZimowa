--jeśli możemy zastąpić sędziego innym sędzią to to zróbmy
CREATE OR REPLACE FUNCTION sedziowie_delete_check() RETURNS trigger AS $sedziowie_delete_check$
BEGIN
  IF ( SELECT COALESCE(COUNT(*),0)  FROM sedziowie_rozgrywki r where r.id_sedziego = OLD.id) != 0 then
    RAISE EXCEPTION 'Nie monżna skasować sędziego, ponieważ sędziuje mecz';
	END IF;
	DELETE from sedziowie s where s.id=OLD.id;
END;
$sedziowie_delete_check$ LANGUAGE plpgsql;

CREATE TRIGGER sedziowie_delete_check BEFORE DELETE ON sedziowie
FOR EACH ROW EXECUTE PROCEDURE sedziowie_delete_check();