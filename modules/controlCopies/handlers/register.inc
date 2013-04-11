<?php

/**
 * Control copies register handler.
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
$MIOLO->checkAccess($module, CCP_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:register';
$navbar->addOption(_M('Register', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon                = $ui->getImage($module,'register-16x16.png');
    $pnlControlCopies = new MActionPanel('pnlControlCopies', _M('Register', $module), null, $btnClose, $icon);
    $pnlControlCopies->setIconType('small');
    $pnlControlCopies->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Copies', $module),           'copy-16x16.png',    "$home:copy"),
                       array(_M('Rules',  $module),           'rule-16x16.png',    "$home:rule"),
                       array(_M('Sector', $module),           'sector-16x16.png',  "$home:sector"),
                       array(_M('Project',$module),           'project-16x16.png', "$home:project"),
                       array(_M('Service',$module),           'service-16x16.png', "$home:service"),
                       array(_M('Request',$module),           'request-16x16.png', "$home:request"),
                       array(_M('Pay Roll Discount',$module), 'payrollDiscount-16x16.png', "$home:payrolldiscount")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlControlCopies->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2], 
       $module, $m[3], $module, $m[4], $module, $m[5], $module, $m[6]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlControlCopies);

}

?>
