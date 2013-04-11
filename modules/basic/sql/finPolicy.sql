--
-- PostgreSQL database dump
--

SET client_encoding = 'LATIN1';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

--
-- Data for Name: finpolicy; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO finpolicy VALUES ('sagu2', '2008-01-25 21:13:18.959305-03', '127.0.0.1', 1, 'VESTIBULAR', 18, 2, 2, 0, 0, 0, 0, 0, 0, 0, 0.0000, false, false, true, true, true, true, false, false);
INSERT INTO finpolicy VALUES ('sagu2', '2008-02-23 00:22:39.156350-03', '127.0.0.1', 2, 'GRADUAÇÃO', 18, 1, 2, 6.4000000000000004, 2, 0, 0, 60, 0, 0, 0.0000, false, false, true, true, true, true, false, false);
INSERT INTO finpolicy VALUES ('sagu2', '2008-09-04 11:47:07.543011-03', '127.0.0.1', 3, 'TAXAS COM JUROS', 0, 1, 2, 6.4000000000000004, 2, 0, 0, 0, 60, 0, 0.0000, false, false, true, true, true, true, false, false);
INSERT INTO finpolicy VALUES ('sagu2', '2008-02-09 11:07:49.543011-03', '127.0.0.1', 4, 'TAXA SEM JUROS', 0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0.0000, false, false, true, true, true, true, false, false);
INSERT INTO finpolicy VALUES ('sagu2', '2008-09-04 11:46:51.990659-03', '127.0.0.1', 5, 'INCENTIVOS', 0, 1, 3, 6.4000000000000004, 2, 0, 0, 0, 60, 0, 0.0000, false, false, true, true, true, true, false, false);

SELECT setval('seq_policyId',(SELECT max(policyId) FROM finPolicy));

--
-- PostgreSQL database dump complete
--

