INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'ESTÁGIO');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ESTUDOS');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'PALESTRA');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 4, 'SEMINÁRIO');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 5, 'MISSÃO');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 6, 'PROGRAMA DE BOLSA');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 7, 'VIAGEM DE ESTUDOS');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 8, 'DOCÊNCIA');
SELECT setval('seq_interchangetypeid',(SELECT max(interchangetypeid) FROM acdInterchangeType));
