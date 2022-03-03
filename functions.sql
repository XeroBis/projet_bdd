#pour la fonction qui affiche le classement :

CREATE FUNCTION get_classement

DECLARE 
	CURSOR c IS SELECT prenom,nom,nbPoint 
				FROM COMBATTANT 
				ORDER BY nbPoint;

BEGIN
	FOR item IN c LOOP
		dbms_output.put_line('nom = ' || item.nom || ', prenom = ' || item.prenom || ', nombre de point = ' || item.nbPoint );
	END LOOP;
END;
/
