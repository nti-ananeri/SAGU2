INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'MATRICULADO');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'APROVADO');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'REPROVADO');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 4, 'REPROVADO POR FALTAS');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 5, 'CANCELADA');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 6, 'DESISTENTE');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 7, 'DISPENSADO');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 8, 'DEPENDENTE');
INSERT INTO acdenrollstatus (username, datetime, ipaddress, statusid, description) VALUES ('admin', date(now()), '127.0.0.1', 9, 'DEPENDENTE POR FALTAS');
UPDATE acdEnrollStatus SET description = 'CR�DITO CONCEDIDO' WHERE statusid = 7;
SELECT setval('seq_statusid',(SELECT max(statusid) FROM acdEnrollStatus));
