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
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
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

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process';
$navbar->addOption(_M('Process', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/'.$context->shiftAction()) )
{
    $MIOLO->checkAccess($module, FIN_ACCESS, true, true);
    
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module, substr($home,0,strrpos($home,':')));

    $icon       = $ui->getImage($module, 'process-16x16.png');
    $pnlFinance = new MActionPanel('pnlFinance', _M('Process', $module), null, $btnClose, $icon);
    $pnlFinance->setIconType('small');
    $pnlFinance->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);

    $menuItem = array(
        array(_M('Income forecast generation',    $module), 'incomeForecastGeneration-16x16.png',    "$home:incomeForecastGenerationCourse"),
        array(_M('Receivable invoice generation', $module), 'folder-16x16.png',                      "$home:receivableInvoice"),
        array(_M('Long term to short term',       $module), 'longTermShortTerm-16x16.png',           "$home:longTermShortTerm"),
        array(_M('Payroll discount',              $module), 'payrollDiscountProcess-16x16.png',             "$home:payrollDiscount"),
//        array(_M('Print invoice',                 $module), 'printInvoice-16x16.png',                "$home:printInvoice"),
        array(_M('Remittance and return',         $module), 'folder-16x16.png',                      "$home:remittanceReturn", null, array('function'=>'resetStack')),
        array(_M('Generation in lot',             $module), 'folder-16x16.png',                      "$home:generationInLot", null, array('function'=>'resetStack')),
        array(_M('Individual income forecast generation', $module), 'individualIncomeForecastGeneration-16x16.png',        "$home:individualIncomeForecastGeneration"),
        array(_M('Counter movement',              $module), 'counterMovement-16x16.png',             "$home:counterMovement"),
        array(_M('Close counter',                 $module), 'closeCounterProcess-16x16.png',                "$home:closeCounter"),
        array(_M('Individual payable invoice generation', $module), 'individualInvoiceGeneration-16x16.png', "$home:individualPayableInvoiceGeneration"),
        array(_M('Individual receivable invoice generation', $module), 'individualInvoiceGeneration-16x16.png', "$home:individualReceivableInvoiceGeneration"),
        array(_M('Tax generation', $module), 'taxGeneration-16x16.png', "$home:taxGeneration"),
        array(_M('Re-enroll', $module), 'reEnroll-16x16.png', "$home:reEnroll", null, array ('function'=>'resetStack'))
        );

    if ( MODULE_ACADEMIC_INSTALLED == 'YES' )
    {
        $menuItem[] = array(_M('Enroll tax generation', $module), 'enrollTaxGeneration-16x16.png', "$home:enrollTaxGeneration");
        $menuItem[] = array(_M('Generate invoices for contract', $module), 'generateInvoices-16x16.png', "$home:generateInvoices");
    }

    if ( MODULE_GNUTECA_INSTALLED == 'YES' )
    {
        $menuItem[] = array(_M('Import fines', $module), 'importFines-16x16.png', "$home:importFines");
    }

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlFinance->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlFinance->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlFinance);
}

?>
