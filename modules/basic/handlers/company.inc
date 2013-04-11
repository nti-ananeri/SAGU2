<?php

/**
 * Basic config handler.
 * Contains the menus to access company submenus
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Mauricio de Castro [mcastro@solis.coop.br]
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
$MIOLO->checkAccess($module, BAS_ACCESS, false, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:company'; 
$navbar->addOption(_M('Company', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module, 'company/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon       = $ui->getImage($module, 'company-16x16.png');
    $pnlCompany = new MActionPanel('pnlCompany', _M('Company',$module), null, $btnClose, $icon);
    $pnlCompany->setIconType('small');
    $pnlCompany->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Corporate name',$module),       'company-16x16.png', "$home:company"),
                       array(_M('Unit',$module),                 'unit-16x16.png',    "$home:unit"),
                       array(_M('Generate people link',$module), 'generatePeopleLink-16x16.png',    "$home:generatePeopleLink"),
                       array(_M('Sector',$module),               'folder-16x16.png',  "$home:sector", null, array('function'=>'resetStack')),
                       array(_M('Group link',$module),           'link-16x16.png',    "$home:link"),
                       array(_M('Concept',$module),              'concept-16x16.png', "$home:concept"),
                       array(_M('Product',$module),              'folder-16x16.png',  "$home:product", null, array('function'=>'resetStack'))
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlCompany->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlCompany->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->insertContent($pnlCompany);
}

?>
