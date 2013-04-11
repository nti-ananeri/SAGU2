INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 0, 'NÃO INFORMADO');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'ÁREA DA SAÚDE');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ÁREA DE QUÍMICA');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'ÁREA DE TELECOMUNICAÇÕES');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 5, 'ÁREA DA INFORMÁTICA');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 6, 'ÁREA DO COMÉRCIO');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 7, 'ÁREA DA CONSTRUÇÃO CIVIL');
INSERT INTO acdeducationarea (username, datetime, ipaddress, educationareaid, description) VALUES ('admin', date(now()), '127.0.0.1', 8, 'ÁREA DA INDÚSTRIA');
SELECT setval('seq_educationareaid',(SELECT max(educationareaid) FROM acdEducationArea));
