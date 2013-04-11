<?php
/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author Hélio Henrique Rodrigues Guimarães [helio@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * 
 *
 * @since
 * Class created on 08/11/2006
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
 */

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess('finance', FIN_ACCESS, true, true);

$home = 'main:pupilSituation';
$navbar->addOption(_M('Pupil situation', $module), $module, $home);
$ui = $MIOLO->getUI();

$frmPupilSituation = $ui->getForm($module, 'FrmPupilSituation', $data);
$content = $frmPupilSituation;

if ( $theme->page->generateMethod != 'generateAJAX' )
{
    $theme->clearContent($content);
    $theme->insertContent($content);
}

?>
