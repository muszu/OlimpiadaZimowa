CREATE OR REPLACE FUNCTION refresh_medale_ind(x integer) RETURNS void AS $$
BEGIN
	DELETE FROM dyscypliny_medale_zes WHERE id_dyscypliny = x;
	DELETE FROM dyscypliny_medale_ind WHERE id_dyscypliny = x;
	CASE
		--biegi narciarskie ind
		WHEN x IN (13,14,18) THEN
		INSERT INTO dyscypliny_medale_ind
			SELECT x, id_zwodnika,
				CASE WHEN row_number() over( order by bn.czas)=1 THEN 'zloty'
					 WHEN row_number() over( order by bn.czas)=2 THEN 'srebrny'
					 WHEN row_number() over( order by bn.czas)=3 THEN 'brazowy'
				END
			FROM biegi_narciarskie bn
			WHERE status = 'OK' AND id_rozgrywki IN (SELECT id_rozgrywki
			FROM rozgrywki
			WHERE id_fazy = 1 AND id_dyscypliny = x)
			LIMIT 3;
		--zespolowe
		WHEN x IN (15,16,17,19) THEN 
			x=x-1;
			x=x+1;
		--lyzwiarstwo szybkie ind
		WHEN x IN (1,2,3,4) THEN
			x=x-1;
			x=x+1;
		--zespolowe
		WHEN x IN (5,6) THEN
			x=x-1;
			x=x+1;
		--skoki_narciarskie ind
		WHEN x IN (9,10,11) THEN
			x=x-1;
			x=x+1;
		--zespolowe
		WHEN x IN (12) THEN
			x=x-1;
			x=x+1;
	END;
	RETURN;
END;
$$ LANGUAGE plpgsql;




SELECT  
				CASE WHEN row_number() over( order by id_kategorii)=1 THEN 111
					WHEN row_number() over( order by id_kategorii)=2 THEN 222
					WHEN row_number() over( order by id_kategorii)=3 THEN 33
					ELSE row_number() over( order by id_kategorii)
				END,
			d.* from dyscypliny d;