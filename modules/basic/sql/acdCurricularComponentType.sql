INSERT INTO acdcurricularcomponenttype (username, datetime, ipaddress, curricularcomponenttypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'DISCIPLINA');
INSERT INTO acdcurricularcomponenttype (username, datetime, ipaddress, curricularcomponenttypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ESTÁGIO');
INSERT INTO acdcurricularcomponenttype (username, datetime, ipaddress, curricularcomponenttypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'ELETIVA');
SELECT setval('seq_curricularcomponenttypeid',(SELECT max(curricularcomponenttypeid) FROM acdCurricularComponentType));
