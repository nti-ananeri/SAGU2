<?php

/**
 * Invoice generation handler.
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
 * Class created on 24/05/2006
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
//$MIOLO->checkAccess($module, FIN_ACCESS, true, true);
$MIOLO->checkAccess($module, FIN_INDIVIDUAL_INVOICE_GENERATION, true, true);

$home = 'main:process:individualReceivableInvoiceGeneration';
$navbar->addOption(_M('Individual receivable invoice generation', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Individual receivable invoice generation', $home, 'individualInvoiceGeneration-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();
$frmInvoiceGeneration = $ui->getForm($module,'FrmIndividualReceivableInvoiceGeneration', $data);
$frmInvoiceGeneration->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

$content = $frmInvoiceGeneration;

if ( $theme->page->generateMethod != 'generateAJAX' )
{
    $theme->clearContent($content);
    $theme->insertContent($content);
}
?>
