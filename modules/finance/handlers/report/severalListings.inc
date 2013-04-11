<?php
/**
 *
 * @author Giovani Murilo Dantas Corrêa [gmurilo@isolution.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@isolution.inf.br]
 *
 * @since
 * Class created on 01/09/2008
 *
 * \b Organization: \n
 * iSolution - Soluções em TI
 * The iSolution Development Team
 *
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
$home = 'main:report:severalListings';
$navbar->addOption(_M('Several listings', $module), $module, $home);

$data->home = $home;

$MIOLO->getClass('basic', 'access');
access::insert('Several listings', $home, 'severalListings-16x16.png');

$ui = $MIOLO->getUI();

$frmSeveralListings = $ui->getForm($module, 'FrmSeveralListings', $data);
$content = $frmSeveralListings;

$theme->clearContent($content);
$theme->insertContent($content);

?>
