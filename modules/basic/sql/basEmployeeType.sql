INSERT INTO basemployeetype (username, datetime, ipaddress, employeetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'FUNCION�RIO');
INSERT INTO basemployeetype (username, datetime, ipaddress, employeetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ESTAGI�RIO');
INSERT INTO basemployeetype (username, datetime, ipaddress, employeetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'BOLSISTA');
SELECT setval('seq_employeetypeid',(SELECT max(employeetypeid) FROM basEmployeeType));
