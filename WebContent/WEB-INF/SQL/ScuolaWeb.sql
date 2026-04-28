# creazione database
create database scuola;

# seleaziona il database
use database scuola;

# CREAZIONE TABELLE
create or replace table amministratori(
	aid int auto_increment not null,
	email varchar(80) not null,
	password varchar(80) not null,
	primary key (aid),
	unique key (email)
);

create or replace table docenti(
	did int auto_increment not null,
	email varchar(80) not null,
	password varchar(80) not null,
	nome varchar(80) not null,
	cognome varchar(80) not null,
	primary key (did),
	unique key (email)
);

create or replace table classi(
	cid int auto_increment not null,
	anno int not null,
	sezione varchar(3) not null,
	primary key (cid),
	unique key (anno, sezione),
	check (anno >= 1 and anno <= 5)
);

create or replace table studenti(
	sid int auto_increment not null,
	email varchar(80) not null,
	password varchar(80) not null,
	nome varchar(80) not null,
	cognome varchar(80) not null,
	nascita date not null,
	cid int not null,
	primary key (sid),
	unique key (email),
	foreign key (cid) references classi (cid) on update cascade on delete cascade
);

create or replace table voti(
	vid int auto_increment not null,
	voto int not null,
	materia varchar(80) not null,
	data date not null,
	did int not null,
	sid int not null,
	primary key (vid),
	check (voto >= 1 and voto <= 10),
	foreign key (did) references docenti (did) on update cascade on delete cascade,
	foreign key (sid) references studenti (sid) on update cascade on delete cascade
);

create or replace table materie(
	cid int not null,
	did int not null,
	materia varchar(80) not null,
	primary key (cid, did, materia),
	foreign key (cid) references classi (cid) on update cascade on delete cascade,
	foreign key (did) references docenti (did) on update cascade on delete cascade
);

#INSERTS
INSERT INTO amministratori (email, password)
VALUES ('direzione@scuola.it', 'admin');

INSERT INTO docenti (email, password, nome, cognome) VALUES
('m.conti@scuola.it','A7!dkP9#qL','Matteo','Conti'),
('l.greco@scuola.it','Zx3@Lm8!Rt','Laura','Greco'),
('f.rinaldi@scuola.it','Qw9#Bn2$Ye','Francesco','Rinaldi'),
('c.mancini@scuola.it','Lp4!Ts7@Ka','Chiara','Mancini'),
('a.moretti@scuola.it','Mn8@Qw3!Zd','Alessandro','Moretti'),
('s.lombardi@scuola.it','Rt6#Yp1!Xs','Silvia','Lombardi'),
('d.barone@scuola.it','Uv2!Ke9@Wp','Davide','Barone'),
('g.ferraro@scuola.it','Pl7@Cx4!Vm','Giulia','Ferraro'),
('e.martini@scuola.it','Kd3!Nz8@Qa','Elisa','Martini'),
('r.santoro@scuola.it','Wx5@Lm1!Tr','Roberto','Santoro');

INSERT INTO classi (anno, sezione) VALUES
(1,'A'),(1,'B'),
(2,'A'),(2,'B'),
(3,'A'),(3,'B'),
(4,'A'),(4,'B'),
(5,'A'),(5,'B');


INSERT INTO materie (cid, did, materia) VALUES
(1,1,'Matematica'),
(1,2,'Italiano'),
(1,3,'Inglese'),
(1,4,'Storia'),
(1,5,'Scienze'),
(1,6,'Informatica'),
(1,7,'Geografia'),
(1,8,'Arte'),
(1,9,'Educazione Fisica'),
(2,1,'Matematica'),
(2,2,'Italiano'),
(2,3,'Inglese'),
(2,4,'Storia'),
(2,5,'Scienze'),
(2,6,'Informatica'),
(2,7,'Geografia'),
(2,8,'Arte'),
(2,9,'Educazione Fisica'),
(3,1,'Matematica'),
(3,2,'Italiano'),
(3,3,'Inglese'),
(3,4,'Storia'),
(3,5,'Scienze'),
(3,6,'Informatica'),
(3,7,'Geografia'),
(3,8,'Arte'),
(3,9,'Educazione Fisica'),
(4,1,'Matematica'),
(4,2,'Italiano'),
(4,3,'Inglese'),
(4,4,'Storia'),
(4,5,'Scienze'),
(4,6,'Informatica'),
(4,7,'Geografia'),
(4,8,'Arte'),
(4,9,'Educazione Fisica'),
(5,1,'Matematica'),
(5,2,'Italiano'),
(5,3,'Inglese'),
(5,4,'Storia'),
(5,10,'Fisica'),
(5,6,'Informatica'),
(5,8,'Arte'),
(5,9,'Educazione Fisica'),
(6,1,'Matematica'),
(6,2,'Italiano'),
(6,3,'Inglese'),
(6,4,'Storia'),
(6,10,'Fisica'),
(6,6,'Informatica'),
(6,8,'Arte'),
(6,9,'Educazione Fisica'),
(7,1,'Matematica'),
(7,2,'Italiano'),
(7,3,'Inglese'),
(7,4,'Storia'),
(7,10,'Fisica'),
(7,6,'Informatica'),
(7,8,'Arte'),
(7,9,'Educazione Fisica'),
(8,1,'Matematica'),
(8,2,'Italiano'),
(8,3,'Inglese'),
(8,4,'Storia'),
(8,10,'Fisica'),
(8,6,'Informatica'),
(8,8,'Arte'),
(8,9,'Educazione Fisica'),
(9,1,'Matematica'),
(9,2,'Italiano'),
(9,3,'Inglese'),
(9,4,'Storia'),
(9,10,'Fisica'),
(9,6,'Informatica'),
(9,8,'Arte'),
(9,9,'Educazione Fisica'),
(10,1,'Matematica'),
(10,2,'Italiano'),
(10,3,'Inglese'),
(10,4,'Storia'),
(10,10,'Fisica'),
(10,6,'Informatica'),
(10,8,'Arte'),
(10,9,'Educazione Fisica');

