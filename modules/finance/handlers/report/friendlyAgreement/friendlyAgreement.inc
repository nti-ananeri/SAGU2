<?php
/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * 
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
//$data->personId = MIOLO::_request('personId') ? MIOLO::_request('personId') : MIOLO::_request('personId', 'GET');
$home = 'main:report:friendlyAgreement:friendlyAgreement';
$navbar->addOption(_M('Friendly agreements', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Friendly agreements', $home, 'friendlyAgreement-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();

$frmReportFriendlyAgreement = $ui->getForm($module, 'FrmReportFriendlyAgreement', $data);
$content = $frmReportFriendlyAgreement;

$theme->clearContent($content);
$theme->insertContent($content);

?>