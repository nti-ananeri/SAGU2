INSERT INTO ptcsituation (username, datetime, ipaddress, situationid, description, "type", policy) VALUES ('admin', '2004-11-11 16:03:56.222262-02', NULL, 1, 'DEFERIDO', '{R}', NULL);
INSERT INTO ptcsituation (username, datetime, ipaddress, situationid, description, "type", policy) VALUES ('admin', '2005-03-11 10:41:51.99513-03', '127.0.0.1', 2, 'INDEFERIDO', '{R}', 'O');
INSERT INTO ptcsituation (username, datetime, ipaddress, situationid, description, "type", policy) VALUES ('admin', '2005-03-11 10:41:41.144881-03', '127.0.0.1', 3, 'EM ANDAMENTO', '{P,R}', 'I');
INSERT INTO ptcsituation (username, datetime, ipaddress, situationid, description, "type", policy) VALUES ('admin', '2005-03-11 10:41:35.021407-03', '127.0.0.1', 5, 'CANCELADO', '{P,R}', 'O');
INSERT INTO ptcsituation (username, datetime, ipaddress, situationid, description, "type", policy) VALUES ('admin', '2005-03-11 11:30:31.427588-03', '127.0.0.1', 6, 'CONCLUIDO', '{P}', 'O');
SELECT setval('seq_situationId',(SELECT max(situationid) FROM ptcsituation));
