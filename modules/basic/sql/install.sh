#!/bin/bash
createdb -Upostgres sagu2 -E LATIN1 && psql -Upostgres sagu2 -f install.sql
