<?php


$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

$home = 'main:process:taxGeneration';
$navbar->addOption(_M('Tax generation', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Tax generation', $home, 'taxGeneration-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();
$frmInvoiceGeneration = $ui->getForm($module,'FrmTaxGeneration', $data);
$frmInvoiceGeneration->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

$content = $frmInvoiceGeneration;

$theme->clearContent($content);
$theme->insertContent($content);

?>
