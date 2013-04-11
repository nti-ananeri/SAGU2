<?php

/**
 * Academic register handler.
 * Contains the menus to access register submenus
 *
 * @author William Prigol Lopes [william@solis.coop.br]
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
 * Class created on 24/08/2005
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

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:report';
$navbar->addOption(_M('Report', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module, 'report/'.$context->shiftAction()) )
{
    if ( !$MIOLO->checkAccess($module, ACD_REPORT, false, true ) )
    {
        $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
    }
    
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':')));

    $icon        = $ui->getImage($module, 'report-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Report', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array(
//                        array(_M('Exam acts and conference list', $module), 'examsActsAndConferenceList-16x16.png', "$home:examsActsAndConferenceList"),
                       //array(_M('Possibilities and material of enroll', $module), 'possibilitiesAndMaterialOfEnroll-16x16.png', "$home:possibilitiesAndMaterialOfEnroll"),
//                       array (_M('Learning period schedule', $module), 'learningperiodschedule-16x16.png', "$home:learningperiodschedule"),
//                        array (_M('Letter of professors', $module), 'letterProfessors-16x16.png', "$home:letterProfessors"),
//                       array(_M('CSV pupil listing',$module),          'csvPupilListing-16x16.png',        "$home:csvPupilListing", null, array('function'=>'resetStack')),
//                       array(_M('Other pupil listing',$module),          'pupilListing-16x16.png',        "$home:pupilListingNew", null, array('function'=>'resetStack')),
//                       array (_M('Repetition listing', $module), 'repetitionList-16x16.png', "$home:repetitionList"),
//                       array (_M('Professors with schedule register delayed', $module), 'professorsWithDailyDelayed-16x16.png', "$home:professorsWithDailyDelayed"),
//                       array (_M('Professors with daily not closed', $module), 'professorsWithDailyClosed-16x16.png', "$home:professorsWithDailyClosed"),
                        array (_M('Exploitations', $module), 'exploitationReport-16x16.png', "$home:exploitationReport"),
                        array (_M('Call list status', $module), 'callListStatusReport-16x16.png', "$home:callListStatusReport"),
                        array(_M('Pupil listing', $module), 'pupilReport-16x16.png', "$home:pupilReport"),
                        //array (_M('Pupils card', $module), 'studentSemtur-16x16.png', "$home:studentSemtur"),
//                       array (_M('Student curricular component situation', $module), 'studentCurricularComponentSituation-16x16.png', "$home:studentCurricularComponentSituation"),
//                       array (_M('Listings for sense', $module), 'listingForSense-16x16.png', "$home:listingForSense"),
//                       array (_M('Classes x enroll fee', $module), 'classesEnrollFee-16x16.png', "$home:classesEnrollFee"),
                        array (ucfirst (_M('pupils enrolled', $module)), 'enrolledPupilsReport-16x16.png', "$home:enrolledPupilsReport"),
                        array (ucfirst (_M('Cancelled pupils', $module)), 'cancelledPupilsReport-16x16.png', "$home:cancelledPupilsReport"),
                        array (ucfirst (_M('Documentos pendentes', $module)), 'missingDocumentsReport-16x16.png', "$home:missingDocumentsReport"),
                        array (ucfirst (_M('Class pupil', $module)), 'enrolledPupilsReport-16x16.png', "$home:classPupilReport")
                     );
    $acAdmin = $MIOLO->checkAccess($module, FIN_ADMIN, false, false);
    if ( $acAdmin )
    {
        $menuItem[] = array(_M('Disciplinas dos professores (totalizadas)', $module), 'report-16x16.png', "$home:professorGroupReport");
    }
    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlAcademic->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlAcademic->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlAcademic);

}

?>
