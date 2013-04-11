<?php

/**
 * Academic process handler.
 * Contains the menus to access process submenus
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
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
 * Class created on 29/09/2005
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

$home = 'main:process';
$navbar->addOption(_M('Process', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'process/'.$context->shiftAction()) )
{

    $MIOLO->checkAccess($module, ACD_ACCESS, true, true);

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module, substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImage($module, 'process-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Process', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Enroll',$module),                             'enroll-16x16.png',                          "$home:enrollNew"),
                       array(_M('Exploitation',$module),                       'folder-16x16.png',                          "$home:exploitation", null, array('function'=>'resetStack')),
                       array(_M('Curricular component unblock',$module),       'folder-16x16.png',                          "$home:curricularComponentUnblock", null, array('function'=>'resetStack')),
                       array(_M('Generation in lot',$module),                  'folder-16x16.png',                          "$home:generationInLot", null, array('function'=>'resetStack')),
                       array(_M('Cancellation',$module),                       'folder-16x16.png',                          "$home:cancellation", null, array('function'=>'resetStack')),
                       array(_M('Contract',$module),                           'folder-16x16.png',                          "$home:contract", null, array('function'=>'resetStack')),
                       array(_M('Grade typing', $module),                      'gradesTyping-16x16.png',                    "$home:gradesTyping"),
                       array(_M('Class enroll addition', $module),             'enrollAddition-16x16.png',                  "$home:classEnrollAddition"),
                       array(_M('Enroll addition', $module),                   'enrollAddition-16x16.png',                  "$home:enrolladdition"),
                       array(_M('Offered curricular component',$module),       'folder-16x16.png',                          "$home:group", null, array('function'=>'resetStack')),
                       array(_M('Download academic calendar',$module),         'downloadAcademicCalendar-16x16.png',        "$home:downloadAcademicCalendar", null, array('function'=>'resetStack')),
                       array(_M('Enroll services pupil update',$module),       'downloadAcademicCalendar-16x16.png',        "$home:enrollServicesPupilUpdate", null, array('function'=>'resetStack')),
                       array(_M('Annotations',$module),				           'downloadAcademicCalendar-16x16.png',        "$home:annotations", null, array('function'=>''))
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
