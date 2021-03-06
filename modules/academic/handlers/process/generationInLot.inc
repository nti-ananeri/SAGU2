<?php

/**
 * Pupil assistance process handler.
 * Contains the menus to access process submenus
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
 * Class created on 25/01/2006
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

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process:generationInLot';
$navbar->addOption(_M('Generation in lot', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/generationInLot/' . $context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Generation in lot', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Generate multiple learning period',$module),          'generateMultipleLearningPeriod-16x16.png',         "$home:generateMultipleLearningPeriodCourse"),
		       array(_M('Generate multiple academic calendar',$module),        'generateMultipleAcademicCalendar-16x16.png',       "$home:generateMultipleAcademicCalendarCourse"),
		       array(_M('Generate multiple schedule learning period',$module), 'generateMultipleScheduleLearningPeriod-16x16.png', "$home:generateMultipleScheduleLearningPeriodCourse"),
		       array(_M('Generate multiple message contract renewal',$module), 'generateMultipleMessageContractRenewal-16x16.png', "$home:generateMultipleMessageContractRenewalCourse"),
		       array(_M('Generate multiple degree',$module),                   'generateMultipleDegree-16x16.png',                 "$home:generateMultipleDegreeCourse"),
		       array(_M('Generate multiple enroll periods',$module),       'generateMultiplePeriodEnrollDate-16x16.png',       "$home:generateMultiplePeriodEnrollDateCourse"),
		       array(_M('Generate multiple exam date', $module), 'generateMultipleExamDate-16x16.png', "$home:generateMultipleExamDateCourse"),
		       array(_M('Generate multiple class pupil', $module), 'generateMultipleClassPupil-16x16.png', "$home:generateMultipleClassPupil"),
		       array(_M('Generate multiple complementary activities', $module), 'generateMultipleComplementaryActivities-16x16.png', "$home:generateMultipleComplementaryActivitiesPupils"),
   		       array(_M('Print report card in lot', $module), 'printReportCardInLot-16x16.png', "$home:printReportCardInLot"), 
   		       array(_M('Print call list in lot', $module), 'printCallListInLot-16x16.png', "$home:printCallListInLot"), 
   		       array(_M('Print scolarship description in lot', $module), 'printScolarshipDescriptionInLot-16x16.png', "$home:printScolarshipDescriptionInLot")
                  );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlAcademic->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlAcademic);

}

?>
