INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'EST�GIO');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ESTUDOS');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'PALESTRA');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 4, 'SEMIN�RIO');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 5, 'MISS�O');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 6, 'PROGRAMA DE BOLSA');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 7, 'VIAGEM DE ESTUDOS');
INSERT INTO acdinterchangetype (username, datetime, ipaddress, interchangetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 8, 'DOC�NCIA');
SELECT setval('seq_interchangetypeid',(SELECT max(interchangetypeid) FROM acdInterchangeType));
