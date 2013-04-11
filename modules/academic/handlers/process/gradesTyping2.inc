<?php
/**
 * Pupil grades typing handler.
 * Used to allow the professor to register the pupils grades for the specified group
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
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

$home = 'main:process:gradesTyping';
//$navbar->addOption(_M('Professor curricular components', 'services'), 'services', substr($home, 0, strrpos($home, ':')+1) . 'curricularComponents', null, array('periodId' => MIOLO::_request('periodId')));
$navbar->addOption(_M('Grade typing', $module), 'academic', $home, null, array('function' => 'resetStack'));

$MIOLO->checkAccess($module, ACD_UPDATE, true, true);
$MIOLO->checkAccess($module, ACD_INSERT, true, true);

$ui              = $MIOLO->getUI();
$frmGradesTyping = $ui->getForm('services', 'FrmProfessorGradesTypingNew');
$frmGradesTyping->setClose($MIOLO->getActionURL('services',substr($home, 0, strrpos($home, ':'))));
$theme->clearContent();
$theme->insertContent($frmGradesTyping);

?>
