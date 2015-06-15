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
	
DO $$
DECLARE r record;
    BEGIN
        FOR r IN SELECT ns.nspname, proname, proargtypes FROM pg_proc INNER JOIN pg_namespace ns ON (pg_proc.pronamespace = ns.oid)
 where nspname = 'public' AND proname IN('refresh_medale_ind','refresh_test' ,'doping_change' ,'test' ,'test' ,'refresh_medale_ind' ,'wyniki_skoki' ,'wyniki_skoki_seria' ,
'refresh_medale' ,'sprawdz1','odswiez' ,'zabron_sedz' ,'zabron_lyzw' ,'sprawdz2' ,'sprawdz_dyscypline' ,'sprawdz_plec' ,
'zabron_hokej' ,'sedziowie_delete_check' ,'sprawdz_plec_kraj' ,'zabron_biegi' ,'zabron_skoki' ,'odswiez_medale' ,
'wyniki_dru_bezsk' ,'wyniki_ind' ,'wyniki_skoki_druzynowe' ,'zabron' ,'skoki_dru_wyniki_f' ,'skoki_ind_wyniki_f' ,
'wyniki_ind_bezwyjatku' ,'skoki_update' ,'dru_wyniki_bezsk_f' ,'tabela_medalowa_nadkategoria' ,
'tabela_medalowa_nadkategoria_ind' ,'tabela_medalowa_nadkategoria_zes')
        LOOP
			EXECUTE 'DROP FUNCTION IF EXISTS ' || r.nspname || '.' || r.proname || '(' || oidvectortypes(r.proargtypes) || ') CASCADE;';
        END LOOP;
    END
	$$;	