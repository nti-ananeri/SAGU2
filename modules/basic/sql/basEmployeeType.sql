INSERT INTO basemployeetype (username, datetime, ipaddress, employeetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 1, 'FUNCIONÁRIO');
INSERT INTO basemployeetype (username, datetime, ipaddress, employeetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ESTAGIÁRIO');
INSERT INTO basemployeetype (username, datetime, ipaddress, employeetypeid, description) VALUES ('admin', date(now()), '127.0.0.1', 3, 'BOLSISTA');
SELECT setval('seq_employeetypeid',(SELECT max(employeetypeid) FROM basEmployeeType));
