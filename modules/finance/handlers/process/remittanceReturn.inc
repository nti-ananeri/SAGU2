<?php

/**
 * Finacne process handler.
 * Contains the menus to access process submenus
 *
 * @author William Prigol Lopes [william@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 07/12/2005
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
$MIOLO->checkAccess($module, FIN_ACCESS, false, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process:remittanceReturn';
$navbar->addOption(_M('Remittance and return', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/remittanceReturn/'.$context->shiftAction()) )
{
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':')));
    $icon     = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');

    $pnlInvoice = new MActionPanel('pnlInvoice', _M('Invoice', $module), null, $btnClose, $icon);
    $pnlInvoice->setIconType('small');
    $pnlInvoice->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);

    $menuItem1 = array( 
                       array(_M('Remittance', $module), 'folder-16x16.png', "$home:remittanceInvoice"),
                       array(_M('Return',   $module),   'folder-16x16.png', "$home:returnInvoice")
                     );
    $sortMenuItem1 = SAGU::arraySort($menuItem1, 0);
    
    foreach ( $sortMenuItem1 as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlInvoice->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlInvoice->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

                  
    $pnlAutomaticDebit = new MActionPanel('pnlAutomaticDebit', _M('Automatic debit', $module), null, $btnClose, $icon);
    $pnlAutomaticDebit->setIconType('small');
    $pnlAutomaticDebit->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);
   
    $menuItem2 = array(
                       array(_M('Remittance', $module), 'folder-16x16.png', "$home:remittanceAutomaticDebit"),
                       array(_M('Return', $module),     'folder-16x16.png', "$home:returnAutomaticDebit")
                     );
    $sortMenuItem2 = SAGU::arraySort($menuItem2, 0);
    
    foreach ( $sortMenuItem2 as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlAutomaticDebit->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlAutomaticDebit->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $menu = array($pnlInvoice);//, $pnlAutomaticDebit);
    $theme->clearContent();
    $theme->insertContent($menu);
}

?>
