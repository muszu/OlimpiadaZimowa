DROP FUNCTION IF EXISTS najmlodsi_medalisci_ind();
CREATE FUNCTION najmlodsi_medalisci_ind()
    RETURNS TABLE (imie VARCHAR, nazwisko VARCHAR, wiek INTERVAL,
                    panstwo VARCHAR, kategoria VARCHAR,
                    dyscyplina VARCHAR, medal TEXT) AS $$

    SELECT imie, nazwisko, wiek, panstwa.nazwa, kategorie.nazwa, dyscypliny.nazwa, CASE medal WHEN 1 THEN 'zloto'
                                                                                              WHEN 2 THEN 'srebro'
                                                                                              ELSE 'braz' END
    FROM (SELECT imie, nazwisko, id_panstwa, age(data_rozgrywki,data_urodzenia) AS wiek, id_dyscypliny, medal FROM dyscypliny_medalisci_ind
        JOIN (SELECT id_dyscypliny, MAX(data_rozgrywki) AS data_rozgrywki FROM rozgrywki GROUP BY (id_dyscypliny)) A USING(id_dyscypliny)
        JOIN zawodnicy ON id_zawodnika = zawodnicy.id
        WHERE age(data_rozgrywki,data_urodzenia) = (SELECT MIN(age(data_rozgrywki,data_urodzenia))
                                                    FROM dyscypliny_medalisci_ind
                                                    JOIN (SELECT id_dyscypliny, MAX(data_rozgrywki) AS data_rozgrywki
                                                        FROM rozgrywki GROUP BY (id_dyscypliny)) A USING(id_dyscypliny)
                                                    JOIN zawodnicy ON id_zawodnika = zawodnicy.id )) AAA
    JOIN panstwa ON id_panstwa = panstwa.id
    JOIN dyscypliny ON id_dyscypliny = dyscypliny.id
    JOIN kategorie ON id_kategorii = kategorie.id
    ORDER BY medal;
$$ LANGUAGE SQL;
