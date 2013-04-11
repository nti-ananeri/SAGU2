<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

$home = 'main:professor:avaliation';
$navbar->addOption(_M('Avaliation', 'services'), 'services', $home, null, array('function' => 'resetStack'));
//$navbar->clear();

$MIOLO->getClass('basic', 'access');
$MIOLO->uses('classes/sagu.class','basic');

$ui = $MIOLO->getUI();

$mioloUserName = trim($MIOLO->getLogin()->id);
$busPerson     = $MIOLO->getBusiness('basic', 'BusPerson');

$session = $MIOLO->session;
$personData->personId = $session->getValue('loginUid');
$personData->password = $session->getValue('loginPasswd');

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
    //chama o formulário que vai redirecionar
    $content = $ui->getForm('services', 'FrmRedirect');
    $theme->insertContent($content);
}

?>
