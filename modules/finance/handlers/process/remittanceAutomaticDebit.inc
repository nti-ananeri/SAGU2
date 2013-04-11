<?php

/**
 * Finacne process handler.
 * Contains the menus to access process submenus
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
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

$home = 'main:process:remittanceReturn:remittanceAutomaticDebit';
//$navbar->addOption(_M('Remittance invoice', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/remittanceReturn/'.$context->shiftAction()) )
{
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':')));

    $icon       = $ui->getImage($module, 'process-16x16.png');
    $pnlInvoice = new MActionPanel('pnlInvoice', _M('Remittance automatic debit', $module), null, $btnClose, $icon);
    $pnlInvoice->setIconType('small');
    $pnlInvoice->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);
    $businessBanks = $MIOLO->getBusiness($module, 'BusBank');
    $banks = $businessBanks->listBank();

    // If exists banks registered search the classes available for that
    if (is_array($banks[0]))
    {
        $MIOLO->getClass($module, 'RemittanceAutomaticDebit');
        $invoiceRemittance = new remittanceAutomaticDebit();
        foreach ($banks as $b)
        {
            if ($invoiceRemittance->remittanceExists($b[0]))
            {
                $items = array($b[1], 'remittanceAutomaticDebit'.$b[0].'-16x16.png', "$home:remittanceAutomaticDebit".$b[0]);
                $menuItem[] = $items;
            }
            unset($items);
        }
    }
   
    if (is_array($menuItem))
    {
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
    
        foreach ( $sortMenuItem as $m )
        {
            $pnlInvoice->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2]);
        }       

        $menu = array($pnlInvoice);
    }
    else
    {
        $MIOLO->information(_M('No remittances for automatic debit installed', $module), $btnClose);
    }
    $theme->clearContent();
    $theme->insertContent($menu);
}
?>
