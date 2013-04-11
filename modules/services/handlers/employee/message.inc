<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

$home = 'main:employee:message';
$navbar->addOption(_M('Messages', 'services'), 'services', $home, null, array('function' => 'resetStack'));
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
    $data->home     = $home;
    $data->personId = $personData->personId;
    $content = $ui->getForm('services', 'FrmEmployeeMessage', $data);
    $content->setClose($MIOLO->getActionURL('services',substr($home, 0, strrpos($home, ':'))));
    $theme->clearContent();
    $theme->insertContent($content);
}

?>
