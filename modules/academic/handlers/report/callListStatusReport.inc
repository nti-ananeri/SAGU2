<?php

/**
 * Basic center handler.
 * Contains the handler to connect professor daily report
 *
 * @author Daniel Afonso Heisler [daniel@hsti.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@hsti.inf.br]
 *
 * @since
 * Class created on 22/07/2008
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
if ( !$MIOLO->checkAccess($module, ACD_REPORT, false, true ) )
{
    $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
}

$home = 'main:report:callListStatusReport';
$navbar->addOption(_M('Call list status', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Call list status report', $home, 'callListStatusReport-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frm = $ui->getForm($module,'FrmCallListStatusReport', $data);
$frm->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content = $frm;

$theme->clearContent($content);
$theme->insertContent($content);

?>
