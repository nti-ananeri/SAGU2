<?php

/**
 * Accountancy process/accounting handler.
 * Contains the menus to access process/accounting submenus
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 17/07/2006
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

$MIOLO->getClass($module, 'accounting');

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process:accounting';
$navbar->addOption(_M('Accounting', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module, 'process/accounting/' . $context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon     = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAccountancy = new MActionPanel('pnlAccountancy', _M('Accounting', $module), null, $btnClose, $icon);
    $pnlAccountancy->setIconType('small');
    $pnlAccountancy->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Generate entry accounting file', $module),           'generateEntryAccountingFile-16x16.png',          "$home:generateEntryAccountingFile"),
                       array(_M('Generate income forecast accounting file', $module), 'generateIncomeForecastAccountingFile-16x16.png', "$home:generateIncomeForecastAccountingFile"),
                       array(_M('Format accounting import file', $module),            'formatAccountingImportFile-16x16.png',           "$home:formatAccountingImportFile"),
                       array(_M('Define accounting projects', $module),               'defineAccountingProjects-16x16.png',             "$home:defineAccountingProjects")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlAccountancy->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlAccountancy);
}

?>
