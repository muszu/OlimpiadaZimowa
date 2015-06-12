--jeśli możemy zastąpić sędziego innym sędzią to to robimy
CREATE OR REPLACE FUNCTION sedziowie_delete_check() RETURNS trigger AS $sedziowie_delete_check$
DECLARE
	zastepstwo integer;
	r record;
	u record;
BEGIN
	 FOR r IN SELECT * FROM rozgrywki roz1 
		JOIN sedziowie_rozgrywki sr1 ON roz1.id_rozgrywki = sr1.id_rozgrywki 
		WHERE sr1.id_sedziego = OLD.id 
	 LOOP
		zastepstwo=-1;
		FOR u IN SELECT * FROM sedziowie s 
		JOIN sedziowie_dyscypliny sd1 ON s.id = sd1.id_sedziego 
		WHERE sd1.id_dyscypliny=r.id_dyscypliny AND s.id != OLD.id
		LOOP
			IF( (SELECT COALESCE(COUNT(*),0) FROM rozgrywki roz2 
			JOIN sedziowie_rozgrywki sr2 ON roz2.id_rozgrywki = sr2.id_rozgrywki 
			WHERE sr2.id_sedziego=u.id
			AND (roz2.data_rozgrywki > r.data_rozgrywki + interval '5 hours' 
			OR roz2.data_rozgrywki < r.data_rozgrywki - interval '5 hours')) = 0 )
			THEN
				zastepstwo = u.id;
				EXIT;
			END IF;
		END LOOP;
		IF zastepstwo=-1
		THEN
			RAISE EXCEPTION 'Nie monżna usunąć sędziego, brak zastępstwa.';
		ELSE
			UPDATE sedziowie_rozgrywki
			SET id_sedziego = zastepstwo
			WHERE id_sedziego=OLD.id AND id_rozgrywki = r.id_rozgrywki;
		END IF;
	 END LOOP; 
	 DELETE FROM sedziowie_dyscypliny WHERE id_sedziego = OLD.id;
	 RETURN OLD;
END;
$sedziowie_delete_check$ LANGUAGE plpgsql;

CREATE TRIGGER sedziowie_delete_check BEFORE DELETE ON sedziowie
FOR EACH ROW EXECUTE PROCEDURE sedziowie_delete_check();


