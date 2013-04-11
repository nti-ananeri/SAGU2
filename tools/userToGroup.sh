#!/bin/bash
#BASIC
rpl '$MIOLO->checkAccess($module, BAS_ACCESS, true);' '$MIOLO->checkAccess($module, BAS_ACCESS, true, true);' basic/* -R
rpl '$MIOLO->checkAccess($module, BAS_INSERT, true);' '$MIOLO->checkAccess($module, BAS_INSERT, true, true);' basic/* -R
rpl '$MIOLO->checkAccess($module, BAS_UPDATE, true);' '$MIOLO->checkAccess($module, BAS_UPDATE, true, true);' basic/* -R
rpl '$MIOLO->checkAccess($module, BAS_DELETE, true);' '$MIOLO->checkAccess($module, BAS_DELETE, true, true);' basic/* -R
rpl '$MIOLO->checkAccess($module, BAS_ADMIN, true);' '$MIOLO->checkAccess($module, BAS_ADMIN, true, true);' basic/* -R

#ACADEMIC
rpl '$MIOLO->checkAccess($module, ACD_ACCESS, true);' '$MIOLO->checkAccess($module, ACD_ACCESS, true, true);' academic/* -R
rpl '$MIOLO->checkAccess($module, ACD_INSERT, true);' '$MIOLO->checkAccess($module, ACD_INSERT, true, true);' academic/* -R
rpl '$MIOLO->checkAccess($module, ACD_UPDATE, true);' '$MIOLO->checkAccess($module, ACD_UPDATE, true, true);' academic/* -R
rpl '$MIOLO->checkAccess($module, ACD_DELETE, true);' '$MIOLO->checkAccess($module, ACD_DELETE, true, true);' academic/* -R
rpl '$MIOLO->checkAccess($module, ACD_ADMIN, true);' '$MIOLO->checkAccess($module, ACD_ADMIN, true, true);' academic/* -R

#ACCOUNTANCY
rpl '$MIOLO->checkAccess($module, ACC_ACCESS, true);' '$MIOLO->checkAccess($module, ACC_ACCESS, true, true);' accountancy/* -R
rpl '$MIOLO->checkAccess($module, ACC_INSERT, true);' '$MIOLO->checkAccess($module, ACC_INSERT, true, true);' accountancy/* -R
rpl '$MIOLO->checkAccess($module, ACC_UPDATE, true);' '$MIOLO->checkAccess($module, ACC_UPDATE, true, true);' accountancy/* -R
rpl '$MIOLO->checkAccess($module, ACC_DELETE, true);' '$MIOLO->checkAccess($module, ACC_DELETE, true, true);' accountancy/* -R
rpl '$MIOLO->checkAccess($module, ACC_CDMIN, true);' '$MIOLO->checkAccess($module, ACD_ADMIN, true, true);' accountancy/* -R

#FINANCE
rpl '$MIOLO->checkAccess($module, FIN_ACCESS, true);' '$MIOLO->checkAccess($module, FIN_ACCESS, true, true);' finance/* -R
rpl '$MIOLO->checkAccess($module, FIN_INSERT, true);' '$MIOLO->checkAccess($module, FIN_INSERT, true, true);' finance/* -R
rpl '$MIOLO->checkAccess($module, FIN_UPDATE, true);' '$MIOLO->checkAccess($module, FIN_UPDATE, true, true);' finance/* -R
rpl '$MIOLO->checkAccess($module, FIN_DELETE, true);' '$MIOLO->checkAccess($module, FIN_DELETE, true, true);' finance/* -R
rpl '$MIOLO->checkAccess($module, FIN_CDMIN, true);' '$MIOLO->checkAccess($module, FIN_ADMIN, true, true);' finance/* -R

#INSTITUTIONAL
rpl '$MIOLO->checkAccess($module, INS_ACCESS, true);' '$MIOLO->checkAccess($module, INS_ACCESS, true, true);' institutional/* -R
rpl '$MIOLO->checkAccess($module, INS_INSERT, true);' '$MIOLO->checkAccess($module, INS_INSERT, true, true);' institutional/* -R
rpl '$MIOLO->checkAccess($module, INS_UPDATE, true);' '$MIOLO->checkAccess($module, INS_UPDATE, true, true);' institutional/* -R
rpl '$MIOLO->checkAccess($module, INS_DELETE, true);' '$MIOLO->checkAccess($module, INS_DELETE, true, true);' institutional/* -R
rpl '$MIOLO->checkAccess($module, INS_CDMIN, true);' '$MIOLO->checkAccess($module, INS_ADMIN, true, true);' institutional/* -R

#PUPILASSISTANCE
rpl '$MIOLO->checkAccess($module, PAS_ACCESS, true);' '$MIOLO->checkAccess($module, PAS_ACCESS, true, true);' pupilAssistance/* -R
rpl '$MIOLO->checkAccess($module, PAS_INSERT, true);' '$MIOLO->checkAccess($module, PAS_INSERT, true, true);' pupilAssistance/* -R
rpl '$MIOLO->checkAccess($module, PAS_UPDATE, true);' '$MIOLO->checkAccess($module, PAS_UPDATE, true, true);' pupilAssistance/* -R
rpl '$MIOLO->checkAccess($module, PAS_DELETE, true);' '$MIOLO->checkAccess($module, PAS_DELETE, true, true);' pupilAssistance/* -R
rpl '$MIOLO->checkAccess($module, PAS_ADMIN, true);' '$MIOLO->checkAccess($module, PAS_ADMIN, true, true);' pupilAssistance/* -R

#SELECTIVEPROCESS
rpl '$MIOLO->checkAccess($module, SPR_ACCESS, true);' '$MIOLO->checkAccess($module, SPR_ACCESS, true, true);' selectiveProcess/* -R
rpl '$MIOLO->checkAccess($module, SPR_INSERT, true);' '$MIOLO->checkAccess($module, SPR_INSERT, true, true);' selectiveProcess/* -R
rpl '$MIOLO->checkAccess($module, SPR_UPDATE, true);' '$MIOLO->checkAccess($module, SPR_UPDATE, true, true);' selectiveProcess/* -R
rpl '$MIOLO->checkAccess($module, SPR_DELETE, true);' '$MIOLO->checkAccess($module, SPR_DELETE, true, true);' selectiveProcess/* -R
rpl '$MIOLO->checkAccess($module, SPR_ADMIN, true);' '$MIOLO->checkAccess($module, SPR_ADMIN, true, true);' selectiveProcess/* -R
