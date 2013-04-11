<?php

/**
 * Receivable invoice generation handler.
 *
 * @author Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
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

$home = 'main:process:receivableInvoiceGenerationCompany';
$navbar->addOption(_M('Receivable invoice generation company', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Receivable invoice generation company', $home, 'receivableInvoiceGenerationCompany-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();
$frmReceivableInvoiceGenerationCompany = $ui->getForm($module,'FrmReceivableInvoiceGenerationCompany', $data);
$frmReceivableInvoiceGenerationCompany->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

$content = $frmReceivableInvoiceGenerationCompany;
if ( $theme->page->generateMethod != 'generateAJAX' )
{
    $theme->clearContent($content);
    $theme->insertContent($content);
}
?>
