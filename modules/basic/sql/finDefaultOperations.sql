--
-- PostgreSQL database dump
--
--
-- Data for Name: finoperation; Type: TABLE DATA; Schema: public; Owner: postgres
--
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.261422-03', NULL, 1, 'MENSALIDADES', 'D', false, false, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2008-08-07 17:23:06.116883-03', NULL, 2, 'VESTIBULAR', 'D', false, true, 'N', 2, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.280252-03', NULL, 3, 'PAGAMENTO NO CAIXA', 'C', false, true, 'P', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.358054-03', NULL, 4, 'PAGAMENTO REDE BANCARIA', 'C', false, true, 'P', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.281328-03', NULL, 5, 'DEPENDÊNCIA', 'D', false, true, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.288867-03', NULL, 6, 'NEGOCIAÇÃO', 'D', false, true, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.291027-03', NULL, 7, 'MULTA BIBLIOTECA', 'D', false, true, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.292279-03', NULL, 8, 'TRANCAMENTO', 'D', false, true, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.296597-03', NULL, 9, 'DIVERSOS', 'D', false, true, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2008-02-25 10:30:17.079464-03', NULL, 10, 'DESCONTOS CONCEDIDOS', 'C', false, true, 'D', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-13 11:47:39.297678-03', NULL, 11, 'ENCARGOS FINANCEIROS', 'D', false, true, 'J', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2008-01-02 16:49:43.186556-03', NULL, 12, 'TAXA DE MATRÍCULA', 'D', false, true, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2007-12-15 10:18:03.358054-03', NULL, 13, 'ACORDOS', 'C', false, true, 'P', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2008-01-03 13:55:27.885025-03', NULL, 14, 'CANCELAMENTO DE BOLETA GERADA', 'C', false, false, 'N', NULL, NULL, 'R');
INSERT INTO finoperation VALUES ('sagu2', '2009-01-27 11:37:59.588434-03', NULL, 15, 'BAIXA MANUAL', 'C', false, false, 'P', NULL, NULL, 'R');

SELECT setval('seq_operationId',(SELECT max(operationId) FROM finOperation));

INSERT INTO findefaultoperations VALUES ('sagu2', '2008-03-04 09:32:45.781242-03', '127.0.0.1', 5, 14, 8, 11, 10, 7, 3, 1, 3, 13, 11, 2, 4, 12, 11, 6);

--
-- PostgreSQL database dump complete
--

