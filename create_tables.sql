spool create_table.log

prompt *************************************************************
prompt ******************** DROP TABLE *****************************
prompt *************************************************************

DROP TABLE COMBATTANT CASCADE CONSTRAINTS;
DROP TABLE COACH CASCADE CONSTRAINTS;
DROP TABLE ARBITRE CASCADE CONSTRAINTS;
DROP TABLE LIEU CASCADE CONSTRAINTS;
DROP TABLE TOURNOIS CASCADE CONSTRAINTS;
DROP TABLE PROGRAMME CASCADE CONSTRAINTS;


prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************

CREATE TABLE COACH (
    idCoach     NUMBER,
    nom         VARCHAR2(20),
    prenom      VARCHAR2(20),
    nomClub     VARCHAR2(20),
    CONSTRAINTS pk_coach PRIMARY KEY (idCoach)
)


CREATE TABLE COMBATTANT (
    idComb      NUMBER,
    nom         VARCHAR2(20),
    prenom      VARCHAR2(20),
    idCoach     NUMBER,
    classement  NUMBER,
    CONSTRAINTS pk_combattant PRIMARY KEY (idComb)
    CONSTRAINTS fk_comb_coach FOREIGN KEY (idCoach) REFERENCES COACH(idCoach)
)

CREATE TABLE LIEU (
    idLieu      NUMBER,
    nomLieu     VARCHAR2(50),
    pays        VARCHAR2(20),
    ville       VARCHAR2(20),
    rue         VARCHAR2(40),
    numéro      NUMBER,
    CONSTRAINTS pk_lieu PRIMARY KEY (idLieu)
)

CREATE TABLE ARBITRE (
    idArbitre       NUMBER,
    nom             VARCHAR2(20),
    prenom          VARCHAR2(20),
    CONSTRAINTS pk_arbitre PRIMARY KEY (idArbitre)
)



CREATE TABLE TOURNOIS (
    idTournoi       NUMBER,
    idCombRouge     NUMBER,
    idCombBleu      NUMBER,
    idGagnant       NUMBER,
    idArbitre       NUMBER,
    jour            date,
    idLieu          NUMBER,
    CONSTRAINTS pk_tournoi PRIMARY KEY (idTournoi, idCombRouge, idCombBleu),
    CONSTRAINTS fk_tournoi_comb_rouge FOREIGN KEY idCombRouge REFERENCES COMBATTANT(idComb),
    CONSTRAINTS fk_tournoi_comb_bleu FOREIGN KEY idCombBleu REFERENCES COMBATTANT(idComb),
    CONSTRAINTS fk_tournoi_coach FOREIGN KEY idArbitre REFERENCES ARBITRE(idArbitre),
    CONSTRAINTS fk_tournoi_comb FOREIGN KEY idGagnant REFERENCES COMBATTANT(idComb)
)
