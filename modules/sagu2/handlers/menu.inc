<?php
/**
 * Sagu2 menu main handler.
 * Contains the basic menus to access submenus
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
 *
 * @since
 * Class created on 09/08/2006
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
    $MIOLO->Uses('classes/sagu.class', 'basic');

    //SAGU2::Main
    $mainMenu = $theme->getMainMenu();
    $mainMenu->setTitle(_M('Main menu', 'basic'));

    //SAGU2::Academic
    $module_ = 'academic';
    if ( $MIOLO->checkAccess($module_, ACD_ACCESS, false, true) || 
         $MIOLO->checkAccess($module_, ACD_DOCUMENT, false, true) || 
         $MIOLO->checkAccess($module_, ACD_REPORT, false, true)  || 
         $MIOLO->checkAccess($module_, ACD_REGISTER, false, true)  || 
         $MIOLO->checkAccess($module_, ACD_PROCESS, false, true) )
    {
        $_module_ = 'academic';
        $acdMenu = $mainMenu->getMenu($_module_);
        $acdMenu->setTitle(_M('Academic', $_module_), 'academic-16x16.png', 'academic_-16x16.png', $_module_, 'main');

        if ( $MIOLO->checkAccess($module_, ACD_ACCESS, false, true) || $MIOLO->checkAccess($module_, ACD_REGISTER, false, true) )
        {
            //SAGU2::Academic::Register
            $home_       = 'main:register';
            $acdRegister = $acdMenu->getMenu('acdRegister');
            $acdRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
        }
/*
        //SAGU2::Academic::Register::Certified
        $acdCertified = $acdRegister->getMenu('acdCertified');
        $acdCertified->setTitle(_M('Certified', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:certified");

        $menuItem = array( 
                           array(_M('Certified',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:certified"),
                           array(_M('Certified type',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:certifiedType")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdCertified->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Complementary activities
        $acdComplementaryActivities = $acdRegister->getMenu('acdComplementaryActivities');
        $acdComplementaryActivities->setTitle(_M('Complementary activities', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:complementaryActivities");

        $menuItem = array( 
                           array(_M('Complementary activities',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:complementaryActivities:complementaryActivities"),
                           array(_M('Complementary activities category',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:complementaryActivities:complementaryActivitiesCategory")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdComplementaryActivities->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Test end course
        $acdTestEndCourse = $acdRegister->getMenu('acdTestEndCourse');
        $acdTestEndCourse->setTitle(_M('Test end course', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:testEndCourse");

        $menuItem = array( 
                           array(_M('Test end course contract',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:testEndCourse:testEndCourseContract"),
                           array(_M('Test end course type',$_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:testEndCourse:testEndCourseType")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdTestEndCourse->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Academic calendar
        $acdAcademicCalendar = $acdRegister->getMenu('acdAcademicCalendar');
        $acdAcademicCalendar->setTitle(_M('Academic calendar', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:academicCalendar");

        $menuItem = array( 
                           array(_M('Academic calendar',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:academicCalendar:academicCalendar"),
                           array(_M('Academic calendar adjustments',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:academicCalendar:academicCalendarAdjustments")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdAcademicCalendar->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Contract
        $acdContract = $acdRegister->getMenu('acdContract');
        $acdContract->setTitle(_M('Contract', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:contract");

        $menuItem = array( 
                           array(_M('Movement contract complement',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:movementContractComplement"),
                           array(_M('Contract',$_module_),                  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:contract"),
                           array(_M('Message contract renewal',$_module_),  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:messageContractRenewal"),
                           array(_M('Movement contract',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:movementContract")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdContract->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Curriculum
        $acdCurriculum = $acdRegister->getMenu('acdCurriculum');
        $acdCurriculum->setTitle(_M('Curriculum', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:curriculum");

        $menuItem = array( 
                           array(_M('Curriculum concurrence',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curriculum:curriculumConcurrence"),
                           array(_M('Curriculum',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curriculum:curriculum"),
                           array(_M('Curriculum type',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curriculum:curriculumType"),
                           array(_M('Curriculum link',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curriculum:curriculumLink")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdCurriculum->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Course
        $acdCourse = $acdRegister->getMenu('acdCourse');
        $acdCourse->setTitle(_M('Course', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:course");

        $menuItem = array( 
                           array(_M('Course ability (technician)',$_module_),  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:course:courseAbility"),
                           array(_M('Course version type',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:course:courseVersionType"),
                           array(_M('Course coordinator',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:course:courseCoordinator"),
                           array(_M('Course occurrence',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:course:courseOccurrence"),
                           array(_M('Course version',$_module_),              'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:course:courseVersion"),
                           array(_M('Course',$_module_),                      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:course:course")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdCourse->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Curricular component
        $acdCurricularComponent = $acdRegister->getMenu('acdCurricularComponent');
        $acdCurricularComponent->setTitle(_M('Curricular component', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:curricularComponent");

        $menuItem = array( 
                           array(_M('Curricular component',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curricularComponent:curricularComponent"),
                           array(_M('Curricular component group',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curricularComponent:curricularComponentGroup"),
                           array(_M('Curricular component type',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curricularComponent:curricularComponentType")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdCurricularComponent->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Event
        $acdEvent = $acdRegister->getMenu('acdEvent');
        $acdEvent->setTitle(_M('Event', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:event");

        $menuItem = array( 
                           array(_M('Event participation',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:event:eventParticipation"),
                           array(_M('Event',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:event:event")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdEvent->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Interchange
        $acdInterchange = $acdRegister->getMenu('acdInterchange');
        $acdInterchange->setTitle(_M('Interchange', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:interchange");

        $menuItem = array( 
                           array(_M('Interchange',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:interchange:interchange"),
                           array(_M('Interchange type',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:interchange:interchangeType")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdInterchange->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Reason
        $acdReason = $acdRegister->getMenu('acdReason');
        $acdReason->setTitle(_M('Reason', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:reason");

        $menuItem = array( 
                           array(_M('Reason',$_module_),              'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:reason:reason"),
                           array(_M('Reason cancellation',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:reason:reasonCancellation")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdReason->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Register::Group
        $acdGroup = $acdRegister->getMenu('acdGroup');
        $acdGroup->setTitle(_M('Group', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:group");

        $menuItem = array( 
                           array(_M('Schedule',$_module_),                 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:group:schedule"),
                           array(_M('Schedule learning period',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:group:scheduleLearningPeriod"),
                           array(_M('Schedule professor',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:group:scheduleProfessor"),
                           array(_M('Group',$_module_),                    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:group:group")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdGroup->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Formation level',$_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:formationLevel"),
                           array(_M('Education area (technician)',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:educationArea"),
                           array(_M('Center',$_module_),                      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:center"),
                           array(_M('Degree by learning period',$_module_),   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:degree"),
                           array(_M('Evaluation',$_module_),                  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:evaluation"),
                           array(_M('Knowledge area (superior)',$_module_),   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:knowledgeArea"),
                           array(_M('External course',$_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:externalCourse"),
                           array(_M('Period',$_module_),                      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:period"),
                           array(_M('Election',$_module_),                    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:election"),
                           array(_M('Regimen',$_module_),                     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:regimen"),
                           array(_M('Learning period',$_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:learningPeriod"),
                           array(_M('Condition',$_module_),                   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:condition"),
                           array(_M('Grade typing',$_module_),                'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:evaluationEnroll"),
                           array(_M('Period enroll date',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:periodEnrollDate"),
                           array(_M('Enroll summary', $_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:enrollSummary"),
                           array(_M('Exam dates', $_module_),                 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:examDate"),
                           array(_M('Programmarian content', $_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:programmarianContent")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Academic::Document
        if ( $MIOLO->checkAccess($module, ACD_ACCESS, false, false) || $MIOLO->checkAccess($module, ACD_DOCUMENT, false, false) )
        {
            $home_       = 'main:document';
            $acdDocument = $acdMenu->getMenu('acdDocument');
            $acdDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);
        }
/*
        //SAGU2::Academic::Document::Certified
        $acdCertified2 = $acdDocument->getMenu('acdCertified2');
        $acdCertified2->setTitle(_M('Certified', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:certified");

        $menuItem = array( 
                           array(_M('Course enroll',$_module_),                 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:courseEnroll"),
                           array(_M('Curricular component enroll',$_module_),  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:curricularComponentEnroll"),
                           array(_M('Period curricular components',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:periodCurricularComponent"),
                           array(_M('General curricular components',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:generalCurricularComponent"),
                           array(_M('COREN declaration',$_module_),            'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:corenDeclaration"),
                           array(_M('COREN certified',$_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:corenCertified"),
                           array(_M('Professor certified',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:professorCertified"),
                           array(_M('Semester certified',$_module_),            'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:semesterCertified"),
                           array(_M('Link certified',$_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:linkCertified"),
                           array(_M('Journey aid',$_module_),                    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:journeyAid"),
                           array(_M('Sub-Judicial',$_module_),                    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:certified:subJudicial"),
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdCertified2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Document::Contract
        $acdContract2 = $acdDocument->getMenu('acdContract');
        $acdContract2->setTitle(_M('Contract', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:contract");

        $menuItem = array( 
                           array(_M('Graduation',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:graduation"),
                           array(_M('Extension',$_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:extension"),
                           array(_M('Technican',$_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:technican"),
                           array(_M('After-Graduation',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:afterGraduation"),
                           array(_M('Additive term',$_module_),    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:additiveTerm"),
                           array(_M('Methodology',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:methodology"),
                           array(_M('Masters',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contract:masters")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdContract2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array (_M('Attendance and Examination act', $_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:examinationAct"),
                           array (_M('Scolarship description', $_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:scolarshipDescription"),
                           array(_M('Possibilities and material of enroll', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:possibilitiesAndMaterialOfEnroll"),
                           array (_M('Enroll book data', $_module_),                    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:enrollBook"),
                           array (_M('Letter for a cancelled pupils', $_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:cancelledPupils"),
                           array (_M('Academic register layer', $_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:academicRegisterLayer"),
                           array (_M('Label for examination', $_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:examinationLabel"),
                           array (_M('Label for pupil folder', $_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:pupilFolder"),
                           array (_M('Letter for professors', $_module_),                'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:letterProfessor"),
                           array(_M('Possibilities and material of enroll after graduation', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:possibilitiesAndMaterialOfEnrollAfterGraduation")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdDocument->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Academic::Process
        if ( $MIOLO->checkAccess($module, ACD_ACCESS, false, false) || $MIOLO->checkAccess($module, ACD_PROCESS, false, false) )
        {
            $home_       = 'main:process';
            $acdProcess = $acdMenu->getMenu('acdProcess');
            $acdProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);
        }
/*
        //SAGU2::Academic::Process::Exploitation
        $acdExploitation2 = $acdProcess->getMenu('acdExploitation');
        $acdExploitation2->setTitle(_M('Exploitation', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:exploitation");

        $menuItem = array( 
                           array(_M('Internal',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:exploitation:internalExploitation"),
                           array(_M('External',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:exploitation:externalExploitation")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdExploitation2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Process::Cancellation
        $acdCancellation2 = $acdProcess->getMenu('acdCancellation');
        $acdCancellation2->setTitle(_M('Cancellation', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:cancellation");

        $menuItem = array( 
                           array(_M('Enroll cancellation',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:cancellation:enrollCancellation"),
                           array(_M('Insuficient condition curricular component cancellation',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:cancellation:insuficientConditionCurricularComponentCancellation")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdCancellation2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Process::Curricular Component Unblock
        $acdCurricularComponentUnblock2 = $acdProcess->getMenu('acdCurricularComponentUnblock');
        $acdCurricularComponentUnblock2->setTitle(_M('Curricular component unblock', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:curricularComponentUnblock");

        $menuItem = array( 
                           array(_M('Condition unblock',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png',          "$home_:curricularComponentUnblock:conditionUnblock"),
                           array(_M('Substitution unblock',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png',       "$home_:curricularComponentUnblock:substitutionUnblock"),
                           array(_M('Schedule shock unblock',$_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png',      "$home_:curricularComponentUnblock:scheduleShockUnblock"),
                           array(_M('Minimum turn unblock',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png',        "$home_:curricularComponentUnblock:minimumTurnUnblock"),
                           array(_M('Minimum credits unblock',$_module_),    'sagu2-16x16.png', 'sagu2_-16x16.png',     "$home_:curricularComponentUnblock:minimumCreditsUnblock"),
                           array(_M('Post enroll condition unblock',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curricularComponentUnblock:postEnrollConditionUnblock"),
                           array(_M('Course schedule shock unblock',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curricularComponentUnblock:courseScheduleShockUnblock"),
                           array(_M('Course substitution unblock',$_module_),  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curricularComponentUnblock:courseSubstitutionUnblock"),
                           array(_M('Curricular component out of curriculum unblock', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curricularComponentUnblock:curricularComponentOutOfCurriculumUnblock")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdCurricularComponentUnblock2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Process::Generation In Lot
        $acdGenerationInLot2 = $acdProcess->getMenu('acdGenerationInLot');
        $acdGenerationInLot2->setTitle(_M('Generation in lot', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:generationInLot");

        $menuItem = array( 
                           array(_M('Generate multiple learning period',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generationInLot:generateMultipleLearningPeriodCourse"),
            		       array(_M('Generate multiple academic calendar',$_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generationInLot:generateMultipleAcademicCalendarCourse"),
            		       array(_M('Generate multiple schedule learning period',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generationInLot:generateMultipleScheduleLearningPeriodCourse"),
            		       array(_M('Generate multiple message contract renewal',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generationInLot:generateMultipleMessageContractRenewalCourse"),
            		       array(_M('Generate multiple degree',$_module_),                   'sagu2-16x16.png', 'sagu2_-16x16.png',  "$home_:generationInLot:generateMultipleDegreeCourse"),
            		       array(_M('Generate multiple period enroll date',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generationInLot:generateMultiplePeriodEnrollDateCourse"),
            		       array(_M('Generate multiple exam date', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generationInLot:generateMultipleExamDateCourse")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdGenerationInLot2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Academic::Process::Contract Lock Unlock
        $acdContractLockUnlock2 = $acdProcess->getMenu('acdContractLockUnlock');
        $acdContractLockUnlock2->setTitle(_M('Contract lock/unlock', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:contractLockUnlock");

        $menuItem = array( 
                           array(_M('Contract Lock',$_module_),   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contractLockUnlock:contractLock"),
                           array(_M('Contract Unlock',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:contractLockUnlock:contractUnlock")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdContractLockUnlock2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Enroll',$_module_),                 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:enroll"),
                           array(_M('Grade typing', $_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:gradesTyping"),
                           array(_M('Curriculum conversion', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:curriculumConversion"),
                           array(_M('Card generation',$_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:cardGeneration"),
                           array(_M('Enroll addition', $_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:enrolladdition")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdProcess->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Academic::Report
        if ( $MIOLO->checkAccess($module, ACD_ACCESS, false, false) || $MIOLO->checkAccess($module, ACD_REPORT, false, false) )
        {
            $home_     = 'main:report';
            $acdReport = $acdMenu->getMenu('acdReport');
            $acdReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);
        }
/*
        $menuItem = array(
                           array(_M('Pupil listing', $_module_),                'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:pupilListing"),
                           array(_M('Exam acts and conference list', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:examsActsAndConferenceList"),
                           array (_M('Enroll confirmation', $_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:enrollconfirmation"),
                           array (_M('Learning period schedule', $_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:learningperiodschedule"),
                           array (_M('Letter professors', $_module_),            'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:letterProfessors"),
                           array (_M('Repetition listing', $_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:repetitionList")                                                  
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $acdReport->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Academic::Config
        if ( $MIOLO->checkAccess($module_, ACD_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $acdConfig = $acdMenu->getMenu('acdConfig');
            $acdConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array (_M('State contract', $_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:statesContract"),
        		               array (_M('State contract transistion',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:stateTransistion"),
                               array (_M('State enroll book', $_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:stateEnrollBook"),
                               array(_M('State contract field', $_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:stateContractField"),
                               array (_M('State enroll book rules', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:stateEnrollBookRules"),
                               array(_M('Parameters table',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );

            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $acdConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Basic
    $module_ = 'basic';
    if ( $MIOLO->checkAccess($module_, BAS_ACCESS, false, true) )
    {
        $_module_ = 'basic';
        $basMenu = $mainMenu->getMenu($_module_);
        $basMenu->setTitle(_M('Basic', $_module_), 'basic-16x16.png', 'basic_-16x16.png', $_module_, 'main');

        //SAGU2::Basic::Company
        $home_      = 'main:company';
        $basCompany = $basMenu->getMenu('basCompany');
        $basCompany->setTitle(_M('Company', $_module_), 'company-16x16.png', 'company_-16x16.png', $_module_, $home_);
/*
        //SAGU2::Basic::Company::Sector
        $basSector = $basCompany->getMenu('basSector');
        $basSector->setTitle(_M('Sector', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:sector");

        $menuItem = array( 
                           array(_M('Stamp',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:sector:stamp"),
                           array(_M('Sector boss',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:sector:sectorBoss"),
                           array(_M('Sector',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:sector:sector")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $basSector->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Concept',$_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:concept"),
                           array(_M('Unit',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:unit"),
                           array(_M('Corporate name',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:company"),
                           array(_M('Link',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:link")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $basCompany->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Basic::Geography
        $home_        = 'main:geography';
        $basGeography = $basMenu->getMenu('basGeography');
        $basGeography->setTitle(_M('Geography', $_module_), 'geography-16x16.png', 'geography_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Neighborhood',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:neighborhood"),
                           array(_M('Location',$_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:location"),
                           array(_M('City',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:city"),
                           array(_M('Country',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:country"),
                           array(_M('State',$_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:state"),
                           array(_M('City square',$_module_),  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:citySquare")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $basGeography->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Basic::Person
        $home_     = 'main:person';
        $basPerson = $basMenu->getMenu('basPerson');
        $basPerson->setTitle(_M('Person', $_module_), 'person-16x16.png', 'person_-16x16.png', $_module_, $home_);
/*
        //SAGU2::Basic::Person::Professional activity
        $basProfessionalActivity = $basPerson->getMenu('basProfessionalActivity');
        $basProfessionalActivity->setTitle(_M('Professional activity', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:professionalActivity");

        $menuItem = array( 
                           array(_M('Professional activity agent',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:professionalActivity:professionalActivityAgent"),
                           array(_M('Professional activity',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:professionalActivity:professionalActivity"),
                           array(_M('Professional activity link type',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:professionalActivity:professionalActivityLinkType"),
                           array(_M('Professional activity people',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:professionalActivity:professionalActivityPeople")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $basProfessionalActivity->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Basic::Person::Person
        $basPersonPerson = $basPerson->getMenu('basPersonPerson');
        $basPersonPerson->setTitle(_M('Person', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:person");

        $menuItem = array( 
                           array(_M('Student',$_module_),                       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:physicalPersonStudent"),
                           array(_M('Employee',$_module_),                       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:employee"),
                           array(_M('Legal person',$_module_),                 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:legalPerson"),
                           array(_M('Legal person type',$_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:legalPersonType"),
                           array(_M('Person link',$_module_),                  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:personLink"),
                           array(_M('Professor',$_module_),                   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:physicalPersonProfessor"),
                           array(_M('Physical person',$_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:physicalPerson"),
                           array(_M('Employee type',$_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:person:employeeType"),
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $basPersonPerson->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Restricted documents',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:restrictedDocuments"),
                           array(_M('Special necessity',$_module_),    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:specialNecessity"),
                           array(_M('Document type',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:documentType"),
                           array(_M('Professor center',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:professorCenter"),
                           array(_M('Marital status',$_module_),        'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:maritalStatus"),
                           array(_M('Ethnic origin',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:ethnicOrigin"),
                           array(_M('Document',$_module_),              'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:document"),
                           array(_M('Professor formation',$_module_),   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:professorFormation")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $basPerson->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Basic::Time
        $home_   = 'main:time';
        $basTime = $basMenu->getMenu('basTime');
        $basTime->setTitle(_M('Time', $_module_), 'time-16x16.png', 'time_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Week day',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:weekDay"),
                           array(_M('Turn',$_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:turn")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $basTime->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Basic::Config
        if ( $MIOLO->checkAccess($module_, BAS_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $basConfig = $basMenu->getMenu('basConfig');
            $basConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('File',$_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:file"),
                               array(_M('E-mail',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:email"),
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $basConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }
    //SAGU2::Trade
    $module_ = 'trade';
    if ( $MIOLO->checkAccess($module_, TRD_ACCESS, false, true) )
    {
        $_module_ = 'trade';
        $trdMenu = $mainMenu->getMenu($_module_);
        $trdMenu->setTitle(_M('Trade', $_module_), 'trade-16x16.png', 'trade_-16x16.png', $_module_, 'main');

        //SAGU2::Trade::Register
        $home_       = 'main:register';
        $trdRegister = $trdMenu->getMenu('trdRegister');
        $trdRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);

        //SAGU2::Trade::Document
        $home_       = 'main:document';
        $trdDocument = $trdMenu->getMenu('trdDocument');
        $trdDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);

        //SAGU2::Trade::Process
        $home_       = 'main:process';
        $trdProcess = $trdMenu->getMenu('trdProcess');
        $trdProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);

        //SAGU2::Trade::Report
        $home_     = 'main:report';
        $trdReport = $trdMenu->getMenu('trdReport');
        $trdReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);

        //SAGU2::Trade::Config
        if ( $MIOLO->checkAccess($module_, TRD_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $trdConfig = $trdMenu->getMenu('trdConfig');
            $trdConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
        }
    }
    //SAGU2::Ponto
    $module_ = 'ponto';
    if ( $MIOLO->checkAccess($module_, PNT_ACCESS, false, true) )
    {
        $_module_ = 'ponto';
        $pntMenu = $mainMenu->getMenu($_module_);
        $pntMenu->setTitle(_M('Ponto', $_module_), 'ponto-16x16.png', 'ponto_-16x16.png', $_module_, 'main');

        //SAGU2::Ponto::Register
        $home_       = 'main:register';
        $pntRegister = $pntMenu->getMenu('pntRegister');
        $pntRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);

        //SAGU2::Ponto::Document
        $home_       = 'main:document';
        $pntDocument = $pntMenu->getMenu('pntDocument');
        $pntDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);

        //SAGU2::Ponto::Process
        $home_       = 'main:process';
        $pntProcess = $pntMenu->getMenu('pntProcess');
        $pntProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);

        //SAGU2::Ponto::Report
        $home_     = 'main:report';
        $pntReport = $pntMenu->getMenu('pntReport');
        $pntReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);

        //SAGU2::Ponto::Config
        if ( $MIOLO->checkAccess($module_, PNT_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $pntConfig = $pntMenu->getMenu('pntConfig');
            $pntConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
        }
    }

    //SAGU2::Accountancy
    $module_ = 'accountancy';
    if ( $MIOLO->checkAccess($module_, ACC_ACCESS, false, true) )
    {
        $_module_ = 'accountancy';
        $accMenu = $mainMenu->getMenu($_module_);
        $accMenu->setTitle(_M('Accountancy', $_module_), 'accountancy-16x16.png', 'accountancy_-16x16.png', $_module_, 'main');

        //SAGU2::Accountancy::Register
        $home_       = 'main:register';
        $accRegister = $accMenu->getMenu('accRegister');
        $accRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Account scheme',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:accountScheme"),
                           array(_M('Cost center',$_module_),   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:costCenter"),
                           array(_M('Define a course account scheme and cost center',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:courseAccount")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $accRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Accountancy::Document
        $home_       = 'main:document';
        $accDocument = $accMenu->getMenu('accDocument');
        $accDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array (_M('Daily assistant of future exercises results', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:dailyAssistantOfFutureExercisesResults"),
                           array (_M('Daily assistant of receivable accounts', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:dailyAssistantOfReceivableAccounts"),
                           array (_M('Reason assistant of future exercises results', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:reasonAssistantOfFutureExercisesResults"),
                           array (_M('Reason assistant of receivable accounts', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:reasonAssistantOfReceivableAccounts"),
                           array (_M('Synthetic reason assistant of future exercises results', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:syntheticReasonAssistantOfFutureExercisesResults"),
                           array (_M('Synthetic reason assistant of receivable accounts', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:syntheticReasonAssistantOfReceivableAccounts")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $accDocument->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Accountancy::Process
        $home_       = 'main:process';
        $accProcess = $accMenu->getMenu('accProcess');
        $accProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);
/*
        //SAGU2::Accountancy::Process::Accounting
        $accAccounting2 = $accProcess->getMenu('accAccounting2');
        $accAccounting2->setTitle(_M('Accounting', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:accounting");

        $menuItem = array( 
                           array(_M('Format accounting import file',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:accounting:formatAccountingImportFile"),
                           array(_M('Generate entry accounting file',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:accounting:generateEntryAccountingFile"),
                           array(_M('Generate income forecast accounting file',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:accounting:generateIncomeForecastAccountingFile"),
                           array(_M('Define accounting projects',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:accounting:defineAccountingProjects"),
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $accAccounting2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Accountancy balances', $_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:accountancyBalance"),
                           array(_M('Update file IRRF', $_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:updateFileIRRF"),
                           array(_M('Generate IRRF', $_module_),            'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generateIRRF"),
                           array(_M('Import cost center', $_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:importCostCenter"),
                           array(_M('Import account scheme', $_module_),    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:importAccountScheme"),
                           array(_M('Define accounting limits', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:defineAccountingLimits")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $accProcess->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Accountancy::Report
        $home_     = 'main:report';
        $accReport = $accMenu->getMenu('accReport');
        $accReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);

        //SAGU2::Accountancy::Config
        if ( $MIOLO->checkAccess($module_, ACC_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $accConfig = $accMenu->getMenu('accConfig');
            $accConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $accConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Control copies
    $module_ = 'controlCopies';
    if ( $MIOLO->checkAccess($module_, CCP_ACCESS, false, true) )
    {
        $_module_ = 'controlCopies';
        $cppMenu = $mainMenu->getMenu($_module_);
        $cppMenu->setTitle(_M('Control copies', $_module_), 'controlCopies-16x16.png', 'controlCopies_-16x16.png', $_module_, 'main');

        //SAGU2::Control copies::Register
        $home_       = 'main:register';
        $cppRegister = $cppMenu->getMenu('cppRegister');
        $cppRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Copies', $_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:copy"),
                           array(_M('Rules',  $_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:rule"),
                           array(_M('Configuration', $_module_),    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:config"),
                           array(_M('Sector', $_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:sector"),
                           array(_M('Project',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:project"),
                           array(_M('Service',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:service"),
                           array(_M('Request',$_module_),           'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:request"),
                           array(_M('Pay Roll Discount',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:payrolldiscount")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $cppRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Control copies::Document
        $home_       = 'main:document';
        $cppDocument = $cppMenu->getMenu('cppDocument');
        $cppDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);

        //SAGU2::Control copies::Process
        $home_       = 'main:process';
        $cppProcess = $cppMenu->getMenu('cppProcess');
        $cppProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);

        //SAGU2::Control copies::Report
        $home_     = 'main:report';
        $cppReport = $cppMenu->getMenu('cppReport');
        $cppReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                            array(_M('Analytical',$_module_),         'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:analytical"),
                            array(_M('Synthetic',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:synthetic"),
                            array(_M('Solicitation',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:solicitation"),
                            array(_M('Login Solicitation',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:loginsolicitation"),
                            array(_M('Pay Roll Discount',$_module_),  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:payrolldiscount")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $cppReport->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Control copies::Config
        if ( $MIOLO->checkAccess($module_, CCP_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $cppConfig = $cppMenu->getMenu('cppConfig');
            $cppConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $cppConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Finance
    $module_ = 'finance';
    if ( $MIOLO->checkAccess($module_, FIN_ACCESS, false, true) )
    {
        $_module_ = 'finance';
        $finMenu = $mainMenu->getMenu($_module_);
        $finMenu->setTitle(_M('Finance', $_module_), 'finance-16x16.png', 'finance_-16x16.png', $_module_, 'main');

        //SAGU2::Finance::Register
        $home_       = 'main:register';
        $finRegister = $finMenu->getMenu('finRegister');
        $finRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
/*
        //SAGU2::Finance::Register::Incentive type
        $finIncentiveType2 = $finRegister->getMenu('finIncentiveType2');
        $finIncentiveType2->setTitle(_M('Incentive type', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:incentiveType");

        $menuItem = array( 
                           array(_M('Financial aid',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incentiveType:financialAid"),
                           array(_M('Loan',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incentiveType:loan"),
                           array(_M('Support',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incentiveType:support")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finIncentiveType2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Finance::Register::Invoice
        $finInvoice2 = $finRegister->getMenu('finInvoice2');
        $finInvoice2->setTitle(_M('Invoice', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:invoice");

        $menuItem = array( 
                           array(_M('Payable invoice',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:invoice:payableInvoice"),
                           array(_M('Receivable invoice',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:invoice:receivableInvoice")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finInvoice2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Bank account',       $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:bankAccount"),
                           array(_M('Bank',               $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:bank"),
                           array(_M('Bank target',        $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:bankTarget"),
                           array(_M('Collection type',    $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:collectionType"),
                           array(_M('Operation',          $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:operation"),
                           array(_M('Policy',             $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:policy"),
                           array(_M('Price',              $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:price"),
                           array(_M('Message',            $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:message"),
                           array(_M('Species',            $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:species"),
                           array(_M('Income source',      $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incomeSource"),
                           array(_M('Income forecast',    $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incomeForecast"),
                           array(_M('Voucher messages',   $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:voucherMessages"),
                           array(_M('Counter',            $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:counter"),
                           array(_M('Entry',              $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:entry"),
                           array(_M('Default operations', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:defaultOperations"),
                           array(_M('Physical target',    $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:physicalTarget"),
                           array(_M('Incentive',          $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incentive"),
			   array(_M('Operation group',    $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:operationGroup"),
			   array(_M('Student financing',  $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:studentFinancing")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Finance::Document
        $home_       = 'main:document';
        $finDocument = $finMenu->getMenu('finDocument');
        $finDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);
/*
        //SAGU2::Finance::Document::Demonstrative
        $finDemonstrative2 = $finDocument->getMenu('finDemonstrative2');
        $finDemonstrative2->setTitle(_M('Demonstrative', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:demonstrative");

        $menuItem = array( 
                           array(_M('Demonstrative for finance',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:demonstrative:demonstrativeForFinance"),
                           array(_M('Demonstrative for income tax',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:demonstrative:demonstrativeForIncomeTax")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finDemonstrative2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Finance::Document::Defaulter
        $finDefaulter2 = $finDocument->getMenu('finDefaulter2');
        $finDefaulter2->setTitle(_M('Defaulter', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:defaulter");

        $menuItem = array( 
                           array(_M('Defaulter',$_module_),              'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:defaulter:defaulter"),
                           array(_M('Defaulter legal person',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:defaulter:defaulterLegalPerson"),
                           array(_M('Defaulter enrolled',$_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:defaulter:defaulterEnrolled"),
                           array(_M('Defaulter enrolled not typed',$_module_),  'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:defaulter:defaulterEnrolledNotTyped"),
                           array(_M('Defaulter for date',$_module_),     'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:defaulter:defaulterForDate")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finDefaulter2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Payment voucher generic',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:paymentVoucherGeneric"),
                           array(_M('Payroll discount',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:payrollDiscount")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finDocument->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Finance::Process
        $home_       = 'main:process';
        $finProcess = $finMenu->getMenu('finProcess');
        $finProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);
/*
        //SAGU2::Finance::Process::Receivable invoice generation
        $finReceivableInvoice2 = $finProcess->getMenu('finReceivableInvoice2');
        $finReceivableInvoice2->setTitle(_M('Receivable invoice generation', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:receivableInvoice");

        $menuItem = array( 
                           array(_M('Receivable invoice to company',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:receivableInvoice:receivableInvoiceGenerationCompany"),
                           array(_M('Receivable invoice to pupil',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:receivableInvoice:receivableInvoiceGenerationPupil")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finReceivableInvoice2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Finance::Process::Generation in lot
        $finGenerationInLot2 = $finProcess->getMenu('finGenerationInLot2');
        $finGenerationInLot2->setTitle(_M('Generation in lot', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:generationInLot");

        $menuItem = array( 
                           array(_M('Generate multiple price',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generationInLot:generateMultiplePriceCourse")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finGenerationInLot2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Finance::Process::Remittance return
        $finRemittanceReturn2 = $finProcess->getMenu('finRemittanceReturn2');
        $finRemittanceReturn2->setTitle(_M('Remittance and return', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:remittanceReturn");

        //SAGU2::Finance::Process::Remittance return:: Remittance invoice
        $finRemittanceInvoice2 = $finRemittanceReturn2->getMenu('finRemittanceInvoice2');
        $finRemittanceInvoice2->setTitle(_M('Remittance invoice', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:remittanceReturn:remittanceInvoice");

        $menuItem = array( 
                           array(_M('BANRISUL',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:remittanceInvoice:remittanceInvoice041"),
                           array(_M('SICREDI',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:remittanceInvoice:remittanceInvoice748")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finRemittanceInvoice2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Finance::Process::Remittance return:: Return invoice
        $finReturnInvoice2 = $finRemittanceReturn2->getMenu('finReturnInvoice2');
        $finReturnInvoice2->setTitle(_M('Return invoice', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:remittanceReturn:remittanceInvoice");

        $menuItem = array( 
                           array(_M('BANRISUL',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:ReturnInvoice:remittanceInvoice041"),
                           array(_M('SICREDI',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:ReturnInvoice:remittanceInvoice748")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finReturnInvoice2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Finance::Process::Remittance return:: Remittance automatic debit
        $finRemittanceAutomaticDebit2 = $finRemittanceReturn2->getMenu('finRemittanceAutomaticDebit2');
        $finRemittanceAutomaticDebit2->setTitle(_M('Remittance automatic debit', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:remittanceReturn:remittanceAutomaticDebit");

        $menuItem = array( 
                           array(_M('BANCO DO BRASIL',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:remittanceAutomaticDebit:remittanceAutomaticDebit001"),
                           array(_M('BANRISUL',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:remittanceAutomaticDebit:remittanceAutomaticDebit041"),
                           array(_M('CAIXA ECONOMICA FEDERAL',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:remittanceAutomaticDebit:remittanceAutomaticDebit104"),
                           array(_M('SICREDI',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:remittanceAutomaticDebit:remittanceAutomaticDebit748"),
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finRemittanceAutomaticDebit2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        //SAGU2::Finance::Process::Remittance return:: Return automatic debit
        $finReturnAutomaticDebit2 = $finRemittanceReturn2->getMenu('finAutomaticDebit2');
        $finReturnAutomaticDebit2->setTitle(_M('Return automatic debit', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:remittanceReturn:automaticDebit");

        $menuItem = array( 
                           array(_M('BANRISUL',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:remittanceReturn:ReturnAutomaticDebit:remittanceAutomaticDebit041")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finReturnAutomaticDebit2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array(
                            array(_M('Income forecast generation', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incomeForecastGenerationCourse"),
                            array(_M('Long term to short term',    $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:longTermShortTerm"),
                            array(_M('Payroll discount',           $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:payrollDiscount"),
                            array(_M('Print invoice',              $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:printInvoice"),
                            array(_M('Individual income forecast generation', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:individualIncomeForecastGeneration"),
                            array(_M('Counter movement',           $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:counterMovement"),
                            array(_M('Close counter',              $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:closeCounter"),
                            array(_M('Individual invoice generation', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:individualInvoiceGeneration"),
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finProcess->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Finance::Report
        $home_     = 'main:report';
        $finReport = $finMenu->getMenu('finReport');
        $finReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);
/*
        //SAGU2::Finance::Report::Friendly agreement
        $finFriendlyAgreement2 = $finReport->getMenu('finfriendlyAgreement2');
        $finFriendlyAgreement2->setTitle(_M('Friendly agreement', $_module_), 'folder-16x16.png', 'folder_-16x16.png', $_module_, "$home_:friendlyAgreement");

        $menuItem = array( 
                           array(_M('Friendly agreement',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:friendlyAgreement:friendlyAgreement"),
                           array(_M('Paid invoices',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:friendlyAgreement:paidInvoicesWithfriendlyAgreement")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finFriendlyAgreement2->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $menuItem = array( 
                           array(_M('Income forecast', $_module_),    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:incomeForecast"),
                           array(_M('Summarized history', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:summarizedHistory"),
                           array(_M('Complete history', $_module_),   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:completeHistory")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $finReport->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Finance::Config
        if ( $MIOLO->checkAccess($module_, FIN_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $finConfig = $finMenu->getMenu('finConfig');
            $finConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $finConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Institutional
    $module_ = 'institutional';
    if ( $MIOLO->checkAccess($module_, INS_ACCESS, false, true) )
    {
        $_module_ = 'institutional';
        $insMenu = $mainMenu->getMenu($_module_);
        $insMenu->setTitle(_M('Institutional', $_module_), 'institutional-16x16.png', 'institutional_-16x16.png', $_module_, 'main');

        //SAGU2::Institutional::Register
        $home_       = 'main:register';
        $insRegister = $insMenu->getMenu('insRegister');
        $insRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Item physical resource',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:itemPhysicalResource"),
                           array(_M('Material',$_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:material"),
                           array(_M('Physical resource',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:physicalResource"),
                           array(_M('Group type',$_module_),             'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:groupType")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $insRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Institutional::Document
        $home_       = 'main:document';
        $insDocument = $insMenu->getMenu('insDocument');
        $insDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);

        //SAGU2::Institutional::Process
        $home_       = 'main:process';
        $insProcess = $insMenu->getMenu('insProcess');
        $insProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);

        //SAGU2::Institutional::Report
        $home_     = 'main:report';
        $insReport = $insMenu->getMenu('insReport');
        $insReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);

        //SAGU2::Institutional::Config
        if ( $MIOLO->checkAccess($module_, INS_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $insConfig = $insMenu->getMenu('insConfig');
            $insConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $insConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Selective Process
    $module_ = 'selectiveProcess';
    if ( $MIOLO->checkAccess($module_, SPR_ACCESS, false, true) )
    {
        $_module_ = 'selectiveProcess';
        $sprMenu = $mainMenu->getMenu($_module_);
        $sprMenu->setTitle(_M('Selective process', $_module_), 'selectiveProcess-16x16.png', 'selectiveProcess_-16x16.png', $_module_, 'main');

        //SAGU2::Selective Process::Register
        $home_       = 'main:register';
        $sprRegister = $sprMenu->getMenu('sprRegister');
        $sprRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Exam',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:exam"),
                           array(_M('Place',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:place"),
                           array(_M('Language',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:language"),
                           array(_M('Selective process type',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:selectiveProcessType"),
                           array(_M('Selective process',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:selectiveProcess"),
                           array(_M('Exam occurrence',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:examOccurrence"),
                           array(_M('Place occurrence',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:placeOccurrence"),
                           array(_M('Language occurrence',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:languageOccurrence"),
                           array(_M('Selective process occurrence',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:selectiveProcessOccurrence"),
                           array(_M('Place room',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:placeRoom"),
                           array(_M('Course occurrence',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:courseOccurrence"),
                           array(_M('Course exam balance',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:courseExamBalance"),
                           array(_M('Sattle of matter',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:sattleOfMatter"),
                           array(_M('Other sattle of matter',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:otherSattleOfMatter"),
                           array(_M('Inscription',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:inscription"),
                           array(_M('Course vacant',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:courseVacant"),
                           array(_M('Answer sheet',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:answerSheet"),
                           array(_M('Inscription setting',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:inscriptionSetting"),
                           array(_M('Note', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:note")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $sprRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Selective Process::Document
        $home_       = 'main:document';
        $sprDocument = $sprMenu->getMenu('sprDocument');
        $sprDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                            array(_M('Writting',$_module_),            'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:writting"),
                            array(_M('Objective exam',$_module_),      'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:objectiveExam"),
                            array(_M('Performance bulletin',$_module_),'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:performanceBulletin"),
                            array(_M('Inscription sheet',$_module_),   'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:inscriptionSheet"),
                            array(_M('Exam Act',$_module_),            'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:examAct"),
                            array(_M('Inscription list',$_module_),    'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:inscriptionList"),
                            array(_M('List candidate notes by exam',$_module_),'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:listCandidateNotes"),
                            array(_M('Orderly list of the total note of candidates',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:orderlyListOfNotes"),
                            array(_M('List of the total note of candidates',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:listOfNotes")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $sprDocument->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Selective Process::Process
        $home_       = 'main:process';
        $sprProcess = $sprMenu->getMenu('sprProcess');
        $sprProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                            array(_M('Upload csv file - subscription register',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:uploadCsvFileSubscriptionRegister"),
                            array(_M('Upload csv file - note',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:uploadCsvFileNote"),
                            array(_M('Reserve room',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:reserveRoom"),
                            array(_M('Generate notes table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generateNotesTable"),
                            array(_M('Classification',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:classification"),
                            array(_M('Inscription',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:inscription"),
                            array(_M('General classification',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:generalClassification")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $sprProcess->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Selective Process::Report
        $home_     = 'main:report';
        $sprReport = $sprMenu->getMenu('sprReport');
        $sprReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);
/*
         $menuItem = array( 
                             array(_M('Inscription',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:inscription"),
                             array(_M('Complementary information', $_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:complementaryInformation"),
                             array(_M('List of freshmen for course',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:freshmenListReport"),
                             array(_M('Other listings',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:otherListings"),
                             array(_M('Candidates/cities/schools',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:candidatesCitiesSchools"), 
                             array(_M('Pupils and schools performance bulletin',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:pupilsAndSchoolsPerformanceBulletin"),
                             array(_M('Selective process results',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:selectiveProcessResults"),
                             array(_M('Statistic',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:statistic")
                          );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $sprReport->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Selective Process::Config
        if ( $MIOLO->checkAccess($module_, SPR_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $sprConfig = $sprMenu->getMenu('sprConfig');
            $sprConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $sprConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Human Resources
    $module_ = 'humanResources';
    if ( $MIOLO->checkAccess($module_, HRS_ACCESS, false, true) )
    {
        $_module_ = 'humanResources';
        $hrsMenu = $mainMenu->getMenu($_module_);
        $hrsMenu->setTitle(_M('Human Resources', $_module_), 'humanResources-16x16.png', 'humanResources_-16x16.png', $_module_, 'main');

        //SAGU2::Human Resources::Register
        $home_       = 'main:register';
        $hrsRegister = $hrsMenu->getMenu('hrsRegister');
        $hrsRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Wage data',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:wageData")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $hrsRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Human Resources::Document
        $home_       = 'main:document';
        $hrsDocument = $hrsMenu->getMenu('hrsDocument');
        $hrsDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);

        //SAGU2::Human Resources::Process
        $home_       = 'main:process';
        $hrsProcess = $hrsMenu->getMenu('hrsProcess');
        $hrsProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);

        //SAGU2::Human Resources::Report
        $home_     = 'main:report';
        $hrsReport = $hrsMenu->getMenu('hrsReport');
        $hrsReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);
/*
        $menuItem = array( 
                           array(_M('Payroll',$_module_),       'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:payroll"),
                           array(_M('Employee list',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:employeeList")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $hrsReport->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Human Resources::Config
        if ( $MIOLO->checkAccess($module_, HRS_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $hrsConfig = $hrsMenu->getMenu('hrsConfig');
            $hrsConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $hrsConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Research
    $module_ = 'research';
    if ( $MIOLO->checkAccess($module_, RSH_ACCESS, false, true) )
    {
        $_module_ = 'research';
        $rshMenu = $mainMenu->getMenu($_module_);
        $rshMenu->setTitle(_M('Research', $_module_), 'research-16x16.png', 'research_-16x16.png', $_module_, 'main');

        //SAGU2::Research::Register
        $home_       = 'main:register';
        $rshRegister = $rshMenu->getMenu('rshRegister');
        $rshRegister->setTitle(_M('Register', $_module_), 'register-16x16.png', 'register_-16x16.png', $_module_, $home_);
/*
        $menuItem = array(
                            array(_M('Question',$_module_),          'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:question"),
                            array(_M('Answer',$_module_),            'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:answer"),
                            array(_M('Form',$_module_),              'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:form"),
                            array(_M('Question Category',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:questionCategory"),
                            array(_M('Who',$_module_),               'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:who")
                         );

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $rshRegister->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
        }
*/
        //SAGU2::Research::Document
        $home_       = 'main:document';
        $rshDocument = $rshMenu->getMenu('rshDocument');
        $rshDocument->setTitle(_M('Document', $_module_), 'document-16x16.png', 'document_-16x16.png', $_module_, $home_);

        //SAGU2::Research::Process
        $home_       = 'main:process';
        $rshProcess = $rshMenu->getMenu('rshProcess');
        $rshProcess->setTitle(_M('Process', $_module_), 'process-16x16.png', 'process_-16x16.png', $_module_, $home_);

        //SAGU2::Research::Report
        $home_     = 'main:report';
        $rshReport = $rshMenu->getMenu('rshReport');
        $rshReport->setTitle(_M('Report', $_module_), 'report-16x16.png', 'report_-16x16.png', $_module_, $home_);

        //SAGU2::Research::Config
        if ( $MIOLO->checkAccess($module_, RSH_ADMIN, false, true) )
        {
            $home_     = 'main:config';
            $rshConfig = $rshMenu->getMenu('rshConfig');
            $rshConfig->setTitle(_M('Configuration', $_module_), 'config-16x16.png', 'config_-16x16.png', $_module_, $home_);
/*
            $menuItem = array( 
                               array(_M('Parameters table',$_module_), 'sagu2-16x16.png', 'sagu2_-16x16.png', "$home_:parametersTable"),
                             );
            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $rshConfig->addOption($m[0], $_module_, $m[3], NULL, NULL, $m[1], $m[2]);
            }
*/
        }
    }

    //SAGU2::Services
    $session     = $MIOLO->session;
    $loginUid    = $session->getValue('loginUid');
    $loginPasswd = $session->getValue('loginPasswd');

    $_module_ = 'services';
    $acdMenu = $mainMenu->getMenu($_module_);
    $acdMenu->setTitle(_M('Services', $_module_), 'services-16x16.png', 'services_-16x16.png', $_module_, 'main');

    //SAGU2::Bookmarks
    $login            = $MIOLO->getLogin();
    $data->login      = $login->id;
    $data->isBookmark = true;
    $business         = $MIOLO->getBusiness('basic','BusAccess');
    $linksBookmark    = $business->searchAccess($data);

    if ( count($linksBookmark)>0 )
    {

        $bookmarksMenu = $theme->getMenu('bookmarks');
        $bookmarksMenu->setTitle(_M('Bookmarks', 'basic'));

        foreach ( $linksBookmark as $m )
        {
            $bookmarksMenu->addOption(_M($m[1], $m[1]) . '::' . _M($m[2], $m[1]), $m[1], $m[4], NULL, $options, 'sagu2-16x16.png', 'sagu2_-16x16.png');
        }
        $bookmarksMenu->addSeparator('-');
        $bookmarksMenu->addOption(_M('Clear', 'basic'), 'sagu2', 'main', NULL, array('event' => 'resetBookmark'), 'stop-16x16.gif', 'stop_-16x16.gif');

    }

    //MIOLO2::Admin
    $sysMenu = $theme->getMenu('system');
    $sysMenu->setTitle(_M('System', 'basic'));
    if ( $perms->checkAccess('admin_ldap', A_ADMIN, false) )
    {
        $sysMenu->addOption(_M('Administration', 'basic'), $MIOLO->mad, 'main', NULL, NULL, 'admin-16x16.png', 'admin_-16x16.png');
    }

    if ( $perms->checkAccess('basic', BAS_ACCESS, false, true) )
    {
        $saguDoc = $sysMenu->getMenu('saguDoc');
        $saguDoc->setTitle(_M('Documentation', 'sagu2'), 'documentation-16x16.png', 'documentation_-16x16.png', 'sagu2', 'main:documentation');

        $menuItem = array( 
                           array(_M('User', 'sagu2'), 'user-16x16.png', 'user_-16x16.png', "main:documentation:user"),
                           array(_M('Administrator', 'sagu2'), 'adminDoc-16x16.png', 'adminDoc_-16x16.png', "main:documentation:administrator"),
                           array(_M('Developer', 'sagu2'), 'devel-16x16.png', 'devel_-16x16.png', "main:documentation:developer")
                         );
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $saguDoc->addOption($m[0], 'sagu2', $m[3], NULL, NULL, $m[1], $m[2]);
        }

        $sysMenu->addSeparator('-');
    }

    $session     = $MIOLO->session;
    $loginUid    = $session->getValue('loginUid');
    $loginPasswd = $session->getValue('loginPasswd');

    if ( SAGU::authenticate($loginUid, $loginPasswd) )
    {
        $sysMenu->addOption(_M('Logout', 'basic'), 'services', 'logout', NULL, NULL, 'logout-16x16.png', 'logout_-16x16.png');
    }
    else
    {
        $sysMenu->addOption(_M('Logout', 'basic'), $MIOLO->mad, 'logout', NULL, NULL, 'logout-16x16.png', 'logout_-16x16.png');
    }

?>
