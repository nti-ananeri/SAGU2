<?php
$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
//$MIOLO->checkAccess($module, SPR_ACCESS, true, true);

/**
 * Load global defines for the basic module
 */
$business  = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('basic');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}

/**
 * Load global defines for the selectiveProcess module
 */
$constants = $business->getModuleValues('services');
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    }
}
$home = 'main:pupil:enroll';
$navbar->addOption(_M('Enroll', 'academic'), 'services', $home, null, array('function' => 'resetStack'));

$ui = $MIOLO->getUI();

$function        = MIOLO::_request('function');
$page            = MIOLO::_request('page');

$MIOLO->getClass('basic', 'access');
$MIOLO->uses('classes/sagu.class','basic');


$mioloUserName = trim($MIOLO->getLogin()->id);
$busPerson     = $MIOLO->getBusiness('basic', 'BusPerson');

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
    $data->home     = $home;
    $data->personId = $personData->personId;
    $page = MIOLO::_request('page');
    switch($page)
    {
        case 1:
            $frmEnroll = $ui->getForm( $module, 'FrmEnrollPerson' );
            break;
        case 2:
            $frmEnroll = $ui->getForm( $module, 'FrmEnrollDebitPupil' );
            break;
        case 3:
            $frmEnroll = $ui->getForm( $module, 'FrmEnrollContractAndInvoice' );
            break;
            
        default:
           $frmEnroll = $ui->getForm( $module, 'FrmEnrollInit' );
            break;
    }
    
    if( is_object($frmEnroll) )
    {
        $frmEnroll->setClose($MIOLO->getActionURL('services',substr($home, 0, strrpos($home, ':'))));
        $theme->clearContent($frmEnroll);
        $theme->insertContent($frmEnroll);
    }
}

?>
