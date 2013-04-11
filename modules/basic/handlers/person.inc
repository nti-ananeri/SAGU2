<?php

/**
 * Basic person handler.
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
//$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:person';
$navbar->addOption(_M('Person', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'person/'.$context->shiftAction()) )
{

$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

    $ui        = $MIOLO->getUI();
    $btnClose  = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));
    $icon      = $ui->getImage($module,'person-16x16.png');
    $pnlPerson = new MActionPanel('pnlPerson', _M('Person',$module), NULL, $btnClose, $icon);
    $pnlPerson->setIconType('small');
    $pnlPerson->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);


    $menuItem = array(
                       array(_M('Document type',$module), 'documentType-16x16.png', "$home:documentType"),
                       array(_M('Document',$module), 'documentType-16x16.png', "$home:document"),
                       array(_M('Marital status',$module), 'maritalStatus-16x16.png', "$home:maritalStatus"),
                       array(_M('Special necessity',$module), 'specialNecessity-16x16.png', "$home:specialNecessity"),
                       array(_M('Professional activity',$module), 'folder-16x16.png', "$home:professionalActivity", null, array('function'=>'resetStack')),
                       array(_M('Ethnic origin', $module), 'ethnicOrigin-16x16.png', "$home:ethnicOrigin"),
                       array(_M('Person title', $module), 'personTitle-16x16.png', "$home:personTitle"),
                       array(_M('Person',$module), 'folder-16x16.png', "$home:person", null, array('function'=>'resetStack')),
                       array(_M('Religion', $module), 'religion-16x16.png', "$home:religion"),
                       array(_M('Digital password', 'services'), 'digitalpassword-16x16.png', "$home:digitalpassword"),
                       array(_M('Phones', 'basic'), 'phones-16x16.png', "$home:phones")
					   );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlPerson->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlPerson->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlPerson);
}

?>
