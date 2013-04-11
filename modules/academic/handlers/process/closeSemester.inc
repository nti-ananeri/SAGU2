<?php
/**
 * Professor close semester handler.
 * Shows all the curricular components the professor has ministered
 *
 * @author Daniel Afonso Heisler [daniel@hsti.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 05/09/2007
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

$home = 'main:professor:closeSemester';
$navbar->addOption(_M('Close curricular component', 'services'), 'services', $home, null, array('function' => 'resetStack'));

$ui = $MIOLO->getUI();


$ui               = $MIOLO->getUI();
$frmCloseSemester = $ui->getForm('academic', 'FrmCloseSemester', $data);
$frmCloseSemester->setClose($MIOLO->getActionURL('academic',substr($home, 0, strrpos($home, ':'))));
$theme->clearContent();
$theme->insertContent($frmCloseSemester);

?>
