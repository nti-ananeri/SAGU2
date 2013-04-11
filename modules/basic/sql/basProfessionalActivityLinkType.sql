INSERT INTO basprofessionalactivitylinktype (username, datetime, ipaddress, professionalactivitylinktypeid, description, notifycompany) VALUES ('admin', date(now()), '127.0.0.1', 1, 'CLT', true);
INSERT INTO basprofessionalactivitylinktype (username, datetime, ipaddress, professionalactivitylinktypeid, description, notifycompany) VALUES ('admin', date(now()), '127.0.0.1', 2, 'ESTÁGIÁRIO', true);
INSERT INTO basprofessionalactivitylinktype (username, datetime, ipaddress, professionalactivitylinktypeid, description, notifycompany) VALUES ('admin', date(now()), '127.0.0.1', 3, 'BOLSISTA', true);
SELECT setval('seq_professionalactivitylinktypeid',(SELECT max(professionalactivitylinktypeid) FROM basProfessionalActivityLinkType));
