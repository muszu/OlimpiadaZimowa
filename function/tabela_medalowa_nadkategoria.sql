DROP FUNCTION IF EXISTS tabela_medalowa_nadkategoria(TEXT);
CREATE OR REPLACE FUNCTION tabela_medalowa_nadkategoria(TEXT)
    RETURNS TABLE (panstwo int, zloto int, srebro int, braz int, suma int) AS $$

    SELECT panstwo, COALESCE(A.zloto,0)+COALESCE(B.zloto,0),
            COALESCE(A.srebro,0)+COALESCE(B.srebro,0),
            COALESCE(A.braz,0)+COALESCE(B.braz,0),
            COALESCE(A.suma,0)+COALESCE(B.suma,0)
	FROM (SELECT * FROM tabela_medalowa_nadkategoria_ind($1)) A
            FULL OUTER JOIN (SELECT * FROM tabela_medalowa_nadkategoria_zes($1)) B USING(panstwo)
	ORDER BY 2 DESC, 3 DESC, 4 DESC
$$ LANGUAGE SQL
