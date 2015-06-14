CREATE FUNCTION wyniki_skoki_seria(INT) AS $$
SELECT id_zawodnika,
    CASE WHEN status='OK' THEN odleglosc+sedzia1+sedzia2+sedzia3+sedzia4+sedzia5 -
                                GREATEST(sedzia1, sedzia2, sedzia3, sedzia4, sedzia5) +
                                GREATEST(-sedzia1, -sedzia2, -sedzia3, -sedzia4, -sedzia5)
                         ELSE 0 END AS punkty
                         FROM skoki_narciarskie WHERE id_rozgrywki = $1 ORDER BY 2
$$
LANGUAGE SQL;
