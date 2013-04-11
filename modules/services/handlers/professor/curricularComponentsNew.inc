<?php
/**
 **/

$home = 'main:professor:curricularComponentsNew';
$navbar->addOption(_M('Curricular components', 'services'), 'services', $home, null, array('function' => 'resetStack'));

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
    $session              = $MIOLO->session;
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
    $ui                      = $MIOLO->getUI();
    $frmCurricularComponents = $ui->getForm('services', 'FrmProfessorCurricularComponentsNew');
    $frmCurricularComponents->setClose($MIOLO->getActionURL('services',substr($home, 0, strrpos($home, ':'))));
    $theme->clearContent();
    $theme->insertContent($frmCurricularComponents);
}

?>
