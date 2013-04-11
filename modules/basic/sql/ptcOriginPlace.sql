INSERT INTO ptcoriginplace (username, datetime, ipaddress, originplaceid, description) VALUES ('admin', '2005-03-02 13:40:34.889548-03', '127.0.0.1', 1, 'ATENDIMENTO AO ALUNO');
INSERT INTO ptcoriginplace (username, datetime, ipaddress, originplaceid, description) VALUES ('admin', '2005-03-01 13:55:42.76407-03', '127.0.0.1', 2, 'INTERNET');
SELECT setval('seq_originPlaceId',(SELECT max(originplaceid) FROM ptcoriginplace));
