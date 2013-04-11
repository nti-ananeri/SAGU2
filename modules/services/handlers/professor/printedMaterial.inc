<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

$home = 'main:professor:printedMaterial';
$navbar->addOption(_M('Printed material', 'services'), 'services', $home, null, array('function' => 'resetStack'));
//$navbar->clear();

$MIOLO->getClass('basic', 'access');
$MIOLO->uses('classes/sagu.class','basic');

$ui = $MIOLO->getUI();

$mioloUserName = trim($MIOLO->getLogin()->id);
$busPerson     = $MIOLO->getBusiness('basic', 'BusPerson');

//se for um usuário do sistema logado
if ( strlen($mioloUserName) >  0 )
{
    $personData = $busPerson->getPersonByMioloUserName($mioloUserName);
}
else //caso for um aluno
{
    $session = $MIOLO->session;
    $personData->personId = $session->getValue('loginUid');
    $personData->password = $session->getValue('loginPasswd');
    if ( ! SAGU::authenticate($personData->personId, $personData->password) )
    {
        $content = $ui->getForm('services', 'FrmLogin');
        $content->setClose($MIOLO->getActionURL('services', substr($home, 0, strrpos($home, ':'))));
        $theme->clearContent();
        $theme->insertContent($content);

    }
    else
    {
        $personData = $busPerson->getPerson($personData->personId);
    }
}

if ( SAGU::authenticate($personData->personId, $personData->password) )
{
    if ( ! $MIOLO->invokeHandler('services',  'professor/printedMaterial/'. $context->shiftAction()) )
    {
        $ui            = $MIOLO->getUI();
        $frmAttendance = $ui->getForm( 'services', 'FrmPrintedMaterial' );
        $content       = $frmAttendance;
        $theme->clearContent($content);
        $theme->insertContent($content);
    }
    $business = $MIOLO->getBusiness('basic','BusConfig');
    $constants = $business->getModuleValues('basic');
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    }
    $constants = $business->getModuleValues('academic');
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    
    }
    $constants = $business->getModuleValues('service');
    if ( count($constants)>0 )
    {
        foreach ( $constants as $cnt )
        {
            define($cnt[0],$cnt[1]);
        }
    }
}

?>
