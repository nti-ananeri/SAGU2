<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);
$home = 'main:report:agreementsReport';
$navbar->addOption(_M('Agreements report', $module), $module, $home);

//$MIOLO->getClass('basic', 'access');
//access::insert('Agreements', $home, 'receivableInvoice-16x16.png');

$ui = $MIOLO->getUI();

$frmAgreements = $ui->getForm($module, 'FrmAgreementsReport', $data);
$content = $frmAgreements;

$theme->clearContent($content);
$theme->insertContent($content);

?>
