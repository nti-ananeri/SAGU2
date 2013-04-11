<?php

//
// defines user access right constants, which are used in the
// $NIOLO->CheckAccess() and ThemeMenu->AddUserOption() methods.
//

define('A_ACCESS',    1); // 000001
define('A_QUERY',     1); // 000001

define('A_INSERT',    2); // 000010
define('A_DELETE',    4); // 000100
define('A_UPDATE',    8); // 001000
define('A_EXECUTE',  15); // 001111

define('A_SYSTEM',   31); // 011111
define('A_ADMIN',    31); // 011111

define('A_DEVELOP',  32); // 100000

//PERMISSOES DO SAGU2
/*************************************/

//permissoes do contabil
define('ACC_ACCESS',            101);
define('ACC_INSERT',            102);
define('ACC_UPDATE',            103);
define('ACC_DELETE',            104);
define('ACC_ADMIN',             105);
define('ACC_ACCOUNTING_LIMIT',  106);

//permissoes do academico
define('ACD_ACCESS',            121);
define('ACD_INSERT',            122);
define('ACD_UPDATE',            123);
define('ACD_DELETE',            124);
define('ACD_ADMIN',             125);
define('ACD_ENROLL',            126);
define('ACD_NEW_CONTRACT',      127);
define('ACD_ENROLL_UPDATE',     128);
define('ACD_PROCESS_CONTRACT',  129);
define('ACD_PROFESSOR_CURRICULAR_COMPONENT', 130);
define('ACD_GROUP', 131);
define('ACD_ACADEMIC_CALENDAR', 132);
define('ACD_ACADEMIC_CALENDAR_ADJUSTMENT', 133);
define('ACD_REPORT', 134);
define('ACD_DOCUMENT', 135);
define('ACD_SCHEDULE_LEARNING_PERIOD', 136);
define('ACD_PROCESS',137);
define('ACD_REGISTER',138);
define('ACD_CLASS', 139);


//permissoes do basico
define('BAS_ACCESS',                141);
define('BAS_INSERT',                142);
define('BAS_UPDATE',                143);
define('BAS_DELETE',                144);
define('BAS_ADMIN',                 145);
define('BAS_NEW_PHYSICAL_PERSON',   146);
define('BAS_NEW_DOCUMENT',          147);
define('BAS_NEW_PHONE',             148);
define('BAS_NEW_EMPLOYEE',          149);
define('BAS_NEW_PROFESSOR',         150);


//permissoes do controle do copias
define('CCP_ACCESS',            161);
define('CCP_INSERT',            162);
define('CCP_UPDATE',            163);
define('CCP_DELETE',            164);
define('CCP_ADMIN',             165);

//permissoes do financeiro
define('FIN_ACCESS',                        181);
define('FIN_INSERT',                        182);
define('FIN_UPDATE',                        183);
define('FIN_DELETE',                        184);
define('FIN_ADMIN',                         185);
define('FIN_INCOME_FORECAST_GENERATION',    186);
define('FIN_INDIVIDUAL_INVOICE_GENERATION', 187);
define('FIN_CLOSE_INVOICE',                 188);
define('FIN_COUNTER_MOVEMENT',              189);
define('FIN_CLOSE_COUNTER',                 190);
define('FIN_AGREEMENT',                     191);

//permissoes do recursos humanos
define('HRS_ACCESS',            201);
define('HRS_INSERT',            202);
define('HRS_UPDATE',            203);
define('HRS_DELETE',            204);
define('HRS_ADMIN',             205);

//permissoes do institucional
define('INS_ACCESS',            221);
define('INS_INSERT',            222);
define('INS_UPDATE',            223);
define('INS_DELETE',            224);
define('INS_ADMIN',             225);

//permissoes do questionario
define('RSH_ACCESS',            241);
define('RSH_INSERT',            242);
define('RSH_UPDATE',            243);
define('RSH_DELETE',            244);
define('RSH_ADMIN',             245);

//permissoes do processo seletivo
define('SPR_ACCESS',            261);
define('SPR_INSERT',            262);
define('SPR_UPDATE',            263);
define('SPR_DELETE',            264);
define('SPR_ADMIN',             265);
define('SPR_INSCRIPTION',       266);

//permissoes do services
define('SERVICES_ACCESS',       281);

//permissoes do trade
define('TRD_ACCESS',            301);
define('TRD_INSERT',            302);
define('TRD_UPDATE',            303);
define('TRD_DELETE',            304);
define('TRD_ADMIN',             305);

//permissoes do ponto
define('PNT_ACCESS',            321);
define('PNT_INSERT',            322);
define('PNT_UPDATE',            323);
define('PNT_DELETE',            324);
define('PNT_ADMIN',             325);

//
// SAGU2 defines
//

//global $MIOLO;
//$db        = $MIOLO->GetBusiness('basic','config');
//$db        = $this->manager()->getBusiness('basic','config');

/*$constants = $db->getModuleValues('basic');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}

$constants = $db->getModuleValues('protocol');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}
unset($db);*/

?>
