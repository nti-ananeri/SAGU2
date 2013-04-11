<?php
/**
 * Human resources register handler.
 * Contains the menus to access register submenus
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * Rafael Luís Spengler [rafael@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 15/03/2006
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
$MIOLO->checkAccess($module, HRS_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process';
$navbar->addOption(_M('Process', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon              = $ui->getImage($module, 'process-16x16.png');
    $pnlHumanResources = new MActionPanel('pnlHumanResources', _M('Process', $module), null, $btnClose, $icon);
    $pnlHumanResources->setIconType('small');
    $pnlHumanResources->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                        array(_M('Salary remittance',$module),          'salaryRemittance-16x16.png',         "$home:salaryRemittance"),
                        array(_M('Salary return',$module),              'salaryReturn-16x16.png',             "$home:salaryReturn"),
                        array(_M('Opening account remittance',$module), 'openingAccountRemittance-16x16.png', "$home:openingAccountRemittance"),
                        array(_M('Opening account return',$module),     'openingAccountReturn-16x16.png',     "$home:openingAccountReturn"),
                        array(_M('Professor cost center',$module),      'professorCostCenter-16x16.png',             "$home:professorCostCenter")
                     );

    if ( strtoupper(IS_SIGA_ACTIVE) == 'YES' )
    {
           $menuItem[] = array(_M('Update external ids',$module),       'updateExternalIds-16x16.png', "$home:updateExternalIds");
           $menuItem[] = array(_M('Generate point card',$module),       'generatePointCard-16x16.png', "$home:generatePointCard");
    }


    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlHumanResources->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlHumanResources->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlHumanResources);
}

?>
