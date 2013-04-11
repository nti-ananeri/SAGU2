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
 * Class created on 18/12/2008
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

$home = 'main:process:generationInLot:generateInvoicesInLot';

$navbar->addOption(_M('Generate invoices in lot', $module), $module, $home);

$ui = $MIOLO->getUI();

$content = $ui->getForm($module, 'FrmGenerateInvoicesInLot');

$theme->clearContent($content);
$theme->insertContent($content);

?>
