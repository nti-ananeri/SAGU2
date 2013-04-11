<?php
/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author Daniel Afonso Heisler [danie.heisler@gmail.com]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 17/01/2008
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

$home = 'main:report:enrollTaxReport';
$navbar->addOption(_M('Enroll tax', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Enroll tax', $home, 'enrollTaxReport-16x16.png');

$ui = $MIOLO->getUI();

$frmEnrollTaxReport = $ui->getForm($module, 'FrmEnrollTaxReport', $data);
$content = $frmEnrollTaxReport;

$theme->clearContent($content);
$theme->insertContent($content);

?>
