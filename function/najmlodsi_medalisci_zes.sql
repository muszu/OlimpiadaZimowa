DROP FUNCTION IF EXISTS najmlodsi_medalisci_zes();
CREATE FUNCTION najmlodsi_medalisci_zes()
    RETURNS TABLE (imie VARCHAR, nazwisko VARCHAR, wiek INTERVAL,
                    druzyna VARCHAR, kategoria VARCHAR,
                    dyscyplina VARCHAR, medal TEXT) AS $$

    SELECT imie, nazwisko, wiek, druzyny.nazwa, kategorie.nazwa, dyscypliny.nazwa, CASE medal WHEN 1 THEN 'zloto'
                                                                                              WHEN 2 THEN 'srebro'
                                                                                              ELSE 'braz' END
    FROM (SELECT imie, nazwisko, age(data_rozgrywki,data_urodzenia) as wiek, id_druzyny, id_dyscypliny, medal FROM dyscypliny_medale_zes
        JOIN (SELECT id_dyscypliny, MAX(data_rozgrywki) AS data_rozgrywki FROM rozgrywki GROUP BY (id_dyscypliny)) A USING(id_dyscypliny)
        JOIN zawodnicy_druzyny USING(id_druzyny)
        JOIN zawodnicy ON id_zawodnika = zawodnicy.id
        WHERE age(data_rozgrywki, data_urodzenia)= (SELECT MIN(age(data_rozgrywki,data_urodzenia)) FROM dyscypliny_medale_zes
                                                            JOIN (SELECT id_dyscypliny, MAX(data_rozgrywki) AS data_rozgrywki FROM rozgrywki GROUP BY (id_dyscypliny)) A USING(id_dyscypliny)
                                                            JOIN zawodnicy_druzyny USING(id_druzyny)
                                                            JOIN zawodnicy ON id_zawodnika = zawodnicy.id)) AAA
    JOIN druzyny ON id_druzyny = druzyny.id
    JOIN dyscypliny ON AAA.id_dyscypliny = dyscypliny.id
    JOIN kategorie ON id_kategorii = kategorie.id
    ORDER BY medal;
$$ LANGUAGE SQL;
;
