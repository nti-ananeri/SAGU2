<?php

/**
 * Finance import bank return generation handler.
 * Contains the menus to access income forecast generation process
 *
 * @author Daniel Afonso Heisler [daniel@hsti.inf.br]
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
 * Class created on 20/09/2007
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

$home = 'main:process:remittanceReturn:returnInvoice:returnInvoice104';

$navbar->addOption(_M('Return invoice for @1', $module, 'Caixa Econ�mica Federal'), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert(_M('Return invoice for @1', $module, 'Caixa Econ�mica Federal'), $home, 'returnInvoice748-16x16.png');
$data->home = $home;
$ui = $MIOLO->getUI();

$content = $ui->getForm($module, 'FrmReturnInvoice104', $data);

$theme->clearContent($content);
$theme->insertContent($content);

?>
