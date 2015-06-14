CREATE OR REPLACE FUNCTION wyniki_ind(x integer) 
RETURNS TABLE(dyscyplina varchar(50), id_zawodnika integer, czas numeric, medal integer) AS $$
DECLARE
 best1 NUMERIC;
 best2 NUMERIC;
 best3 NUMERIC;
 zlota INTEGER;
 srebra INTEGER;
 brazy INTEGER;
	
BEGIN
IF(x NOT IN (1,2,3,4,13,14,18))
	THEN RAISE EXCEPTION 'Zla dyscyplina';
END IF;

IF((SELECT r.id_rozgrywki FROM dyscypliny d LEFT JOIN rozgrywki r ON d.id = r.id_dyscypliny WHERE r.id_dyscypliny = x AND id_fazy = 1) IS NULL)
	THEN RAISE EXCEPTION 'Final jeszcze sie nie odbyl';
END IF;


IF(x IN (1,2,3,4)) THEN 

	best1 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best2 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best3 = (SELECT ls.czas FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best2 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	zlota = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best1 AND ls.status = 'OK');

	srebra = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best2 AND ls.status = 'OK');

	brazy = (SELECT COUNT(*) FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
	WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best3 AND ls.status = 'OK');

	IF(zlota >= 3) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(zlota = 2) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 3 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(srebra > 1) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;
		
	ELSE RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 WHEN(ls.czas = best3) THEN 3 ELSE NULL END
	FROM lyzwiarstwo_szybkie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	END IF;	

ELSE

	best1 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best2 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best1 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	best3 = (SELECT ls.czas FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas > best2 AND ls.status = 'OK' ORDER BY ls.czas LIMIT 1);

	zlota = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best1 AND ls.status = 'OK');

	srebra = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best2 AND ls.status = 'OK');

	brazy = (SELECT COUNT(*) FROM biegi_narciarskie ls JOIN rozgrywki r ON r.id_rozgrywki = ls.id_rozgrywki 
		WHERE r.id_dyscypliny = x AND r.id_fazy = 1 AND ls.czas = best3 AND ls.status = 'OK');

	IF(zlota >= 3) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(zlota = 2) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 3 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSIF(srebra > 1) THEN RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	ELSE RETURN QUERY
	SELECT d.nazwa, ls.id_zawodnika, ls.czas, CASE WHEN(ls.czas = best1) THEN 1 WHEN(ls.czas = best2) THEN 2 WHEN(ls.czas = best3) THEN 3 ELSE NULL END
	FROM biegi_narciarskie ls JOIN rozgrywki r ON ls.id_rozgrywki = r.id_rozgrywki
	JOIN dyscypliny d ON r.id_dyscypliny = d.id
	WHERE r.id_fazy = 1 AND ls.status = 'OK' ORDER BY 3;

	END IF;	

END IF;
END;
$$ LANGUAGE plpgsql;