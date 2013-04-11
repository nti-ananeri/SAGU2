<?php
/**
 * Selective process register handler.
 * Contains the menus to access register submenus
 *
 * @author Jamiel Spezia [jamiel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * Rafael Luís Spengler [rafael@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 17/08/2005
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

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process';
$navbar->addOption(_M('Process', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/'.$context->shiftAction()) )
{

    $MIOLO->checkAccess($module, SPR_ACCESS, true, true);

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon                = $ui->getImage($module,'process-16x16.png');
    $pnlSelectiveProcess = new MActionPanel('pnlSelectiveProcess', _M('Process', $module), null, $btnClose, $icon);
    $pnlSelectiveProcess->setIconType('small');
    $pnlSelectiveProcess->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                        array(_M('Upload csv file - subscription register',$module), 'uploadCsvFileSubscriptionRegister-16x16.png', "$home:uploadCsvFileSubscriptionRegister"),
                        array(_M('Upload csv file - note',$module), 'uploadCsvFileNote-16x16.png', "$home:uploadCsvFileNote"),
                        array(_M('Reserve room',$module), 'reserveRoom-16x16.png', "$home:reserveRoom"),
                        array(_M('Generate notes table',$module), 'generateNotesTable-16x16.png', "$home:generateNotesTable"),
                        array(_M('Classification',$module), 'classification-16x16.png', "$home:classification"),
                        array(_M('Inscription',$module), 'inscriptionProcess-16x16.png', "$home:inscription"),
			            array(_M('General classification',$module), 'generalClassification-16x16.png', "$home:generalClassification"),
   			            array(_M('Selective process copy',$module), 'selectiveProcessCopy-16x16.png', "$home:selectiveProcessCopy"),
   			            array(_M('Selective process transfer',$module), 'selectiveProcessCopy-16x16.png', "$home:selectiveProcessTransfer")
                     );

    if ( MODULE_ACADEMIC_INSTALLED == 'YES' )
    {
       $menuItem[] = array(_M('Generate contract',$module), 'generateContract-16x16.png', "$home:generateContract");
    }

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlSelectiveProcess->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlSelectiveProcess->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }


    $theme->clearContent();
    $theme->insertContent($pnlSelectiveProcess);
}

?>
