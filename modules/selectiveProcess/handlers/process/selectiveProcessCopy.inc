<?php

/**
 * This handler calls the print invoices in lot form.
 *
 * @author Giovani Murilo Dantas Corrêa [gmurilo@isolution.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@isolution.inf.br]
 *
 * @since
 * Class created on 27/11/2008
 *
 * \b Organization: \n
 * iSolution - Soluções Em Ti \n
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
$MIOLO->checkAccess($module, SPR_ACCESS, true, true);

$home = 'main:process:selectiveProcessCopy';
$navbar->addOption(_M('Selective process copy', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Selective process copy', $home, 'selectiveProcessCopy-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');
$ui       = $MIOLO->getUI();

$frmSelectiveProcessCopy = $ui->getForm( $module, 'FrmSelectiveProcessCopy', $data );

$content = $frmSelectiveProcessCopy;

$theme->clearContent();
$theme->insertContent($content);

?>
