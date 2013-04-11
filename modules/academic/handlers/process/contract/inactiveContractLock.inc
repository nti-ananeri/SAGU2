<?php

/**
 * Academic inactive contract handler.
 * Contains the program to change a contract course
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
 * Class created on 28/01/2007
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
$MIOLO->checkAccess($module, ACD_INSERT, true, true);

$home = 'main:process:contract:inactiveContractLock';
$navbar->addOption(_M('Inactive contract lock', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Inactive contract lock', $home, 'inactiveContractLock-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmInactiveContractLock = $ui->getForm( $module, 'FrmInactiveContractLock', $data);

$content = $frmInactiveContractLock;

$theme->clearContent($content);
$theme->insertContent($content);

?>
