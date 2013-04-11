<?php

/**
 * Basic people link generation handler.
 *
 * @author Daniel Afonso Heisler [daniel.heisler@gmail.com]
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
 * Class created on 29/01/2008
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
$MIOLO->checkAccess($module, BAS_INSERT, true, true);

$home = 'main:company:generatePeopleLink';
$navbar->addOption(_M('Generate people link', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Generate people link', $home, 'generatePeopleLink-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmGeneratePeopleLink = $ui->getForm($module,'FrmGeneratePeopleLink', $data);
$frmGeneratePeopleLink->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));
$content = $frmGeneratePeopleLink;

$theme->clearContent($content);
$theme->insertContent($content);

?>
