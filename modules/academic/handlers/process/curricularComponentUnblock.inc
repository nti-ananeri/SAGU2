<?php

/**
 * Pupil assistance process handler.
 * Contains the menus to access process submenus
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
 * Class created on 11/12/2005
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
$MIOLO->checkAccess($module, ACD_UPDATE, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process:curricularComponentUnblock';
$navbar->addOption(_M('Curricular component unblock', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/curricularComponentUnblock/' . $context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Curricular component unblock', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Condition unblock',$module),            'conditionUnblock-16x16.png',          "$home:conditionUnblock"),
                       array(_M('Substitution unblock',$module),         'substitutionUnblock-16x16.png',       "$home:substitutionUnblock"),
                       array(_M('Schedule shock unblock',$module),       'scheduleShockUnblock-16x16.png',      "$home:scheduleShockUnblock"),
                       array(_M('Minimum turn unblock',$module),         'minimumTurnUnblock-16x16.png',        "$home:minimumTurnUnblock"),
                       array(_M('Minimum credits unblock',$module),      'minimumCreditsUnblock-16x16.png',     "$home:minimumCreditsUnblock"),
                       array(_M('Post enroll condition unblock',$module),'postEnrollConditionUnblock-16x16.png',"$home:postEnrollConditionUnblock"),
                       array(_M('Course schedule shock unblock',$module),'courseScheduleShockUnblock-16x16.png',"$home:courseScheduleShockUnblock"),
                       array(_M('Course substitution unblock',$module),  'courseSubstitutionUnblock-16x16.png' ,"$home:courseSubstitutionUnblock"),
                       array(_M('Curricular component out of curriculum unblock', $module), 'curricularComponentOutOfCurriculumUnblock-16x16.png', "$home:curricularComponentOutOfCurriculumUnblock")
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
