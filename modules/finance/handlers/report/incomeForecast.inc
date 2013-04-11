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
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
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
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

$home = 'main:report:incomeForecast';
$navbar->addOption(_M('Income forecast', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Income forecast', $home, 'incomeForecast-16x16.png');
$data->home = $home;
        
$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmIncomeForecast = $ui->getForm($module,'FrmIncomeForecastReportSearch', $data);
$frmIncomeForecast->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));
$content = $frmIncomeForecast;

if ( $theme->page->generateMethod != 'generateAJAX' )
{
    $theme->clearContent($content);
    $theme->insertContent($content);
}
?>
