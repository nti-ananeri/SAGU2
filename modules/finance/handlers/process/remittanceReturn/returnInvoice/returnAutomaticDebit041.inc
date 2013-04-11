<?php

/**
 * Finance import bank return generation handler.
 * Contains the menus to access income forecast generation process
 *
 * @author William Prigol Lopes [william@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 07/12/2005
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

$home = 'main:process:remittanceReturn:returnAutomaticDebit:returnAutomaticDebit041';

$navbar->addOption(_M('Return automatic debit', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert(_M('Return automatic debit to Banrisul', $module), $home, 'returnAutomaticDebit041-16x16.png');
$data->home = $home;
$ui = $MIOLO->getUI();

$content = $ui->getForm($module, 'FrmReturnAutomaticDebit041', $data);

$theme->clearContent($content);
$theme->insertContent($content);

?>
