<?php
$MIOLO = MIOLO::getInstance();
$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$home = 'main:document:examinationFrequence';
$navbar->addOption(_M('Examination frequence', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Examination frequence', $home, 'examinationFrequence-16x16.png');
$data->home         = $home;

$ui                 = $MIOLO->getUI();

$frmExaminationFrequence = $ui->getForm($module, 'FrmExaminationFrequence', $data);
$content = $frmExaminationFrequence;

if ( $theme->page->generateMethod != 'generateAJAX' )
{
    $theme->clearContent($content);
    $theme->insertContent($content);
}


//$MIOLO = MIOLO::getInstance();
//$MIOLO->Uses('classes/RptExaminationFrequence.class', 'academic');
//$Report = new RptExaminationFrequence($data);


?>
