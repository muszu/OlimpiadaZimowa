DROP FUNCTION IF EXISTS najstarsi_medalisci();
CREATE FUNCTION najstarsi_medalisci()
    RETURNS TABLE (imie VARCHAR, nazwisko VARCHAR, wiek INTERVAL,
                    panstwo VARCHAR, kategoria VARCHAR,
                    dyscyplina VARCHAR, medal TEXT) AS $$
    SELECT * FROM
        (SELECT imie, nazwisko, wiek, panstwa.nazwa as panstwo, kategoria, dyscyplina, medal FROM najstarsi_medalisci_zes()
            JOIN druzyny ON druzyna = druzyny.nazwa
            JOIN panstwa ON id_kraju = panstwa.id
        UNION  select * from najstarsi_medalisci_ind()) A
    WHERE wiek = (SELECT MAX(wiek) FROM (SELECT wiek FROM najstarsi_medalisci_zes() UNION SELECT wiek FROM najstarsi_medalisci_ind()) B);

$$ LANGUAGE SQL;
