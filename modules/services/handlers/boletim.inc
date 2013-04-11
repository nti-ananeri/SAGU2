<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

$home = 'main:boletim';
$navbar->addOption(_M('Boletim', 'academic'), 'services', $home, null, array('function' => 'resetStack'));
//$navbar->clear();

$MIOLO->getClass('basic', 'access');
$MIOLO->uses('classes/sagu.class','basic');

$ui = $MIOLO->getUI();
$login->idperson = $MIOLO->session->getValue('loginUid');
$idperson        = $MIOLO->session->getValue('loginUid');
$loginPasswd     = $MIOLO->session->getValue('loginPasswd');

if ( $MIOLO->checkAccess('services'_, WEB_ACCESS, false, true) || SAGU::authenticate($idperson, $loginPasswd) )
{
    $ui         = $MIOLO->getUI();
    $frmBoletim = $ui->getForm( 'services', 'FrmBoletim' );
    $content    = $frmBoletim;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
