INSERT INTO basturn (username, datetime, ipaddress, turnid, description, shortdescription, beginhour, endhour, charid) VALUES ('admin', date(now()), '127.0.0.1', 1, 'MANHÃ', 'MAN', '08:20', '11:55', 'M');
INSERT INTO basturn (username, datetime, ipaddress, turnid, description, shortdescription, beginhour, endhour, charid) VALUES ('admin', date(now()), '127.0.0.1', 2, 'TARDE', 'TAR', '13:30', '17:00', 'T');
INSERT INTO basturn (username, datetime, ipaddress, turnid, description, shortdescription, beginhour, endhour, charid) VALUES ('admin', date(now()), '127.0.0.1', 3, 'NOITE', 'NOI', '19:20', '22:30', 'N');
INSERT INTO basturn (username, datetime, ipaddress, turnid, description, shortdescription, beginhour, endhour, charid) VALUES ('admin', date(now()), '127.0.0.1', 4, 'VESPERTINO', 'VES', '17:00', '19:00', 'V');
INSERT INTO basturn (username, datetime, ipaddress, turnid, description, shortdescription, beginhour, endhour, charid) VALUES ('admin', date(now()), '127.0.0.1', 5, 'ALTERNATIVO', 'ALT', '15:00', '19:00', 'A');
INSERT INTO basturn (username, datetime, ipaddress, turnid, description, shortdescription, beginhour, endhour, charid) VALUES ('admin', date(now()), '127.0.0.1', 6, 'MISTO', 'MIS', '08:20', '22:30', 'I');
SELECT setval('seq_turnid',(SELECT max(turnid) FROM basTurn));
