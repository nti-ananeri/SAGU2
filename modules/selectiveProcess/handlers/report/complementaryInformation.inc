<?php

/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author Rafael Luís Spengler [rafael@solis.coop.br]
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

$home = 'main:report:complementaryInformation';
$navbar->addOption(_M('Complementary information', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Complementary information', $home, 'complementaryInformation-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmComplementaryInformation = $ui->getForm($module,'FrmComplementaryInformation', $data);
$frmComplementaryInformation->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content = $frmComplementaryInformation;

$theme->clearContent($content);
$theme->insertContent($content);

?>
