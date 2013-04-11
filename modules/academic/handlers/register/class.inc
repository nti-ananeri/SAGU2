<?php

/**
 * Academic register handler.
 * Contains the menus to access register submenus
 *
 * @author Flaudizio B. S. Filho / Bruno Madeiro
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
 * Class created on 19/12/2006
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

$home = 'main:register:class';
$navbar->addOption(_M('Class', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/class/'.$context->shiftAction()) )
{
    if ( !$MIOLO->checkAccess($module, ACD_CLASS, false, true) )
    {
        $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
    }
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Class', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array(
                array(_M('Class',$module),       'class-16x16.png',          "$home:class"),
                array(_M('Class pupil',$module),       'class-16x16.png',    "$home:classPupil"),
                //array(_M('Curricular component group',$module),      'curricularComponentGroup-16x16.png',         "$home:curricularComponentGroup"),
                //array(_M('Curricular component',$module),            'curricularComponent-16x16.png',           "$home:curricularComponent"),
                //array(_M('Professor curricular component',$module),  'professorCurricularComponent-16x16.png',  "$home:professorCurricularComponent")
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