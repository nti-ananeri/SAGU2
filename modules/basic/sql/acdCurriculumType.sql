INSERT INTO acdcurriculumtype (username, datetime, ipaddress, curriculumtypeid, description, shortdescription) VALUES ('admin', date(now()), '127.0.0.1', 1, 'ATIVIDADE COMPLEMENTAR', 'A');
INSERT INTO acdcurriculumtype (username, datetime, ipaddress, curriculumtypeid, description, shortdescription) VALUES ('admin', date(now()), '127.0.0.1', 2, 'COMPLEMENTAR', 'C');
INSERT INTO acdcurriculumtype (username, datetime, ipaddress, curriculumtypeid, description, shortdescription) VALUES ('admin', date(now()), '127.0.0.1', 3, 'DEMONSTRATIVO DA INTEGRALIZA��O CURRICULAR', 'D');
INSERT INTO acdcurriculumtype (username, datetime, ipaddress, curriculumtypeid, description, shortdescription) VALUES ('admin', date(now()), '127.0.0.1', 4, 'COMPLEMENTA��O CARGA HOR�RIA', 'H');
INSERT INTO acdcurriculumtype (username, datetime, ipaddress, curriculumtypeid, description, shortdescription) VALUES ('admin', date(now()), '127.0.0.1', 5, 'M�NIMO', 'M');
INSERT INTO acdcurriculumtype (username, datetime, ipaddress, curriculumtypeid, description, shortdescription) VALUES ('admin', date(now()), '127.0.0.1', 6, 'OPTATIVA', 'O');
INSERT INTO acdcurriculumtype (username, datetime, ipaddress, curriculumtypeid, description, shortdescription) VALUES ('admin', date(now()), '127.0.0.1', 7, 'PROFICI�NCIA', 'P');
SELECT setval('seq_curriculumtypeid',(SELECT max(curriculumtypeid) FROM acdCurriculumType));
