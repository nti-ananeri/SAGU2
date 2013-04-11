<?php


$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$home = 'main:report:studentCard:printableListForStudentCard';
$navbar->addOption(_M('Printable listing for student identity card', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Printable listing for student identity card', $home, 'printableListingForStudentCard-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmListingForStudentCard = $ui->getForm($module,'FrmPrintableListForStudentCard', $data);
$frmListingForStudentCard->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content = $frmListingForStudentCard;

$theme->clearContent($content);
$theme->insertContent($content);

?>
