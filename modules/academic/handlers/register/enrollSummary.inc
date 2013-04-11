<?php

/**
 * This handler calls the enroll summary form.
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 18/05/2006
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

$home = 'main:register:enrollSummary';

$navbar->addOption(_M('Enroll summary', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert(_M('Enroll summary', $module), $home, 'enrollSummary-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();

$content = $ui->getForm($module, 'FrmEnrollSummarySearch', $data);

$theme->clearContent($content);
$theme->insertContent($content);

?>
