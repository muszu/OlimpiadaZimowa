CREATE VIEW wyniki_lyzwiarstwo_szybkie
(konkurencja, id_rozgrywki, faza, id_zawodnika, imie, nazwisko, panstwo, czas, status)
AS
(SELECT dy.nazwa, ro.id_rozgrywki, fa.nazwa, ly.id_zawodnika, 
	za.imie, za.nazwisko, pa.nazwa, ly.czas, ly.status
FROM rozgrywki ro JOIN fazy fa ON fa.id = ro.id_fazy
JOIN dyscypliny dy ON dy.id = ro.id_dyscypliny
JOIN lyzwiarstwo_szybkie ly ON ly.id_rozgrywki = ro.id_rozgrywki
JOIN zawodnicy za ON ly.id_zawodnika = za.id
JOIN panstwa pa ON pa.id = za.id_panstwa
ORDER BY dy.nazwa, fa.id, ly.id_rozgrywki, CASE WHEN ly.status = 'OK' THEN 1 ELSE 2 END, ly.czas);
