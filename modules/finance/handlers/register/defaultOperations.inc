<?php

/**
 * Finance counter handler.
 * Contains the menus to access counter registers
 *
 * @author Rafael Luís Spengler [rafael@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * Rafael Luís Spengler [rafael@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 03/01/2006
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

$home = 'main:register:defaultOperations';
$navbar->addOption(_M('Default operations', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Default operations', $home, 'defaultOperations-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
    
$frmCounter = $ui->getForm( $module, 'FrmDefaultOperations' );

$content = $frmCounter;

$theme->clearContent($content);
$theme->insertContent($content);

?>
