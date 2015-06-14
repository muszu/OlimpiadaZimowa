CREATE VIEW wyniki_hokeja(mecz, faza, plec, druzyna1, druzyna2, wynik)
AS(

	WITH punkty(mecz, druzyna, gole, samoboje) AS
	(SELECT ho.id_rozgrywki, dr.id, SUM(ho.bramki), SUM(ho.bramki_samobojcze)
	FROM hokej ho JOIN zawodnicy za ON ho.id_zawodnika = za.id
	JOIN zawodnicy_druzyny zd ON zd.id_zawodnika = za.id
	JOIN druzyny dr ON dr.id = zd.id_druzyny
	JOIN dyscypliny dy ON dr.id_dyscypliny = dy.id
	WHERE dy.nazwa LIKE '%turniej%'
	GROUP BY ho.id_rozgrywki, dr.id
	ORDER BY 1),

	mecze(mecz, dr1, gole1, samoboje1, dr2, gole2, samoboje2) AS
	(SELECT p1.mecz, p1.druzyna, p1.gole, p1.samoboje, p2.druzyna, p2.gole, p2.samoboje
	FROM punkty p1 JOIN punkty p2 ON p1.mecz = p2.mecz
	WHERE p1.druzyna != p2.druzyna),

	wyniki(mecz, dr1, dr2, wynik1, wynik2, rownumber) AS
	(SELECT m.mecz, m.dr1, m.dr2, m.gole1 + m.samoboje2, m.gole2 + m.samoboje1,
	row_number() over (partition by m.mecz)
	FROM mecze m),

	wyniki_dist(mecz, dr1, dr2, wynik1, wynik2) AS
	(SELECT w.mecz, w.dr1, w.dr2, w.wynik1, w.wynik2 
	FROM wyniki w WHERE w.rownumber = 1)
	
	SELECT wd.mecz, fa.nazwa, CASE WHEN dy.nazwa LIKE '%kobiet%' THEN 'kobiet' ELSE 'mezczyzn' END AS plec,
		pa1.nazwa AS p1, pa2.nazwa AS p2, wd.wynik1 || ' : ' || wd.wynik2
	FROM wyniki_dist wd JOIN rozgrywki ro ON ro.id_rozgrywki = wd.mecz
	JOIN fazy fa ON fa.id = ro.id_fazy
	JOIN dyscypliny dy ON dy.id = ro.id_dyscypliny
	JOIN druzyny d1 ON wd.dr1 = d1.id
	JOIN druzyny d2 ON wd.dr2 = d2.id
	JOIN panstwa pa1 ON pa1.id = d1.id_kraju
	JOIN panstwa pa2 ON pa2.id = d2.id_kraju
	ORDER BY plec, CASE WHEN fa.nazwa LIKE 'final' THEN 0 WHEN fa.nazwa LIKE '%mecz%3%' THEN 1 WHEN fa.nazwa LIKE '%polfinal%' THEN 2 ELSE 3 END
);