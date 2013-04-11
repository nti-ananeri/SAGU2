INSERT INTO baslegalpersontype (username, datetime, ipaddress, legalpersontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'EMPRESA');
INSERT INTO baslegalpersontype (username, datetime, ipaddress, legalpersontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'INSTITUIÇÕES');
SELECT setval('seq_legalpersontypeid',(SELECT max(legalpersontypeid) FROM basLegalPersonType));
