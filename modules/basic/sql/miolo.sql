create table miolo_sequence ( 
       sequence                      character(30)       not null primary key,
       value                         integer);
INSERT INTO miolo_sequence VALUES('seq_miolo_user',16);
INSERT INTO miolo_sequence VALUES('seq_miolo_transaction',7);
INSERT INTO miolo_sequence VALUES('seq_miolo_group',27);
INSERT INTO miolo_sequence VALUES('seq_miolo_session',0);
INSERT INTO miolo_sequence VALUES('seq_miolo_log',0);
create table miolo_user ( 
       iduser                        integer        not null primary key,
       login                         character(25),
       name                          character(80),
       nickname                      character(25),
       m_password                      character(40),
       confirm_hash                  character(40),
       theme                         character(20));
INSERT INTO miolo_user VALUES(1,'sagu2','Usuario padrao do sagu2','Sagu2','sagu2','3d7197b8e3a76fbca3981773ac418a0b','miolo');
create table miolo_transaction ( 
       idtransaction                 integer        not null primary key,
       m_transaction                   character(30));
INSERT INTO miolo_transaction VALUES(1,'ADMIN');
INSERT INTO miolo_transaction VALUES(2,'USER');
INSERT INTO miolo_transaction VALUES(3,'GROUP');
INSERT INTO miolo_transaction VALUES(4,'LOG');
INSERT INTO miolo_transaction VALUES(5,'TRANSACTION');
INSERT INTO miolo_transaction VALUES(6,'ACCOUNTANCY');
INSERT INTO miolo_transaction VALUES(7,'ACADEMIC');
INSERT INTO miolo_transaction VALUES(8,'BASIC');
INSERT INTO miolo_transaction VALUES(9,'CONTROLCOPIES');
INSERT INTO miolo_transaction VALUES(10,'FINANCE');
INSERT INTO miolo_transaction VALUES(11,'HUMANRESOURCES');
INSERT INTO miolo_transaction VALUES(12,'INSTITUTIONAL');
INSERT INTO miolo_transaction VALUES(13,'RESEARCH');
INSERT INTO miolo_transaction VALUES(14,'SELECTIVEPROCESS');
INSERT INTO miolo_transaction VALUES(15,'SERVICES');
INSERT INTO miolo_transaction VALUES(16,'PROTOCOL');
create table miolo_group ( 
       idgroup                       integer        not null primary key,
       m_group                         character(50));
