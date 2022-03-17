SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE obtain_classement2
IS
BEGIN
	--SET SERVEROUTPUT ON;
	met_a_jour_score_total;

	FOR item IN (
		SELECT prenom,nom,nbPoint
					FROM COMBATTANT
					ORDER BY nbPoint DESC
	)
	LOOP

		dbms_output.put_line('nom = ' || item.nom || ', prenom = ' || item.prenom || ', nombre de point = ' || item.nbPoint );

	END LOOP;

END;
/
SHOW ERRORS;

CREATE OR REPLACE PROCEDURE met_a_jour_score(id IN NUMBER)
AS
res number;
BEGIN
	--maj du score du joueur
	UPDATE Combattant
	SET nbPoint = 0
	WHERE idComb = id;

	--res := 0;
	FOR match in ( SELECT Round, idGagnant
		FROM TOURNOIS
		WHERE idCombRouge = id OR idCombBleu = id)
		LOOP
		IF match.idGagnant = id THEN UPDATE COMBATTANT
																	SET nbPoint = nbPoint+5--128/match.Round
																	WHERE idComb = id;
																	--res := res+128/match.Round;
		ELSE 										UPDATE COMBATTANT
																	SET nbPoint = nbPoint-5--128/match.Round
																	WHERE idComb = id;
																	--res := res-128/match.Round;
		END IF;
		END LOOP;
END;
/
SHOW ERRORS;


CREATE OR REPLACE PROCEDURE met_a_jour_score_total
AS
BEGIN
	--maj du score du joueur
	FOR match in ( SELECT idComb
		FROM COMBATTANT)
		LOOP
		met_a_jour_score(match.idComb);
		END LOOP;
END;
/
SHOW ERRORS;
