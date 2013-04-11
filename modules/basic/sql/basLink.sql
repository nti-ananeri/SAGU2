INSERT INTO baslink (username, datetime, ipaddress, linkid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'ALUNOS');
INSERT INTO baslink (username, datetime, ipaddress, linkid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'FORMANDOS');
INSERT INTO baslink (username, datetime, ipaddress, linkid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'COMUNIDADE');
INSERT INTO baslink (username, datetime, ipaddress, linkid, description) VALUES ('admin', date(now()), '127.0.0.1', 4, 'FUNCIONÁRIOS');
INSERT INTO baslink (username, datetime, ipaddress, linkid, description) VALUES ('admin', date(now()), '127.0.0.1', 5, 'PROFESSORES');
INSERT INTO baslink (username, datetime, ipaddress, linkid, description) VALUES ('admin', date(now()), '127.0.0.1', 6, 'OPERADORES');
SELECT setval('seq_linkid',(SELECT max(linkid) FROM basLink));
