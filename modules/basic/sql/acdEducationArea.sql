INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 0, 'N�O INFORMADO');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, '�REA DA SA�DE');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, '�REA DE QU�MICA');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, '�REA DE TELECOMUNICA��ES');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 5, '�REA DA INFORM�TICA');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 6, '�REA DO COM�RCIO');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 7, '�REA DA CONSTRU��O CIVIL');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 8, '�REA DA IND�STRIA');
SELECT setval('seq_educationareaid',(SELECT max(educationareaid) FROM acdEducationArea));
