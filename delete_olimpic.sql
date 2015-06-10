DO $$
DECLARE r record;
    BEGIN
        FOR r IN SELECT table_name
                 FROM information_schema.tables
                 WHERE table_name IN ('fazy', 'kategorie', 'obiekty', 'panstwa', 'sedziowie', 'dyscypliny', 'rozgrywki', 'sedziowie_dyscypliny',
				 'sedziowie_rozgrywki', 'druzyny', 'dyscypliny_medale_zes', 'dyscypliny_medalisci_ind', 'hokej', 'zawodnicy', 'zawodnicy_druzyny', 
				 'zawodnicy_dyscypliny', 'biegi_narciarskie', 'skoki_narciarskie', 'lyzwiarstwo_szybkie', 'doping')
        LOOP
			EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.table_name)|| ' CASCADE;';
        END LOOP;
    END
	$$;