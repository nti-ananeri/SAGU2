<?php

/**
 * Basic center handler.
 * Contains the menus to access center processs
 *
 * @author Leovan Tavares da Silva [leovan@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 01/02/2006
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
$MIOLO->checkAccess($module, ACD_ENROLL, true, true);

$home = 'main:process:cancellation:enrollCancellation';
$navbar->addOption(_M('Enroll cancellation', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Enroll cancellation', $home, 'enrollCancellation-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmEnrollCancellation = $ui->getForm( $module, 'FrmEnrollCancelation');

$content = $frmEnrollCancellation;

$theme->clearContent($content);
$theme->insertContent($content);

?>
