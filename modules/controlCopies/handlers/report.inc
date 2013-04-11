<?php
/**
 * Control copies reports handler.
 * Contains the menus to access reports submenus
 *
 * @author Jamiel Spezia [jamiel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * Rafael Luís Spengler [rafael@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 17/08/2005
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
$MIOLO->checkAccess($module, CCP_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:report';
$navbar->addOption(_M('Report', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'report/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon                = $ui->getImage($module,'report-16x16.png');
    $pnlControlCopies = new MActionPanel('pnlControlCopies', _M('Report', $module), null, $btnClose, $icon);
    $pnlControlCopies->setIconType('small');
    $pnlControlCopies->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                        array(_M('Analytical',$module), 'analytical-16x16.png', "$home:analytical"),
                        array(_M('Synthetic',$module),  'synthetic-16x16.png', "$home:synthetic"),
                        array(_M('Solicitation',$module), 'solicitation-16x16.png', "$home:solicitation"),
                        array(_M('Login Solicitation',$module),'loginsolicitation-16x16.png', "$home:loginsolicitation"),
                        array(_M('Pay Roll Discount',$module),'payrolldiscount-16x16.png', "$home:payrolldiscount")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlControlCopies->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlControlCopies->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }


    $theme->clearContent();
    $theme->insertContent($pnlControlCopies);
}

?>
