<?php

/**
 * Academic register handlet.
 * Contains the menus to access register submenus
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
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

$home = 'main:register';
$navbar->addOption(_M('Register', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/'.$context->shiftAction()) )
{
    if ( !$MIOLO->checkAccess($module_, ACD_REGISTER, false, true) ) 
    {
        $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
    }


    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImage($module,'register-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Register', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);
    if ( $MIOLO->checkAccess($module, ACD_ACCESS, false, true) )
    {
    $menuItem = array( 
                       array(_M('Professor formation',$module), 'professorFormation-16x16.png', "$home:professorFormation"),
                       array(_M('Professor center',$module), 'professorCenter-16x16.png', "$home:professorCenter"),
                       array(_M('Restricted documents',$module), 'restrictedDocuments-16x16.png', "$home:restrictedDocuments"),
                       array(_M('Formation level',$module), 'formationLevel-16x16.png', "$home:formationLevel"),
                       array(_M('Certified',$module), 'folder-16x16.png', "$home:certified", null, array('function'=>'resetStack')),
                       array(_M('Education area (technician)',$module), 'educationArea-16x16.png', "$home:educationArea"),
                       array(_M('Center',$module), 'center-16x16.png', "$home:center"),
                       array(_M('Reason',$module), 'folder-16x16.png', "$home:reasons"),
                       array(_M('Academic degree',$module), 'degree-16x16.png', "$home:degree"),
                       array(_M('Evaluation',$module), 'evaluation-16x16.png', "$home:evaluation"),
                       array(_M('Knowledge area (superior)',$module), 'knowledgeArea-16x16.png', "$home:knowledgeArea"),
                       array(_M('External course',$module), 'externalCourse-16x16.png', "$home:externalCourse"),
                       array(_M('Period',$module), 'period-16x16.png', "$home:period"),
                       array(_M('Election',$module), 'election-16x16.png', "$home:election"),
                       array(_M('Regimen',$module), 'regimen-16x16.png', "$home:regimen"),
                       array(_M('Course end test',$module), 'folder-16x16.png', "$home:testEndCourse", null, array('function'=>'resetStack')),
                       array(_M('Curricular component',$module), 'folder-16x16.png', "$home:curricularComponent", null, array('function'=>'resetStack')),
                       array(_M('Course',$module), 'folder-16x16.png', "$home:course", null, array('function'=>'resetStack')),
                       array(_M('Curriculum matrix',$module), 'folder-16x16.png', "$home:curriculum", null, array('function'=>'resetStack')),
                       array(_M('Learning period',$module), 'learningPeriod-16x16.png', "$home:learningPeriod"),
                       array(_M('Interchange', $module), 'folder-16x16.png', "$home:interchange", null, array('function'=>'resetStack')),
                       //array(_M('Grade typing to evaluation',$module), 'evaluationEnroll-16x16.png', "$home:evaluationEnroll"),
                       array(_M('Enroll period',$module), 'periodEnrollDate-16x16.png', "$home:periodEnrollDate"),
                       array(_M('Academic calendar',$module), 'folder-16x16.png', "$home:academicCalendar", null, array('function'=>'resetStack')),
                       //array(_M('Offered curricular component',$module), 'folder-16x16.png', "$home:group", null, array('function'=>'resetStack')),
    	               array(_M('Schedule learning period',$module),     'scheduleLearningPeriod-16x16.png', "$home:scheduleLearningPeriod"),
                       array(_M('Contract',$module), 'folder-16x16.png', "$home:contract", null, array('function'=>'resetStack')),
                       array(_M('Complementary activity', $module), 'folder-16x16.png', "$home:complementaryActivities", null, array('function'=>'resetStack')),
                       array(_M('Enroll summary', $module), 'enrollSummary-16x16.png', "$home:enrollSummary", null, array('function'=>'resetStack')),
                       array(_M('Exam dates', $module), 'examDate-16x16.png', "$home:examDate"),
                       array(_M('Event', $module), 'folder-16x16.png', "$home:event", null, array('function'=>'resetStack')),
                       array(_M('Class', $module), 'folder-16x16.png', "$home:class", null, array('function'=>'resetStack')),
                       array(_M('Table of vacancies', $module), 'folder-16x16.png', "$home:tableOfVacancies", null, array('function'=>'resetStack')),
                       array(_M('Training', $module), 'folder-16x16.png', "$home:training", null, array('function'=>'resetStack'))
                       );
    }
    else
    {
        if ( $MIOLO->checkAccess($module, ACD_SCHEDULE_LEARNING_PERIOD, false, true) )
        {
            $menuItem[] = array(_M('Schedule learning period',$module),     'scheduleLearningPeriod-16x16.png', "$home:scheduleLearningPeriod");
        }
        if ( $MIOLO->checkAccess($module, ACD_ACADEMIC_CALENDAR, false, true) || $MIOLO->checkAccess($module, ACD_ACADEMIC_CALENDAR_ADJUSTMENT, false, true) )
        {
            $menuItem[] = array(_M('Academic calendar',$module), 'folder-16x16.png', "$home:academicCalendar", null, array('function'=>'resetStack'));
        }
        if ( $MIOLO->checkAccess($module, ACD_CLASS, false, true)  )
        {
            $menuItem[] = array(_M('Class', $module), 'folder-16x16.png', "$home:class", null, array('function'=>'resetStack'));
        }
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
