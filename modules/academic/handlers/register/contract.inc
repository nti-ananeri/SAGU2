<?php

/**
 * Academic register handler.
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
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 27/01/2006
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
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:register:contract';
$navbar->addOption(_M('Contract', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/contract/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Contract', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
	             array(_M('Contract',$module),                     'contract-16x16.png',                   "$home:contract"),
		     array(_M('Movement contract',$module),            'movementContract-16x16.png',           "$home:movementContract"),
		     array(_M('Message contract renewal',$module),     'messageContractRenewal-16x16.png',     "$home:messageContractRenewal"),
		     array(_M('Movement contract complement',$module), 'movementContractComplement-16x16.png', "$home:movementContractComplement"),
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
