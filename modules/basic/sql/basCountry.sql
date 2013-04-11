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
-- Data for Name: bascountry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY bascountry (username, datetime, ipaddress, countryid, name, nationality, currency, pluralcurrency, decimaldescription, pluraldecimaldescription, currencysymbol) FROM stdin;
sagu2	2008-02-11 00:07:15-03	192.168.6.1	2	ESTADOS UNIDOS	AMERICANA	DOLAR	DOLARES	CENT	CENTS	U$
allisson	2008-07-11 10:02:31-03	192.168.0.13	1	BRASIL	BRASILEIRA	REAL	REAIS	CENTAVO	CENTAVOS	R$
sagu2	2008-02-11 00:15:31-03	192.168.6.1	3	COLOMBIA	COLOMBIANA	PESO	PESOS	CENTAVO	CENTAVOS	$
\.


--
-- PostgreSQL database dump complete
--

