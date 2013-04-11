INSERT INTO acdcourseversiontype (username, datetime, ipaddress, courseversiontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'SEMESTRAL/CRÉDITO');
INSERT INTO acdcourseversiontype (username, datetime, ipaddress, courseversiontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ANUAL/CRÉDITO');
INSERT INTO acdcourseversiontype (username, datetime, ipaddress, courseversiontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'SEMESTRAL/SERIADO');
INSERT INTO acdcourseversiontype (username, datetime, ipaddress, courseversiontypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 4, 'ANUAL/SERIADO');
SELECT setval('seq_courseversiontypeid',(SELECT max(courseversiontypeid) FROM acdCourseVersionType));
