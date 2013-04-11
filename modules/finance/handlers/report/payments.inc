<?php
/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author William Prigol Lopes [william@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 26/08/2005
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
 */

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);
$data->personId = MIOLO::_request('personId') ? MIOLO::_request('personId') : MIOLO::_request('personId', 'GET');
$home = 'main:report:payments';
$navbar->addOption(_M('Payments', $module), $module, $home);

//$MIOLO->getClass('basic', 'access');
//access::insert('Payments', $home, 'receivableInvoice-16x16.png');

$ui = $MIOLO->getUI();

$frmPayments = $ui->getForm($module, 'FrmPayments', $data);
$content = $frmPayments;

$theme->clearContent($content);
$theme->insertContent($content);

?>
