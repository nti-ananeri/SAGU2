<?php

/**
 * List selective process handler.
 * Contains the menus to access selective process type registers
 *
 * @author Hélio H. R. Guimarães [helio@solis.coop.br]
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
 * Class created on 02/05/2006
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

$home = 'main:report:listInscriptionBySpecialNecessity';
$navbar->addOption(_M('List selective process', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('List selective process', $home, 'listInscription-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');
$ui       = $MIOLO->getUI();

$frmListInscriptionBySpecialNecessitySearch = $ui->getForm($module,'FrmListInscriptionBySpecialNecessitySearch', $data);
$frmListInscriptionBySpecialNecessitySearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

$content = $frmListInscriptionBySpecialNecessitySearch;

$theme->clearContent($content);
$theme->insertContent($content);

?>
