CREATE OR REPLACE FUNCTION odswiez_medale(x integer) RETURNS void AS $$
BEGIN
	DELETE FROM dyscypliny_medale_zes WHERE id_dyscypliny = x;
	DELETE FROM  dyscypliny_medalisci_ind WHERE id_dyscypliny = x;
		--ind bez nart
		IF x IN (1,2,3,4,13,14,18) THEN
		INSERT INTO  dyscypliny_medalisci_ind
			SELECT x, w.id_zawodnika, w.medal
			FROM wyniki_ind(x) w
			WHERE w.medal IS NOT NULL;
		ELSIF x IN (5,6,15,16,17,19) THEN 
			INSERT INTO  dyscypliny_medale_zes
			SELECT x, si.id_druzyny, si.medal
			FROM dru_wyniki_bezsk_f(x) si
			WHERE si.medal IS NOT NULL;
		--skoki_narciarskie ind    7 seria 1    8 seria 2
		ELSIF x IN (9,10,11) THEN
			INSERT INTO  dyscypliny_medalisci_ind
			SELECT x, si.id_zawodnika, si.medal
			FROM skoki_ind_wyniki_f(x) si
			WHERE si.medal IS NOT NULL;
		--zespolowe
		ELSIF x IN (12) THEN
			INSERT INTO  dyscypliny_medale_zes
			SELECT x, si.id_druzyny, si.medal
			FROM skoki_dru_wyniki_f(x) si
			WHERE si.medal IS NOT NULL;
	END IF;
	RETURN;
END;
$$ LANGUAGE plpgsql;