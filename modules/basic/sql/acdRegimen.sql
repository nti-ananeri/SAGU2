INSERT INTO acdregimen (username, datetime, ipaddress, regimenid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'REGIME NORMAL');
INSERT INTO acdregimen (username, datetime, ipaddress, regimenid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'REGIME ESPECIAL');
SELECT setval('seq_regimenid',(SELECT max(regimenid) FROM acdRegimen));
