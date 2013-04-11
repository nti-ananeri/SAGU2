<?php

/**
 * Basic professionalActivity handler.
 * Contains the menus to access geography submenus
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
 * Class created on 10/08/2005
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
$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:person:professionalActivity';
$navbar->addOption(_M('Professional activity', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'person/professionalActivity/'.$context->shiftAction()) )
{

    $ui        = $MIOLO->getUI();
    $btnClose  = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));
    $icon      = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlProfessionalActivity = new MActionPanel('pnlProfessionalActivity', _M('Professional activity',$module), NULL, $btnClose, $icon);
    $pnlProfessionalActivity->setIconType('small');
    $pnlProfessionalActivity->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);


    $menuItem = array(
	             array(_M('Professional activity agent',$module),     'professionalActivityAgent-16x16.png',    "$home:professionalActivityAgent"),
                     array(_M('Professional activity',$module),           'professionalActivity-16x16.png',         "$home:professionalActivity"),
                     array(_M('Professional activity link type',$module), 'professionalActivityLinkType-16x16.png', "$home:professionalActivityLinkType"),
                     array(_M('Professional activity people',$module),    'professionalActivityPeople-16x16.png',   "$home:professionalActivityPeople"),
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlProfessionalActivity->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlProfessionalActivity);
}

?>
