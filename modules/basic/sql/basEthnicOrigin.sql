INSERT INTO basethnicorigin (username, datetime, ipaddress, ethnicoriginid, description) VALUES ('admin', date(now()), '127.0.0.1', 0, 'NÃO INFORMADO');
INSERT INTO basethnicorigin (username, datetime, ipaddress, ethnicoriginid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'BRANCO');
INSERT INTO basethnicorigin (username, datetime, ipaddress, ethnicoriginid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'PARDO/MULATO');
INSERT INTO basethnicorigin (username, datetime, ipaddress, ethnicoriginid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'NEGRO');
INSERT INTO basethnicorigin (username, datetime, ipaddress, ethnicoriginid, description) VALUES ('admin', date(now()), '127.0.0.1', 4, 'AMARELO');
INSERT INTO basethnicorigin (username, datetime, ipaddress, ethnicoriginid, description) VALUES ('admin', date(now()), '127.0.0.1', 5, 'INDÍGENA');
INSERT INTO basethnicorigin (username, datetime, ipaddress, ethnicoriginid, description) VALUES ('admin', date(now()), '127.0.0.1', 6, 'NÃO QUERO DECLARAR');
SELECT setval('seq_ethnicoriginid',(SELECT max(ethnicoriginid) FROM basEthnicOrigin));
