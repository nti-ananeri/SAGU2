<?php

/**
 * Pupil assistance register handler.
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
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 13/12/2005
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
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:register:invoice';
$navbar->addOption(_M('Invoice', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/invoice/' . $context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));
    $icon     = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');

    $pnlRegister = new MActionPanel('pnlRegister', _M('Invoice', $module), null, $btnClose, $icon);
    $pnlRegister->setIconType('small');
    $pnlRegister->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array(
                        array(_M('Receivable invoice',$module), 'receivableInvoice-16x16.png', "$home:receivableInvoice"),
                        array(_M('Payable invoice',$module), 'payableInvoice-16x16.png', "$home:payableInvoice"),
                        );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlRegister->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlRegister);

}

?>
