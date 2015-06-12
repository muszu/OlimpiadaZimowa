--jeśli możemy zastąpić sędziego innym sędzią to to zróbmy
--TRZEBA sprawidź czy Raise exception robi rollback
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
			IF( SELECT COALESCE(COUNT(*),0) FROM rozgrywki roz2 
			JOIN sedziowie_rozgrywki sr2 ON roz2.od_rozrywki = sr2.id_rozgrywki 
			WHERE sr2.id_sedziego=zastepstwo 
			AND (roz2.data_rozgrywki > roz1.data_rozgrywki + interval '5 hours' 
			OR roz2.data_rozgrywki < roz1.data_rozgrywki - interval '5 hours') )
			THEN
				zastepstwo = u.id;
			END IF;
		END LOOP;
		IF zastepstwo=-1
		THEN
			RAISE EXCEPTION 'Nie monżna usunąć sędziego, brak zastępstwa do sędziowania.';
		ELSE
			--zmień dane w tabeli
		END IF;
	 END LOOP; 
END;
$sedziowie_delete_check$ LANGUAGE plpgsql;

CREATE TRIGGER sedziowie_delete_check BEFORE DELETE ON sedziowie
FOR EACH ROW EXECUTE PROCEDURE sedziowie_delete_check();

-- IF ( SELECT COALESCE(COUNT(*),0)  FROM sedziowie_rozgrywki r where r.id_sedziego = OLD.id) != 0 then
--		RAISE EXCEPTION 'Nie monżna skasować sędziego, ponieważ sędziuje mecz';
--		END IF;
--		DELETE from sedziowie s where s.id=OLD.id;
--	ROLLBACK jak nie pyknie




