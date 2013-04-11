INSERT INTO finspecies (username, datetime, ipaddress, speciesid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'DINHEIRO');
INSERT INTO finspecies (username, datetime, ipaddress, speciesid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'CHEQUE');
SELECT setval('seq_speciesid',(SELECT max(speciesid) FROM finSpecies));
