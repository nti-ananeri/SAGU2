<?php

/**
 * Insciption document handler.
 * Contains the menus to access inscription registers
 *
 * @author Rafael Luís Spengler [rafael@solis.coop.br] 
 *
 * @version: $Id$
 *
 * \b Maintainers \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * Rafael Luís Spengler [rafael@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 28/11/2005
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
$ui = $MIOLO->getUI();

$home = 'main:register:inscriptionOption';
$navbar->addOption(_M('Inscription', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Inscription', $home, 'inscriptionOption-16x16.png');

$function = MIOLO::_request('function');

$MIOLO->checkAccess($module, SPR_INSERT, true, true);

$frmInscriptionOption = $ui->getForm($module, 'FrmInscriptionOption');

$content = $frmInscriptionOption;

$theme->clearContent($content);
$theme->insertContent($content);


?>
