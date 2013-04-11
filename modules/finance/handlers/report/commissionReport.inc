<?php

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);
$home = 'main:report:commissionReport';
$navbar->addOption(_M('Commission report', $module), $module, $home);

//$MIOLO->getClass('basic', 'access');
//access::insert('Agreements', $home, 'receivableInvoice-16x16.png');

$ui = $MIOLO->getUI();

$frmCommission = $ui->getForm($module, 'FrmCommissionReport', $data);
$content = $frmCommission;

$theme->clearContent($content);
$theme->insertContent($content);

?>
