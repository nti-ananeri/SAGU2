<?php

/**
 * Pupil assistance register handler.
 * Contains the menus to access register submenus
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 13/12/2005
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
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:register:bank';
$navbar->addOption(_M('Bank', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/bank/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));
    $icon     = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');

    $pnlRegister = new MActionPanel('pnlRegister', _M('Bank', $module), null, $btnClose, $icon);
    $pnlRegister->setIconType('small');
    $pnlRegister->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array(
                        array(_M('Bank',$module),                 'bank-16x16.png', "$home:bank"),
                        array(_M('Return',$module).'s',           'folder-16x16.png', "$home:return"),
                        array(_M('Bank account', $module),        'bankAccount-16x16.png',       "$home:bankAccount"),
                        array(_M('Bank target', $module),         'invoiceTarget-16x16.png',     "$home:bankTarget"),
                        array(_M('Branch', $module),              'branch-16x16.png',     "$home:branch"),
                        array(_M('Bank account contract', $module),              'bankAccountContract-16x16.png',     "$home:bankAccountContract")
                        );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlRegister->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlRegister->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlRegister);

}

?>
