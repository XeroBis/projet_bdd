CREATE OR REPLACE TRIGGER T_block_same_binome_b4_ins
BEFORE INSERT ON TOURNOIS
FOR EACH ROW
DECLARE
  id_tournoi NUMBER;
BEGIN
  SELECT count(idTournoi) into id_tournoi
  FROM TOURNOIS
  WHERE idTournoi = :new.idTournoi AND ((idCombRouge =:new.idCombRouge AND idCombBleu =  :new.idCombBleu) OR
    (idCombRouge = :new.idCombBleu AND idCombBleu = :new.idCombRouge));

  IF id_tournoi > 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Duo de combattant deja present dans le tournoi');
  END IF;
END;
/
SHOW ERROR;
-- insert INTO TOURNOIS VALUES(1,2,1,2,2,to_date('15-02-2035','dd-mm-yyyy'),3,2);
-- delete from TOURNOIS WHERE idTournoi =1 AND idCombRouge = 2 and idCombBleu = 1;
CREATE OR REPLACE TRIGGER T_block_ajout_non_gagnant
BEFORE INSERT ON TOURNOIS
FOR EACH ROW
DECLARE
  nbRoundAvant     NUMBER;
  roundAvantRouge  NUMBER;
  roundAvantBleu   NUMBER;
BEGIN
  SELECT count(idTournoi) INTO nbRoundAvant 
  FROM TOURNOIS 
  WHERE idTournoi = :new.idTournoi AND Round = :new.Round*2;
  IF nbRoundAvant > 1 THEN
    SELECT count(idTournoi) INTO roundAvantRouge 
    FROM TOURNOIS 
    WHERE idTournoi = :new.idTournoi AND Round = :new.Round*2 AND idGagnant = :new.idCombRouge;

    SELECT count(idTournoi) INTO roundAvantBleu 
    FROM TOURNOIS 
    WHERE idTournoi = :new.idTournoi AND Round = :new.Round*2 AND idGagnant = :new.idCombBleu;
    
    IF (roundAvantRouge = 0 OR roundAvantBleu = 0) THEN
      RAISE_APPLICATION_ERROR( -20002, 'Combattant rouge ou bleu n a pas gagné dans le round précédent');
    END IF;
  END IF;
END;
/
SHOW ERROR;
-- TO TEST :
-- INSERT INTO TOURNOIS VALUES(3, 1, 2, 1, 3, to_date('10-04-2036', 'dd-mm-yyyy'), 2, 2);
---- celle la marche, on crée un nouveau tournoi

-- INSERT INTO TOURNOIS VALUES(3, 3, 4, 3, 2, to_date('10-04-2036', 'dd-mm-yyyy'), 3, 2);
---- celle la marche, on ajoute un combat à ce même round

-- INSERT INTO TOURNOIS VALUES(3, 5, 6, 5, 1, to_date('11-04-2036', 'dd-mm-yyyy'), 2, 1);
--- celle la ne marche pas car aucune des combattants n'a gagné un round précédent

-- INSERT INTO TOURNOIS VALUES(3, 1, 7, 1, 1, to_date('12-04-2036', 'dd-mm-yyyy'), 2, 1);
---- celle la ne marche pas car le joueur 7 n'a pas gagné dans le round précédent.

-- INSERT INTO TOURNOIS VALUES(3, 6, 3, 6, 1, to_date('12-04-2036', 'dd-mm-yyyy'), 2, 1);
---- celle la ne marche pas car le joueur 6 n'a pas gagné dans un round précédent.

-- INSERT INTO TOURNOIS VALUES(3, 1, 3, 3, 1, to_date('12-04-2036', 'dd-mm-yyyy'), 2, 1);
---- celle la marche car les deux joueurs on gagné au round précédent

-- DELETE FROM TOURNOIS WHERE idTournoi =3 ;
