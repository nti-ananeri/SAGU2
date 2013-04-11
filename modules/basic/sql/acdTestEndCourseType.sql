INSERT INTO acdtestendcoursetype (username, datetime, ipaddress, testendcoursetypeid, description, begindate, enddate) VALUES ('admin', date(now()), '127.0.0.1', 1, 'PROVAO DO MEC', NULL, NULL);
INSERT INTO acdtestendcoursetype (username, datetime, ipaddress, testendcoursetypeid, description, begindate, enddate) VALUES ('admin', date(now()), '127.0.0.1', 2, 'PROVA DO ENADE', NULL, NULL);
SELECT setval('seq_testendcoursetypeid',(SELECT max(testendcoursetypeid) FROM acdTestEndCourseType));