INSERT INTO miolo_group VALUES(1,'ADMIN');
INSERT INTO miolo_group VALUES(2,'MAIN_RO');
INSERT INTO miolo_group VALUES(3,'MAIN_RW');
INSERT INTO miolo_group VALUES(4,'BASICO');
INSERT INTO miolo_group VALUES(5,'CONTABIL');
INSERT INTO miolo_group VALUES(6,'ACADEMICO');
INSERT INTO miolo_group VALUES(7,'PROCESSO SELETIVO');
INSERT INTO miolo_group VALUES(8,'CONTROLE DE COPIAS');
INSERT INTO miolo_group VALUES(9,'FINANCEIRO');
INSERT INTO miolo_group VALUES(10,'RECURSOS HUMANOS');
INSERT INTO miolo_group VALUES(11,'INSTITUCIONAL');
INSERT INTO miolo_group VALUES(12,'QUESTIONARIO');
INSERT INTO miolo_group VALUES(13,'SERVICOS');
INSERT INTO miolo_group VALUES(14,'BASICO - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(15,'CONTABIL - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(16,'PROCESSO SELETIVO - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(17,'ACADEMICO - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(18,'CONTROLE DE COPIAS - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(19,'FINANCEIRO - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(20,'RECURSOS HUMANOS - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(21,'INSTITUCIONAL - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(22,'QUESTIONARIO - ADMINISTRADOR');
INSERT INTO miolo_group VALUES(23,'ACADEMICO - MATRICULA');
INSERT INTO miolo_group VALUES(24,'FINANCEIRO - GERAR PREVISOES');
INSERT INTO miolo_group VALUES(25,'CONTABIL - LIMITES CONTABEIS');
INSERT INTO miolo_group VALUES(26,'PROCESSO SELETIVO - INSCRICAO');
create table miolo_access ( 
       idgroup                       integer        not null,
       idtransaction                 integer        not null,
       rights                        integer);
INSERT INTO miolo_access VALUES(1,1,31);
INSERT INTO miolo_access VALUES(2,1,1);
INSERT INTO miolo_access VALUES(2,2,1);
INSERT INTO miolo_access VALUES(2,3,1);
INSERT INTO miolo_access VALUES(2,4,1);
INSERT INTO miolo_access VALUES(2,5,1);
INSERT INTO miolo_access VALUES(3,1,15);
INSERT INTO miolo_access VALUES(3,2,15);
INSERT INTO miolo_access VALUES(3,3,15);
INSERT INTO miolo_access VALUES(3,4,15);
INSERT INTO miolo_access VALUES(3,5,15);
INSERT INTO miolo_access VALUES(4,8,141);
INSERT INTO miolo_access VALUES(4,8,144);
INSERT INTO miolo_access VALUES(4,8,143);
INSERT INTO miolo_access VALUES(4,8,142);
INSERT INTO miolo_access VALUES(5,6,101);
INSERT INTO miolo_access VALUES(5,6,104);
INSERT INTO miolo_access VALUES(5,6,102);
INSERT INTO miolo_access VALUES(5,6,103);
INSERT INTO miolo_access VALUES(7,14,261);
INSERT INTO miolo_access VALUES(7,14,264);
INSERT INTO miolo_access VALUES(7,14,262);
INSERT INTO miolo_access VALUES(7,14,263);
INSERT INTO miolo_access VALUES(8,9,161);
INSERT INTO miolo_access VALUES(8,9,164);
INSERT INTO miolo_access VALUES(8,9,162);
INSERT INTO miolo_access VALUES(8,9,163);
INSERT INTO miolo_access VALUES(9,10,181);
INSERT INTO miolo_access VALUES(9,10,184);
INSERT INTO miolo_access VALUES(9,10,182);
INSERT INTO miolo_access VALUES(9,10,183);
INSERT INTO miolo_access VALUES(10,11,203);
INSERT INTO miolo_access VALUES(10,11,202);
INSERT INTO miolo_access VALUES(10,11,204);
INSERT INTO miolo_access VALUES(10,11,201);
INSERT INTO miolo_access VALUES(11,12,223);
INSERT INTO miolo_access VALUES(11,12,222);
INSERT INTO miolo_access VALUES(11,12,224);
INSERT INTO miolo_access VALUES(11,12,221);
INSERT INTO miolo_access VALUES(12,13,241);
INSERT INTO miolo_access VALUES(12,13,243);
INSERT INTO miolo_access VALUES(12,13,242);
INSERT INTO miolo_access VALUES(12,13,244);
INSERT INTO miolo_access VALUES(13,15,281);
INSERT INTO miolo_access VALUES(17,7,125);
INSERT INTO miolo_access VALUES(14,8,145);
INSERT INTO miolo_access VALUES(15,6,105);
INSERT INTO miolo_access VALUES(16,14,265);
INSERT INTO miolo_access VALUES(18,9,165);
INSERT INTO miolo_access VALUES(19,10,185);
INSERT INTO miolo_access VALUES(19,10,186);
INSERT INTO miolo_access VALUES(20,11,205);
INSERT INTO miolo_access VALUES(21,12,225);
INSERT INTO miolo_access VALUES(22,13,245);
INSERT INTO miolo_access VALUES(23,7,126);
INSERT INTO miolo_access VALUES(24,10,186);
INSERT INTO miolo_access VALUES(25,6,106);
INSERT INTO miolo_access VALUES(26,14,266);
INSERT INTO miolo_access VALUES(27,7,123);
INSERT INTO miolo_access VALUES(27,7,124);
INSERT INTO miolo_access VALUES(27,7,127);
INSERT INTO miolo_access VALUES(6,7,121);
INSERT INTO miolo_access VALUES(6,7,122);
INSERT INTO miolo_access VALUES(6,7,123);
INSERT INTO miolo_access VALUES(6,7,124);
create table miolo_session ( 
       idsession                     integer        not null primary key,
       tsin                          character(15),
       tsout                         character(15),
       name                          character(50),
       sid                           character(40),
       forced                        character(1),
       remoteaddr                    character(15),
       iduser                        integer        not null);
create table miolo_log ( 
       idlog                         integer        not null primary key,
       m_timestamp                     character(15),
       description                   character(200),
       module                        character(25),
       class                         character(25),
       iduser                        integer        not null,
       idtransaction                 integer        not null);
create table miolo_groupuser ( 
       iduser                        integer        not null,
       idgroup                       integer        not null);
INSERT INTO miolo_groupuser VALUES(12,5);
INSERT INTO miolo_groupuser VALUES(12,6);
INSERT INTO miolo_groupuser VALUES(1,1);
INSERT INTO miolo_groupuser VALUES(1,2);
INSERT INTO miolo_groupuser VALUES(1,3);
INSERT INTO miolo_groupuser VALUES(1,4);
INSERT INTO miolo_groupuser VALUES(1,5);
INSERT INTO miolo_groupuser VALUES(1,6);
INSERT INTO miolo_groupuser VALUES(1,7);
INSERT INTO miolo_groupuser VALUES(1,8);
INSERT INTO miolo_groupuser VALUES(1,9);
INSERT INTO miolo_groupuser VALUES(1,10);
INSERT INTO miolo_groupuser VALUES(1,11);
INSERT INTO miolo_groupuser VALUES(1,12);
INSERT INTO miolo_groupuser VALUES(1,13);
INSERT INTO miolo_groupuser VALUES(1,14);
INSERT INTO miolo_groupuser VALUES(1,15);
INSERT INTO miolo_groupuser VALUES(1,16);
INSERT INTO miolo_groupuser VALUES(1,17);
INSERT INTO miolo_groupuser VALUES(1,18);
INSERT INTO miolo_groupuser VALUES(1,19);
INSERT INTO miolo_groupuser VALUES(1,20);
INSERT INTO miolo_groupuser VALUES(1,21);
INSERT INTO miolo_groupuser VALUES(1,22);
INSERT INTO miolo_groupuser VALUES(1,23);
INSERT INTO miolo_groupuser VALUES(1,24);
INSERT INTO miolo_groupuser VALUES(1,25);
INSERT INTO miolo_groupuser VALUES(1,26);
INSERT INTO miolo_groupuser VALUES(15,4);
INSERT INTO miolo_groupuser VALUES(15,6);
INSERT INTO miolo_groupuser VALUES(15,17);
INSERT INTO miolo_groupuser VALUES(15,14);
INSERT INTO miolo_groupuser VALUES(15,27);
INSERT INTO miolo_groupuser VALUES(15,1);
INSERT INTO miolo_groupuser VALUES(15,2);
INSERT INTO miolo_groupuser VALUES(15,3);
CREATE TABLE miolo_module
(
    idModule varchar(40) primary key,
    name varchar(100),
    description text
);
INSERT INTO miolo_module VALUES('admin',NULL,NULL);
INSERT INTO miolo_module VALUES('common',NULL,NULL);
INSERT INTO miolo_module VALUES('helloworld',NULL,NULL);
INSERT INTO miolo_module VALUES('hangman',NULL,NULL);
INSERT INTO miolo_module VALUES('tutorial',NULL,NULL);
INSERT INTO miolo_module VALUES('academic',NULL,NULL);
