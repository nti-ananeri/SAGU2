<?php

/**
 * Finance register handler.
 * Contains the menus to access geography submenus
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
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
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:register';
$navbar->addOption(_M('Register', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/'.$context->shiftAction()) )
{
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImage($module,'register-16x16.png');
    $pnlRegister = new MActionPanel('pnlRegister', _M('Register', $module), NULL, $btnClose, $icon);
    $pnlRegister->setIconType('small');
    $pnlRegister->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Bank',               $module), 'folder-16x16.png',              "$home:bank"),
                       array(_M('Collection type',    $module), 'collectionType-16x16.png',    "$home:collectionType"),
                       array(_M('Operation',          $module), 'operation-16x16.png',         "$home:operation"),
                       array(_M('Policy',             $module), 'policy-16x16.png',            "$home:policy"),
                       array(_M('Price',              $module), 'price-16x16.png',             "$home:price"),
                       array(_M('Message',            $module), 'message-16x16.png',           "$home:message"),
                       array(_M('Invoice',            $module), 'folder-16x16.png',            "$home:invoice", null, array('function'=>'resetStack')),
                       array(_M('Species',            $module), 'species-16x16.png',           "$home:species"),
                       array(_M('Income source',      $module), 'incomeSource-16x16.png',      "$home:incomeSource"),
                       array(_M('Income forecast',    $module), 'incomeForecast-16x16.png',    "$home:incomeForecast"),
                       array(_M('Voucher messages',   $module), 'voucherMessages-16x16.png',   "$home:voucherMessages"),
                       array(_M('Counter',            $module), 'counter-16x16.png',           "$home:counter"),
                       array(_M('Entry',              $module), 'entry-16x16.png',             "$home:entry"),
                       array(_M('Default operations', $module), 'defaultOperations-16x16.png', "$home:defaultOperations"),
                       array(_M('Physical target',    $module), 'physicalTarget-16x16.png',    "$home:physicalTarget"),
                       array(_M('Incentive type',     $module), 'folder-16x16.png',            "$home:incentiveType", null, array('function'=>'resetStack')),
                       array(_M('Incentive',          $module), 'incentive-16x16.png',         "$home:incentive"),
                       array(_M('Operation group',    $module), 'operationGroup-16x16.png',    "$home:operationGroup"),
                       array(_M('Student financing',  $module), 'studentFinancing-16x16.png',  "$home:studentFinancing"),
                       array(_M('Check',              $module), 'check-16x16.png',  "$home:check"),
                       array(_M('Reason',             $module), 'reason-16x16.png',  "$home:reason"),
                       array(_M('Tax',             $module), 'tax-16x16.png',  "$home:tax")
                     );

    if ( MODULE_FINANCE_INSTALLED == 'YES' )
    {
        $menuItem[] = array(_M('Contract', $module), 'contract-16x16.png', "$home:contract");
    }

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
