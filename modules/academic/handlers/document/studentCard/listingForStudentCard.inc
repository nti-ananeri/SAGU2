<?php


$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$home = 'main:report:studentCard:listingForStudentCard';
$navbar->addOption(_M('Listing for student identity card', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Listing for student identity card', $home, 'listingForStudentCard-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmListingForStudentCard = $ui->getForm($module,'FrmListingForStudentCard', $data);
$frmListingForStudentCard->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content = $frmListingForStudentCard;

$theme->clearContent($content);
$theme->insertContent($content);

?>
