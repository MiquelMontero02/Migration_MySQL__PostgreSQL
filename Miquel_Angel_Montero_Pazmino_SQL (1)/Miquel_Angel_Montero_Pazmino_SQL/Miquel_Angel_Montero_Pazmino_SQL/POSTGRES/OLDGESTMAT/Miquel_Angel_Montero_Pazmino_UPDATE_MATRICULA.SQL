UPDATE oldgestmat.MATRICULA 
SET assignatura=
    CASE
        WHEN UPPER(assignatura) LIKE 'CULTURA CIENTÍFICA%' THEN 'CULTURA CIENTÍFICA '
    ELSE
        (SELECT 
            A1.NOM 
        FROM 
            oldgestmat.assignatura A1 
        WHERE upper(assignatura) LIKE upper(concat(A1.nom,'%'))FETCH FIRST ROW ONLY)
    END 
WHERE assignatura NOT IN (SELECT
                                NOM 
                            FROM 
                                oldgestmat.assignatura);