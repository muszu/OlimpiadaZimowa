DROP FUNCTION IF EXISTS najmlodsi_medalisci();
CREATE FUNCTION najmlodsi_medalisci()
    RETURNS TABLE (imie VARCHAR, nazwisko VARCHAR, wiek INTERVAL,
                    panstwo VARCHAR, kategoria VARCHAR,
                    dyscyplina VARCHAR, medal TEXT) AS $$
    SELECT * FROM
        (SELECT imie, nazwisko, wiek, panstwa.nazwa as panstwo, kategoria, dyscyplina, medal FROM najmlodsi_medalisci_zes()
            JOIN druzyny ON druzyna = druzyny.nazwa
            JOIN panstwa ON id_kraju = panstwa.id
        UNION  select * from najmlodsi_medalisci_ind()) A
    WHERE wiek = (SELECT min(wiek) FROM (SELECT wiek FROM najmlodsi_medalisci_zes() UNION SELECT wiek FROM najmlodsi_medalisci_ind()) B);

$$ LANGUAGE SQL;
