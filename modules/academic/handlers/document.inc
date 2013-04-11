<?php

/**
 * Academic document handler.
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
 * Class created on 08/05/2006
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

$home = 'main:document';
$navbar->addOption(_M('Document', $module), $module, $home, null, array('function'=>'resetStack'));
if ( !$MIOLO->invokeHandler($module,'document/'.$context->shiftAction()) )
{
    $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImage($module,'document-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Document', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array (_M('Attendance and Examination act', $module), 'examinationAct-16x16.png', "$home:examinationAct"),
                       array (_M('Contract', $module),  'folder-16x16.png', "$home:contract"),
                       array (_M('Certified', $module), 'folder-16x16.png', "$home:certified"),
                       array (_M('Scolarship description', $module), 'scolarshipDescription-16x16.png', "$home:scolarshipDescription"),
                       array(_M('Possibilities and material of enroll', $module), 'possibilitiesAndMaterialOfEnroll-16x16.png', "$home:possibilitiesAndMaterialOfEnroll"),
                       array (_M('Enroll book data', $module), 'enrollBook-16x16.png', "$home:enrollBook"),
                       array (_M('Letter for cancelled pupils', $module), 'cancelledPupils-16x16.png', "$home:cancelledPupils"),
                       array (_M('Academic register layer', $module), 'academicRegisterLayer-16x16.png', "$home:academicRegisterLayer"),
                       array (_M('Label for examination', $module), 'examinationLabel-16x16.png', "$home:examinationLabel"),
                       array (_M('Label for pupil folder', $module), 'pupilFolder-16x16.png', "$home:pupilFolder"),
                       array (_M('Letter for professors', $module), 'letterProfessor-16x16.png', "$home:letterProfessor"),
                       array(_M('Possibilities and material of enroll after graduation', $module), 'possibilitiesAndMaterialOfEnrollAfterGraduation-16x16.png', "$home:possibilitiesAndMaterialOfEnrollAfterGraduation"),
                       array (_M('Semester schedule', $module), 'semesterSchedule-16x16.png', "$home:semesterSchedule"),
                       array (_M('Enroll confirmation', $module), 'enrollConfirmation-16x16.png', "$home:enrollConfirmation"),
                       array (_M('Diploma', $module), 'folder-16x16.png', "$home:diploma"),
                       array (_M('Boletim', $module), 'boletim-16x16.png', "$home:schoolYield"),
                       array (_M('School yield', $module), 'schoolYield-16x16.png', "$home:schoolYield"),
                       array (_M('Student card', $module), 'folder-16x16.png', "$home:studentCard"),
                       array (_M('Examination frequence', $module), 'examinationFrequence-16x16.png', "$home:examinationFrequence"),
                       array (_M('Result final act', $module), 'resultFinalAct-16x16.png', "$home:resultFinalAct"),
                       array (_M('Termo de Compromisso de Estágio', $module), 'resultFinalAct-16x16.png', "$home:internshipTerm"),
                       array (_M('MEC', $module), 'folder-16x16.png', "$home:mec"),
                       array (_M('Pupil cadastral sheet', $module), 'pupilCadastralSheet-16x16.png', "$home:pupilCadastralSheet"),
                       array (_M('Generation in lot',$module), 'folder-16x16.png', "$home:inLot", null, array('function'=>'resetStack')),
                       array (_M('Curriculum',$module), 'curriculumDoc-16x16.png', "$home:curriculumDoc")
                 );

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
