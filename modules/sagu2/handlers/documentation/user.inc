<?php

/**
 * Sagu2 users documentation handler.
 * Contains the menus to access documentation submenu
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 19/10/2006
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
$MIOLO->checkAccess("basic", BAS_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:documentation:user';
$navbar->addOption(_M('User', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module, 'documentation/user/' . $context->shiftAction()) )
{

    $ui               = $MIOLO->getUI();
    $btnClose         = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));
    $icon             = $ui->getImage($module, 'user-16x16.png');
    $pnlDocumentation = new MActionPanel('pnlDocumentation', _M('User', $module), null, $btnClose, $icon);
    $pnlDocumentation->setIconType('small');
    $pnlDocumentation->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
//                       array (_M('Step by step', $module), 'stepByStep-16x16.png', "$home:stepByStep"),
//                       array (_M('Screens description', $module), 'screensDescription-16x16.png', "$home:screensDescription")
                        array( 'Manual', 'stepByStep-16x16.png', "$home:manual"),
                        array( 'Processos', 'folder-16x16.png', "$home:process")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlDocumentation->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlDocumentation->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlDocumentation);

}

?>
