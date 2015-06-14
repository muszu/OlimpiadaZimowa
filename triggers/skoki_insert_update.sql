CREATE OR REPLACE FUNCTION skoki_update() RETURNS trigger AS $skoki_update$
BEGIN
    IF (NEW.odleglosc < 0) NEW.odleglosc := 0;
    IF (NEW.sedzia1) IS NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia1' END IF;
    IF (NEW.sedzia2) IS NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia2' END IF;
    IF (NEW.sedzia3) IS NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia3' END IF;
    IF (NEW.sedzia4) IS NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia4' END IF;
    IF (NEW.sedzia5) IS NOT IN (0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5,
                                5.5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10,
                                10.5, 11, 11.5, 12, 12.5, 13, 13.5, 14, 14.5, 15,
                                15.5, 16, 16.5, 17, 17.5, 18, 18.5, 19, 19.5, 20)
        THEN RAISE EXCEPTION 'Wrong value of sedzia5' END IF;
    RETURN NEW;
END;
$skoki_update$ LANGUAGE plpgsql;

CREATE TRIGGER skoki_update BEFORE INSERT OR UPDATE ON skoki_narciarskie
FOR EACH ROW EXCECUTE PROCEDURE skoki_update();
