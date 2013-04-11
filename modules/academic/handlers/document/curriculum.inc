<?php
/**
 * Boletim document certified handler.
 * Contains the menus to access register submenus
 *
 * @author Giovani Murilo Dantas Corrêa [gmurilo@isolution.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 *
 * @since
 * Class created on 17/03/2008
 *
 * \b Organization: \n
 * iSolution - Solucoes em TI \n
 * The iSolution Team
 *
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 * \b History: \n
 * See history in CVS repository: http://sagu.solis.coop.br
 *
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$theme->insertContent($content);

foreach($_POST as $item => $value)
{
    $filters->{$item} = $value;
}   
foreach($_GET as $item => $value)
{
    $filters->{$item} = $value;
}
$class = 'RptCurriculum';
$module = 'academic';
/**
* Load global defines for the basic module
*/
$business = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues($module);
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}
$MIOLO->uses('classes/'.$class.'.class', $module);
$report = new $class($filters);
?>

