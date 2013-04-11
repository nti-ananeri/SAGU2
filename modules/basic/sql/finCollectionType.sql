INSERT INTO fincollectiontype (username, datetime, ipaddress, collectiontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'SIMPLES');
INSERT INTO fincollectiontype (username, datetime, ipaddress, collectiontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'COM REGISTRO');
INSERT INTO fincollectiontype (username, datetime, ipaddress, collectiontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 4, 'COBRANCA INTERNA');
SELECT setval('seq_collectiontypeid',(SELECT max(collectiontypeid) FROM finCollectionType));
