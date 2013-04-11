<?php

/**
 * Basic invoice print handler.
 * Contains the menus to access center registers
 *
 * @author Daniel Afonso Heisler [daniel.heisler@gmail.com]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 *
 * @since
 * Class created on 27/09/2007
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
$MIOLO->checkAccess($module, FIN_INSERT, true, true);

$home = 'main:report:closePeriodInvoices';
$navbar->addOption(_M('Close invoice', $module) . 's', $module, $home);

$ui = $MIOLO->getUI();

$frmInvoices = $ui->getForm($module,'FrmClosePeriodInvoice', $data);
$frmInvoices->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));
$content     = $frmInvoices;

$theme->clearContent($content);
$theme->insertContent($content);

?>
