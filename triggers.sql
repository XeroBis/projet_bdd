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
BEFORE INSERT ON Tournoi
FOR EACH ROW
BEGIN
  IF EXISTS(SELECT * FROM Tournoi WHERE idTournoi = :new.idTournoi AND Round = :new.Round*2) THEN
    IF NOT EXISTS (SELECT * FROM Tournoi WHERE idTournoi = :new.idTournoi AND Round = :new.Round*2 AND (idCombRouge = :new.idCombRouge OR idCombBleu = :new.idCombRouge) THEN
       RAISE_APPLICATION_ERROR( -20002, 'Combattant rouge n\'a pas  gagné dans le round précédent' );
    ELSE
       IF NOT EXISTS (SELECT * FROM Tournoi WHERE idTournoi = :new.idTournoi AND Round = :new.Round*2 AND (idCombRouge = :new.idCombBleu OR idCombBleu = :new.idCombBleu) THEN
          RAISE_APPLICATION_ERROR( -20003, 'Combattant bleu n\'a pas  gagné dans le round précédent' );
       END IF;
    END IF;
 END IF;
END;
/
SHOW ERROR;
