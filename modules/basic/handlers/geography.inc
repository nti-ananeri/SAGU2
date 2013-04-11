<?php

/**
 * Basic geography handler.
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

$home = 'main:geography';
$navbar->addOption(_M('Geography', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'geography/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon         = $ui->getImage($module,'geography-16x16.png');
    $pnlGeography = new MActionPanel('pnlGeography', _M('Geography',$module), NULL, $btnClose, $icon);
    $pnlGeography->setIconType('small');
    $pnlGeography->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( array(_M('Country',$module), 'country-16x16.png', "$home:country"),
                       array(_M('State',$module), 'state-16x16.png', "$home:state"),
                       array(_M('City',$module), 'city-16x16.png', "$home:city"),
                       array(_M('City square',$module), 'citySquare-16x16.png', "$home:citySquare"),
                       array(_M('Neighborhood',$module), 'neighborhood-16x16.png', "$home:neighborhood"),
                       array(_M('Location',$module), 'location-16x16.png', "$home:location")
                        );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlGeography->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlGeography->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->insertContent($pnlGeography);

}

?>
