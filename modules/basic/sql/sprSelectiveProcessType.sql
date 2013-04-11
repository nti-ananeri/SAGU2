INSERT INTO sprselectiveprocesstype (username, datetime, ipaddress, selectiveprocesstypeid, description) VALUES ('admin', '2006-10-21 14:29:44.39772-02', '127.0.0.1', 1, 'VESTIBULAR');
INSERT INTO sprselectiveprocesstype (username, datetime, ipaddress, selectiveprocesstypeid, description) VALUES ('admin', '2006-10-21 14:29:44.39772-02', '127.0.0.1', 2, 'ENEM');
SELECT setval('seq_selectiveprocesstypeid',(SELECT max(selectiveprocesstypeid) FROM sprselectiveprocesstype));
