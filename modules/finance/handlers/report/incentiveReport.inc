<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);
$home = 'main:report:incentiveReport';
$navbar->addOption(_M('Incentive', $module), $module, $home);

$data->home = $home;
$MIOLO->getClass('basic', 'access');
access::insert(_M('Incentive report','finance'), $home, 'incentiveReport-16x16.png');

$ui = $MIOLO->getUI();

$frm = $ui->getForm($module, 'FrmIncentiveReport', $data);
$content = $frm;

$theme->clearContent($content);
$theme->insertContent($content);

?>
