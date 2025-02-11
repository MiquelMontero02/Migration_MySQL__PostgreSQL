/*Quins centres tenen usuaris matriculats a assignatures de Formació
Professional, i quina quantitat?*/

SELECT
    M.CENTRE AS CENTRE,
    COUNT(DISTINCT M.ESTUDIANT) AS USUARIS_MATRICULATS
FROM
    MATRICULA M
WHERE M.TIPO_ENSNY="FP"
GROUP BY M.CENTRE;

/*Mostreu els centres més saturats. Demostreu-ho amb dades. Per saturació
s’entén com el cúmul d’estudiants que van al centre.*/

SELECT
    M.CENTRE AS CENTRE,
    COUNT( DISTINCT M.ESTUDIANT) AS USUARIS_MATRICULATS
FROM
    MATRICULA M
GROUP BY M.CENTRE
ORDER BY USUARIS_MATRICULATS DESC;


/*Quines assignatures tenen menys de 4 usuaris matriculats? Extreure també les
dades del centre on es dóna l’assignatura.*/

WITH ALUMNES_X_ASSIGNATURA AS (
    SELECT 
    ASSIGNATURA,
    CENTRE,  
    COUNT(DISTINCT ESTUDIANT) AS NUM_ESTUDIANTS
FROM 
    MATRICULA
GROUP BY 
    ASSIGNATURA,CENTRE
)

SELECT 
    AXA.ASSIGNATURA AS ASSIGNATURA,
    AXA.CENTRE AS CENTRE,
    C.NOM_CENTRE AS NOM_CENTRE
FROM
    ALUMNES_X_ASSIGNATURA AXA
JOIN
    CENTRE C ON AXA.NUM_ESTUDIANTS<4 AND C.ID=AXA.CENTRE;

/*Quins estudiants no estan matriculats a cap assignatura?*/
CREATE VIEW ALUMNES_SENSE_MATRICULA AS 
SELECT 
    E.DNI AS DNI,
    E.NOM AS NOM,
    E.COGNOM AS COGNOM,
    E.MUNICIPI AS MUNICIPI
FROM
    ESTUDIANT E 
LEFT JOIN
    MATRICULA M ON E.DNI=M.ESTUDIANT
WHERE M.ESTUDIANT IS NULL
GROUP BY E.DNI;

SELECT * FROM ALUMNES_SENSE_MATRICULA ASA


/*Basant-t’he amb la sentència anterior, extreure el número total.*/

SELECT 
    COUNT(ASM.DNI) AS N_ALUMNES_SENSE_MATRICUA
FROM 
    ALUMNES_SENSE_MATRICULA ASM;

/*En quin centre hauria d’anar cada un dels estudiants que no estan matriculats?
La premisa es basarà en la proximitat del centre al lloc de residència de
l’estudiant*/
WITH CENTRE_ESTUDIANT AS
(SELECT
    MIN(C.ID) AS CODI_CENTRE,
    ASM.DNI AS ESTUDIANT
FROM
    ALUMNES_SENSE_MATRICULA ASM
JOIN
    MUNICIPI M ON ASM.MUNICIPI=M.ID
JOIN
    R_MUNICIPI_LOCALITAT ML ON ML.MUNICIPI=M.ID
JOIN 
    ADRECA A ON A.LOCALITAT=ML.LOCALITAT
JOIN 
    CENTRE C ON A.CENTRE=C.ID
GROUP BY ASM.DNI)

SELECT
    C.NOM_CENTRE AS NOM_CENTRE,
    CE.CODI_CENTRE AS CODI_CENTRE,
    CE.ESTUDIANT AS ESTUDIANT,
    CONCAT(E.NOM,' ',E.COGNOM) AS NOM_ESTUDIANT
FROM
    CENTRE_ESTUDIANT CE
JOIN
    CENTRE C ON C.ID=CE.CODI_CENTRE
JOIN
    ESTUDIANT E ON E.DNI=CE.ESTUDIANT;