INSERT INTO acdcomplementaryactivitiescategory (username, datetime, ipaddress, complementaryactivitiescategoryid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'ENSINO');
INSERT INTO acdcomplementaryactivitiescategory (username, datetime, ipaddress, complementaryactivitiescategoryid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'EXTENSÃO');
INSERT INTO acdcomplementaryactivitiescategory (username, datetime, ipaddress, complementaryactivitiescategoryid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'PESQUISA');
SELECT setval('seq_complementaryactivitiescategoryid',(SELECT max(complementaryactivitiescategoryid) FROM acdcomplementaryactivitiescategory));
