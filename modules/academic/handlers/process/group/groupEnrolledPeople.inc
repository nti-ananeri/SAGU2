<?php

/**
 * Group enrolled people handler.
 * Contains the enrolled people listing
 *
 * @author Leovan Tavares da Silva [leovan@solis.coop.br]
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
 * Class created on 12/04/2006
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
$MIOLO->checkAccess($module, ACD_INSERT, true, true);

$home = 'main:process:group:groupEnrolledPeople';
$navbar->addOption(_M('Offered curricular component enrolled pupils', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
//access::insert('Group enrolled people', $home, 'group-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');
$groupId  = MIOLO::_request('groupId');

$ui = $MIOLO->getUI();

$business = $MIOLO->getBusiness($module, 'BusEnroll');
$data     = $business->listGroupEnrolledPeople($groupId);

$grdGroupEnrolledPeople = $ui->getGrid($module,'GrdGroupEnrolledPeople', $filters);
$grdGroupEnrolledPeople->setData($data);

$business = $MIOLO->getBusiness($module, 'BusGroup');
$groupData = $business->getGroup($groupId);

$grdGroupEnrolledPeople->setTitle($groupData->curriculumCurricularComponentId . '/' .
                                  $groupData->curriculumCurricularComponentVersion . ' - ' .
                                  $groupData->curriculumCurricularComponentName);

$content = $grdGroupEnrolledPeople;

$theme->clearContent($content);
$theme->insertContent($content);

?>
