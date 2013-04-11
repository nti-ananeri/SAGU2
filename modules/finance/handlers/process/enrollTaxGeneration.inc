<?php

/**
 * Enroll tax generation handler.
 *
 * @author Daniel Afonso Heisler [daniel.heisler@gmail.com.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 27/11/2007
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

$home = 'main:process:enrollTaxGeneration';
$navbar->addOption(_M('Enroll tax generation', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Enroll tax generation', $home, 'enrollTaxGeneration-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();
$frmEnrollTaxGeneration = $ui->getForm($module,'FrmEnrollTaxGeneration', $data);
$frmEnrollTaxGeneration->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

$content = $frmEnrollTaxGeneration;

$theme->clearContent($content);
$theme->insertContent($content);

?>
