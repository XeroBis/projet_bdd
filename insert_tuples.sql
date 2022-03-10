/*
COMBATTANT
COACH
ARBITRE
LIEU
TOURNOIS
*/
CREATE SEQUENCE sequenceCleCoach START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE sequenceCleCombattant START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE sequenceCleLieu START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE sequenceCleArbitre START WITH 1 INCREMENT BY 1;

INSERT INTO COACH VALUES(sequenceCleCoach.nextval, 'Jean', 'Jacques', 'LES BG');
INSERT INTO COACH VALUES(sequenceCleCoach.nextval, 'Nathan', 'Boite', 'Big Boom');
INSERT INTO COACH VALUES(sequenceCleCoach.nextval, 'Coralie', 'Makaise', 'fleurs');
INSERT INTO COACH VALUES(sequenceCleCoach.nextval, 'Owen', 'Marron', 'CRIEUR');
INSERT INTO COACH VALUES(sequenceCleCoach.nextval, 'Alan', 'Hector', 'Winners');

INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'Pierre', 'Paul', 5, null);
INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'Marc', 'Paul', 5, null);
INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'Jules', 'rjx', 2, null);
INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'Pierre', 'Alexandre', 3, null);
INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'Vladimir', 'olga', 4, null);
INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'César', 'Pl', 2, null);
INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'Jolyne', 'Jojo', 1, null);
INSERT INTO COMBATTANT VALUES (sequenceCleCombattant.nextval, 'Jonathan', 'Joeystar', 1, null);

INSERT INTO LIEU VALUES (sequenceCleLieu.nextval, 'Gymnase du Lycée Aubrac', 'France', 'Aubervilliers', 'Rue de la jeunesse', 2);
INSERT INTO LIEU VALUES (sequenceCleLieu.nextval, 'Stade de France', 'France', 'Paris', 'Rue du sport', 6);
INSERT INTO LIEU VALUES (sequenceCleLieu.nextval, 'Stade du Vélodrome', 'France', 'Marseille', 'Rue de la commanderie', 25);
INSERT INTO LIEU VALUES (sequenceCleLieu.nextval, 'Coin de la Rue', 'Italie', 'Turin', 'Rue de impasse', 42);

INSERT INTO ARBITRE VALUES (sequenceCleArbitre.nextval, 'Hugo', 'Latronch');
INSERT INTO ARBITRE VALUES (sequenceCleArbitre.nextval, 'William', 'Burk');
INSERT INTO ARBITRE VALUES (sequenceCleArbitre.nextval, 'Creed', 'Tronl');

INSERT INTO TOURNOIS VALUES (1, 1, 2, 1, 2,to_date('01-03-2035','dd-mm-yyyy'),2,2);
INSERT INTO TOURNOIS VALUES (1, 3, 4, 3, 2,to_date('01-03-2035','dd-mm-yyyy'),3,2);
INSERT INTO TOURNOIS VALUES (1, 1, 3, 3, 1,to_date('05-03-2035','dd-mm-yyyy'),4,1);


INSERT INTO TOURNOIS VALUES (2, 2, 5, 5, 1,to_date('10-03-2035','dd-mm-yyyy'),1,4);
INSERT INTO TOURNOIS VALUES (2, 8, 6, 8, 2,to_date('11-03-2035','dd-mm-yyyy'),2,4);
INSERT INTO TOURNOIS VALUES (2, 7, 3, 3, 3,to_date('12-03-2035','dd-mm-yyyy'),4,4);
INSERT INTO TOURNOIS VALUES (2, 1, 4, 1, 1,to_date('13-03-2035','dd-mm-yyyy'),3,4);


INSERT INTO TOURNOIS VALUES (2, 5, 8, 8, 2,to_date('14-03-2035','dd-mm-yyyy'),4,2);
INSERT INTO TOURNOIS VALUES (2, 3, 1, 3, 1,to_date('10-03-2035','dd-mm-yyyy'),2,2);

INSERT INTO TOURNOIS VALUES (2, 8, 3, 8, 3,to_date('10-03-2035','dd-mm-yyyy'),1,1);
