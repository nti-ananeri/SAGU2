<?php

/**
 * Academic register handler.
 * Contains the menus to access register submenus
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
 * Class created on 31/01/2006
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
if ( !$MIOLO->checkAccess($module, ACD_ACCESS, false, false ) )
{
    if ( !$MIOLO->checkAccess($module, ACD_ACADEMIC_CALENDAR, false, false) && !$MIOLO->checkAccess($module, ACD_ACADEMIC_CALENDAR_ADJUSTMENT, false, false) )
    {
        $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
    }
}

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:register:academicCalendar';
$navbar->addOption(_M('Academic calendar', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/academicCalendar/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Academic calendar', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    if ( $MIOLO->checkAccess($module, ACD_ACCESS, false, false) ) 
    {
        $menuItem = array( 
	                    array(_M('Academic calendar adjustment',$module), 'academicCalendarAdjustments-16x16.png', "$home:academicCalendarAdjustments"),
                        array(_M('Academic calendar',$module),            'academicCalendar-16x16.png',            "$home:academicCalendar")
                     );

    }
    else
    {
        if ( $MIOLO->checkAccess($module, ACD_ACADEMIC_CALENDAR, false, false) )
        {
            $menuItem[] = array(_M('Academic calendar',$module),            'academicCalendar-16x16.png',            "$home:academicCalendar");
        }
        if ( $MIOLO->checkAccess($module, ACD_ACADEMIC_CALENDAR_ADJUSTMENT, false, false) )
        {
            $menuItem[] = array(_M('Academic calendar adjustment',$module), 'academicCalendarAdjustments-16x16.png', "$home:academicCalendarAdjustments");
        }
    }


    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlAcademic->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlAcademic);

}

?>
