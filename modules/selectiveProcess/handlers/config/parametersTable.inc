<?php

/**
 * Academic parameters table handler.
 * Contains the menus to access the parameters table registers
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
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
 * Class created on 27/07/2006
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
$MIOLO->checkAccess($module, SPR_ADMIN, true, true);

$home = 'main:config:parametersTable';
$navbar->addOption(_M('Parameters table', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Parameters table', $home, 'parameters-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();
$frmParametersTable = $ui->getForm('basic','FrmParametersTable2', $data);
$frmParametersTable->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));
$theme->clearContent($frmParametersTable);
$theme->insertContent($frmParametersTable);

?>
