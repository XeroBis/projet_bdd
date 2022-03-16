-- pour la fonction qui affiche le classement :

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE obtain_classement2
IS
BEGIN
    FOR item IN (SELECT prenom,nom,nbPoint FROM COMBATTANT ORDER BY nbPoint) LOOP
        dbms_output.put_line('nom = ' || item.nom || ', prenom = ' || item.prenom || ', nombre de point = ' || item.nbPoint );
    END LOOP;
END;
/
SHOW ERRORS;

CREATE OR REPLACE PROCEDURE met_a_jour_score(id_Comb NUMBER)
AS
BEGIN
    dbms_output.put_line('id combattant : '|| id_Comb);

    --maj du score du joueur
    FOR match in ( SELECT Round, idGagnant FROM TOURNOIS WHERE idCombRouge = id_Comb OR idCombBleu = id_Comb)LOOP
        
        IF match.idGagnant = id_Comb THEN 
            UPDATE COMBATTANT SET nbPoint = nbPoint+128/match.Round WHERE idComb = id_Comb;
        ELSE
            UPDATE COMBATTANT SET nbPoint = nbPoint-128/match.Round WHERE idComb = id_Comb;
        END IF;
    END LOOP;
END;
/
SHOW ERRORS;
