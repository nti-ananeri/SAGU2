<?php

/**
 * Course account handler.
 * Contains the menus to access course account registers
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 25/09/2006
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
$MIOLO->checkAccess($module, ACC_ACCESS, true, true);

$home = 'main:process:accountancyBalance';
$navbar->addOption(_M('Accountancy balances', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert(_M('Accountancy balances', $module), $home, 'accountancyBalance-16x16.png');

$ui = $MIOLO->getUI();

$data->home = $home;
$frmAccountancyBalance = $ui->getForm( $module, 'FrmAccountancyBalance', $data );
$content = $frmAccountancyBalance;

$theme->clearContent($content);
$theme->insertContent($content);

?>
