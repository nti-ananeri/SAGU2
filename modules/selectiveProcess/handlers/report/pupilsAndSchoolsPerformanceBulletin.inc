<?php

/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author Rafael Lu�s Spengler [rafael@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 *
 * @since
 * Class created on 08/12/2005
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
$MIOLO->checkAccess($module, SPR_ACCESS, true, true);

$home = 'main:report:pupilsAndSchoolsPerformanceBulletin';
$navbar->addOption(_M('Pupils and schools performance bulletin', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert(_M('Pupils and schools performance bulletin', $module), $home, 'pupilsAndSchoolsPerformanceBulletin-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmOtherListings = $ui->getForm($module,'FrmPupilsAndSchoolsPerformanceBulletin', $data);
$frmOtherListings->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content = $frmOtherListings;

$theme->clearContent($content);
$theme->insertContent($content);

?>
