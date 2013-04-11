<?php

/**
 * Sagu2 documentation handler.
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

$MIOLO->uses('classes/sagu.class','basic');
$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess("basic", BAS_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

/**
 * Load global defines for the basic module
 */
$business  = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('basic');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}

/**
 * Load global defines for the academic module
 */
$business  = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('sagu2');
if ( count($constants) > 0 )
{
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    }
}


$home = 'main:documentation';
$navbar->addOption(_M('Documentation', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module, 'documentation/' . $context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImage($module,'documentation-16x16.png');
    $pnlDocumentation = new MActionPanel('pnlDocumentation', _M('Documentation', $module), NULL, $btnClose, $icon);

    $pnlDocumentation->addAction(_M('User', $module), $ui->getImage($module,'user-32x32.png'), $module, "$home:user");
    $pnlDocumentation->addAction(_M('Develo- per', $module), $ui->getImage($module,'devel-32x32.png'), $module, "$home:developer");
    $pnlDocumentation->addAction(_M('Adminis- trator', $module), $ui->getImage($module,'admin-32x32.png'), $module, "$home:administrator");

    $theme->clearContent();
    $theme->insertContent($pnlDocumentation);
}

?>
