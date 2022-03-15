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
-- to test :
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
    
    IF ((roundAvantRouge == 0) || (roundAvantBleu == 0)) THEN
      RAISE_APPLICATION_ERROR( -20002, 'Combattant rouge ou bleu n a pas gagne dans le round precedent');
    END IF;
  END IF;
END;
/
SHOW ERROR;