INSERT INTO studenti (email, password, nome, cognome, nascita, cid) VALUES
('luca.rossi@scuola.it','K!3pLs9@Wx','Luca','Rossi','2010-02-14',1),
('marco.bianchi@scuola.it','Zx8@Q!2LmP','Marco','Bianchi','2010-06-21',2),
('giulia.verdi@scuola.it','T!7kP2#sDd','Giulia','Verdi','2009-11-03',3),
('anna.neri@scuola.it','Qp3@L!9ZxA','Anna','Neri','2009-01-30',4),
('paolo.galli@scuola.it','V!2Lm8@Qwe','Paolo','Galli','2008-09-12',5),
('sara.costa@scuola.it','N#4pT!7sXc','Sara','Costa','2008-03-18',6),
('davide.ferrari@scuola.it','Y!8Qw2@LpZ','Davide','Ferrari','2007-07-09',7),
('elena.romano@scuola.it','Jk!3Lm9@Px','Elena','Romano','2007-12-01',8),
('simone.ricci@scuola.it','W!2pLs8@Qr','Simone','Ricci','2006-05-25',9),
('chiara.marino@scuola.it','P!9Lm3@Qaz','Chiara','Marino','2006-08-14',10),
('gabriele.conti@scuola.it','X!7sLp2@Zm','Gabriele','Conti','2010-04-11',1),
('sofia.greco@scuola.it','C!2Lm8@Pqa','Sofia','Greco','2010-10-22',2),
('lorenzo.rinaldi@scuola.it','D!4pZx9@Ws','Lorenzo','Rinaldi','2009-02-02',3),
('aurora.mancini@scuola.it','F!8Lm1@Qwe','Aurora','Mancini','2009-06-06',4),
('matteo.moretti@scuola.it','G!3sLp7@Az','Matteo','Moretti','2008-09-29',5),
('chiara.lombardi@scuola.it','H!6Lm2@Qzx','Chiara','Lombardi','2008-01-19',6),
('davide.barone@scuola.it','J!9pLs4@Wx','Davide','Barone','2007-03-07',7),
('giulia.ferraro@scuola.it','K!2Lm8@Qaz','Giulia','Ferraro','2007-11-13',8),
('martina.martini@scuola.it','L!5pLs1@Qwe','Martina','Martini','2006-12-05',9),
('edoardo.santoro@scuola.it','M!8Lm3@Qzx','Edoardo','Santoro','2006-07-27',10),
('alessio.rizzo@scuola.it','N!2pLs9@Qwe','Alessio','Rizzo','2010-01-15',1),
('francesca.leone@scuola.it','O!4Lm7@Qzx','Francesca','Leone','2010-02-20',2),
('nicolo.guerra@scuola.it','P!6pLs2@Qaz','Nicolo','Guerra','2009-03-30',3),
('valentina.parisi@scuola.it','Q!8Lm1@Qwe','Valentina','Parisi','2009-04-10',4),
('tommaso.coppola@scuola.it','R!3pLs6@Qzx','Tommaso','Coppola','2008-05-22',5),
('luca.deangelis@scuola.it','S!7Lm4@Qaz','Luca','De Angelis','2008-06-18',6),
('silvia.messina@scuola.it','T!2pLs8@Qwe','Silvia','Messina','2007-07-09',7),
('andrea.longo@scuola.it','U!5Lm3@Qzx','Andrea','Longo','2007-08-14',8),
('marta.vitali@scuola.it','V!9pLs1@Qaz','Marta','Vitali','2006-09-27',9),
('riccardo.basili@scuola.it','W!6Lm2@Qwe','Riccardo','Basili','2006-10-31',10),
('alessandro.ferrari@scuola.it','A!7kLp2@Qz','Alessandro','Ferrari','2010-03-12',1),
('beatrice.galli@scuola.it','B!3mQw8@Lp','Beatrice','Galli','2010-05-21',2),
('carmine.russo@scuola.it','C!9pLs4@Xz','Carmine','Russo','2009-10-02',3),
('daria.conti@scuola.it','D!2Lm7@Qw','Daria','Conti','2009-01-18',4),
('edoardo.mancini@scuola.it','E!5pLs1@Az','Edoardo','Mancini','2008-06-09',5),
('federica.rinaldi@scuola.it','F!8Lm3@Qz','Federica','Rinaldi','2008-09-14',6),
('giorgio.moretti@scuola.it','G!4pLs9@Qw','Giorgio','Moretti','2007-11-30',7),
('hannah.lombardi@scuola.it','H!6Lm2@Xz','Hannah','Lombardi','2008-02-11',8),
('ignazio.barone@scuola.it','I!3pLs7@Qw','Ignazio','Barone','2006-04-27',9),
('jessica.ferraro@scuola.it','J!9Lm1@Az','Jessica','Ferraro','2006-07-03',10),
('karl.romano@scuola.it','K!2pLs8@Qw','Karl','Romano','2010-08-19',1),
('ludovica.ricci@scuola.it','L!5Lm4@Qz','Ludovica','Ricci','2010-12-22',2),
('matilde.marino@scuola.it','M!7pLs2@Xz','Matilde','Marino','2009-01-08',3),
('nicola.greco@scuola.it','N!4Lm9@Qw','Nicola','Greco','2009-03-15',4),
('olivia.rizzo@scuola.it','O!6pLs1@Az','Olivia','Rizzo','2008-05-29',5),
('pietro.leone@scuola.it','P!8Lm3@Qw','Pietro','Leone','2008-06-06',6),
('quinto.guerra@scuola.it','Q!2pLs7@Xz','Quinto','Guerra','2007-09-17',7),
('raffaella.parisi@scuola.it','R!5Lm8@Qw','Raffaella','Parisi','2007-10-24',8),
('sergio.coppola@scuola.it','S!3pLs4@Az','Sergio','Coppola','2006-12-05',9),
('teresina.deangelis@scuola.it','T!9Lm1@Qz','Teresina','De Angelis','2006-02-28',10),
('ugo.messina@scuola.it','U!6pLs2@Qw','Ugo','Messina','2010-04-14',1),
('valerio.longo@scuola.it','V!8Lm7@Xz','Valerio','Longo','2010-06-30',2),
('wanda.vitali@scuola.it','W!2pLs9@Qw','Wanda','Vitali','2009-09-11',3),
('xenia.basili@scuola.it','X!4Lm1@Az','Xenia','Basili','2009-11-19',4),
('yuri.santoro@scuola.it','Y!7pLs3@Qz','Yuri','Santoro','2008-01-23',5),
('zaira.farina@scuola.it','Z!5Lm2@Qw','Zaira','Farina','2008-03-08',6),
('alba.rossi@scuola.it','A!8pLs1@Xz','Alba','Rossi','2007-05-16',7),
('bruno.bianchi@scuola.it','B!2Lm7@Qw','Bruno','Bianchi','2007-07-21',8),
('carla.verdi@scuola.it','C!6pLs4@Az','Carla','Verdi','2006-09-27',9),
('domenico.neri@scuola.it','D!9Lm3@Qz','Domenico','Neri','2006-12-02',10),
('emanuele.galli@scuola.it','E!3pLs8@Qw','Emanuele','Galli','2010-02-14',1),
('franco.conti@scuola.it','F!7Lm2@Xz','Franco','Conti','2010-04-18',2),
('gaia.mancini@scuola.it','G!5pLs1@Qz','Gaia','Mancini','2009-06-25',3),
('helena.rinaldi@scuola.it','H!2Lm9@Qw','Helena','Rinaldi','2009-08-09',4),
('ivan.moretti@scuola.it','I!8pLs3@Az','Ivan','Moretti','2008-10-13',5),
('jasmine.lombardi@scuola.it','J!6Lm4@Qz','Jasmine','Lombardi','2008-12-30',6),
('kevin.barone@scuola.it','K!3pLs7@Qw','Kevin','Barone','2007-03-05',7),
('lisa.ferraro@scuola.it','L!9Lm1@Xz','Lisa','Ferraro','2007-05-17',8),
('mario.romano@scuola.it','M!2pLs6@Qz','Mario','Romano','2006-07-22',9),
('noemi.ricci@scuola.it','N!8Lm3@Qw','Noemi','Ricci','2006-09-29',10);

# QUERY
select *
from amministratori;

select *
from docenti;

select *
from classi;

select *
from studenti;

select *
from voti;

select *
from materie;