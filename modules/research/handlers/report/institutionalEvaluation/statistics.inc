<?php
/**
 * Basic main handler.
 * Contains the selectiveProcess menus to access submenus
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
 * Load global defines for the selectiveProcess module
 */
$business  = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('research');
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    }
}

/*$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}
*/
$home = 'main:report:institutionalEvaluation:statistics';
$navbar->addOption(_M('Statistics of institutional evaluation', $module), $module, $home, null, array('function'=>'resetStack'));

//MIOLO2 menu
//include_once($MIOLO->GetConf('home.modules') .'/main_menu.inc');
include_once($MIOLO->GetConf('home.modules') .'/sagu2/handlers/menu.inc');
$module = 'research';
$ui = $MIOLO->getUI();

if (!$MIOLO->invokeHandler($module,$context->shiftAction()) )
{
    $btnClose    = $MIOLO->getActionURL('sagu2','main');
    $FrmResearch = $ui->getForm($module,'FrmStatistics',$data);
    $FrmResearch->setClose($btnClose);
    $theme->clearContent();
    $theme->insertContent($FrmResearch);
}
?>
