INSERT INTO basprofessionalactivity (username, datetime, ipaddress, professionalactivityid, description) VALUES ('admin' ,now(), '127.0.0.1', '0', 'N�O INFORMADO');
INSERT INTO basprofessionalactivity (username, datetime, ipaddress, professionalactivityid, description) VALUES ('admin' ,now(), '127.0.0.1', '1', 'ADMINISTRADOR');
INSERT INTO basprofessionalactivity (username, datetime, ipaddress, professionalactivityid, description) VALUES ('admin' ,now(), '127.0.0.1', '2', 'BANC�RIO');
INSERT INTO basprofessionalactivity (username, datetime, ipaddress, professionalactivityid, description) VALUES ('admin' ,now(), '127.0.0.1', '3', 'M�DICO');
INSERT INTO basprofessionalactivity (username, datetime, ipaddress, professionalactivityid, description) VALUES ('admin' ,now(), '127.0.0.1', '4', 'PROFESSOR');
INSERT INTO basprofessionalactivity (username, datetime, ipaddress, professionalactivityid, description) VALUES ('admin' ,now(), '127.0.0.1', '5', 'ENGENHEIRO');
SELECT setval('seq_professionalActivityId',(SELECT max(professionalactivityid) FROM basprofessionalactivity));
