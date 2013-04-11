<?php

/**
 * Group enrolled people handler.
 * Contains the enrolled people listing
 *
 * @author Hélio Henrique Rodrigues Guimarães [helio@solis.coop.br]
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
 * Class created on 21/07/2007
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
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$home = 'main:frequencyPupils';
$navbar->addOption(_M('Frequency pupils', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
$data->home         = $home;
$ui                 = $MIOLO->getUI();
$function           = MIOLO::_request('function');

$groupId            = MIOLO::_request('groupId');
$enrollId           = MIOLO::_request('enrollId');
$data->groupId      = $groupId;
$data->enrollId     = $enrollId;


$frmPupilSituation = $ui->getForm($module, 'FrmFrequencyPupils', $data);
$content = $frmPupilSituation;

if ( $theme->page->generateMethod != 'generateAJAX' )
{
    $theme->clearContent($content);
    $theme->insertContent($content);
}

?>
