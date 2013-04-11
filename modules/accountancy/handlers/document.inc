<?php

/**
 * Accountancy document handler.
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
 *
 * @since
 * Class created on 30/05/2006
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
$MIOLO->checkAccess($module, ACC_ACCESS, true, true);

$MIOLO->getClass('finance', 'finance');

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:document';
$navbar->addOption(_M('Document', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'document/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImage($module,'document-16x16.png');
    $pnlAccountancy = new MActionPanel('pnlAccountancy', _M('Document', $module), null, $btnClose, $icon);
    $pnlAccountancy->setIconType('small');
    $pnlAccountancy->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array (_M('Daily assistant of future exercises results', $module),            'dailyAssistantOfFutureExercisesResults-16x16.png',           "$home:dailyAssistantOfFutureExercisesResults"),
                       array (_M('Daily assistant of receivable accounts',      $module),            'dailyAssistantOfReceivableAccounts-16x16.png',               "$home:dailyAssistantOfReceivableAccounts"),
                       array (_M('Reason assistant of future exercises results', $module),           'reasonAssistantOfFutureExercisesResults-16x16.png',          "$home:reasonAssistantOfFutureExercisesResults"),
                       array (_M('Reason assistant of receivable accounts', $module),                'reasonAssistantOfReceivableAccounts-16x16.png',              "$home:reasonAssistantOfReceivableAccounts"),
                       array (_M('Synthetic reason assistant of future exercises results', $module), 'syntheticReasonAssistantOfFutureExercisesResults-16x16.png', "$home:syntheticReasonAssistantOfFutureExercisesResults"),
                       array (_M('Synthetic reason assistant of receivable accounts', $module),      'syntheticReasonAssistantOfReceivableAccounts-16x16.png',     "$home:syntheticReasonAssistantOfReceivableAccounts")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlAccountancy->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlAccountancy->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlAccountancy);

}

?>
