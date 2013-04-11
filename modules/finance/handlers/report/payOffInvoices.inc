<?php
/**
 * Finance document handler.
 * Contains the menus to access geography submenus
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
 * Class created on 16/12/2005
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

$home = 'main:report:payOffInvoices';
$navbar->addOption(_M('Pay off invoices', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'report/payOffInvoices/'.$context->shiftAction()) )
{
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module, substr($home, 0, strrpos($home,':')));

    $icon        = $ui->getImage($module,'folder-16x16.png');
    $pnlPayOffInvoices = new MActionPanel('pnlPayOffInvoices', _M('Pay off invoices', $module), NULL, $btnClose, $icon);
    $pnlPayOffInvoices->setIconType('small');
    $pnlPayOffInvoices->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);

    $menuItem = array(
                       array(_M('Payments out of date', $module), 'paymentsOutOfDate-16x16.png', "$home:paymentsOutOfDate"),
                       array(_M('Paid off invoices',    $module), 'construction-16x16.gif',      "$home:paidOffInvoices")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlPayOffInvoices->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlPayOffInvoices);
}
?>
