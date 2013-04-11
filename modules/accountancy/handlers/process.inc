<?php

/**
 * Accountancy register handler.
 * Contains the menus to access register submenus
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 26/12/2005
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
$MIOLO->checkAccess($module, ACC_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process';
$navbar->addOption(_M('Process', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module, 'process/' . $context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon     = $ui->getImage($module,'process-16x16.png');
    $pnlAccountancy = new MActionPanel('pnlAccountancy', _M('Process', $module), null, $btnClose, $icon);
    $pnlAccountancy->setIconType('small');
    $pnlAccountancy->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Accountancy balances', $module),     'accountancyBalances-16x16.png',             "$home:accountancyBalance"),
                       array(_M('Upload file IRRF', $module),         'uploadFileIRRF-16x16.png',         "$home:uploadFileIRRF"),
                       array(_M('Define accounting limits', $module), 'defineAccountingLimits-16x16.png', "$home:defineAccountingLimits"),
                       array(_M('Generate IRRF', $module),            'generateIRRF-16x16.png',           "$home:generateIRRF")
	       );
    if ( strtoupper(IS_SIGA_ACTIVE) == 'YES' )
    {
    	$menuItem[] = array(_M('Accounting', $module),            'folder-16x16.png',        "$home:accounting");
    	$menuItem[] = array(_M('Import cost center', $module),    'importCostCenter-16x16.png',    "$home:importCostCenter");
    	$menuItem[] = array(_M('Import account scheme', $module), 'importAccountScheme-16x16.png', "$home:importAccountScheme");
    }


    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlAccountancy->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlAccountancy->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlAccountancy);

}

?>
