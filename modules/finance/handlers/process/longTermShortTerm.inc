<?php

/**
 * Finance income forecast generation handler.
 * Contains the menus to access income forecast generation process
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
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
$MIOLO->checkAccess($module, FIN_INCOME_FORECAST_GENERATION, true, true);

$home = 'main:process:longTermShortTerm';

$navbar->addOption(_M('Long term to short term', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Long term to short term', $home, 'longTermShortTerm-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();

$content = $ui->getForm($module, 'FrmLongTermShortTerm', $data);

$theme->clearContent($content);
$theme->insertContent($content);

?>
