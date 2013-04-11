<?php

/**
 * Academic contract process handler
 * Contains the menus to access academic contract process 
 *
 * @author daniel Afonso Heisler [daniel@isolution.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 25/01/2006
 *
 * \b Organization: \n
 * SOLIS - Cooperativa de Solucoes Livres \n
 * The SAGU2 Development Team
 *
 * \b CopyLeft: \n
 * CopyLeft (L) 2005 SOLIS - Cooperativa de Solucoes Livres \n
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 * \b History: \n
 * See history in CVS repository: http://sagu.solis.coop.br
 *
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
//$MIOLO->checkAccess($module, ACD_UPDATE, true, true);
//$MIOLO->checkAccess($module, ACD_INSERT, true, true);
$MIOLO->checkAccess($module, ACD_PROCESS_CONTRACT, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process:contract';
$navbar->addOption(_M('Contract', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/contract/' . $context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Contract', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                      array(_M('Contract lock',$module), 'contractLock-16x16.png',    "$home:contractLock"),
                      array(_M('Contract unlock',$module), 'contractUnlock-16x16.png',  "$home:contractUnlock"),
                      array(_M('Contract lock renewal',$module), 'contractLockRenewal-16x16.png',  "$home:contractLockRenewal"), 
                      array(_M('Inactive contract lock',$module),  'inactiveContractLock-16x16.png', "$home:inactiveContractLock"),
                      array(_M('Contract abandonment',$module), 'contractAbandonment-16x16.png', "$home:contractAbandonment"),
                      array(_M('Contract desist',$module), 'contractDesist-16x16.png', "$home:contractDesist"),
                      array(_M('Contract cancellation',$module), 'contractCancellation-16x16.png', "$home:contractCancellation"),
                      array(_M('Internal transference',$module), 'internalTransference-16x16.png', "$home:internalTransference"),
                      array(_M('External transference',$module), 'externalTransference-16x16.png', "$home:externalTransference"),
                       array(_M('Curriculum conversion', $module), 'curriculumConversion-16x16.png', "$home:curriculumConversion"),
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlAcademic->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlAcademic);

}

?>
