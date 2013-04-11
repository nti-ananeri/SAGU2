<?php
/**
 *
 * @author Giovani Murilo Dantas Corrêa [gmurilo@isolution.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@isolution.inf.br]
 *
 * @since
 * Class created on 26/03/2009
 *
 * \b Organization: \n
 * iSolution - Solucoes em TI \n
 * The iSolution Team
 *
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 *
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

foreach($_POST as $item => $value)
{
    $filters->{$item} = $value;
}   

foreach($_GET as $item => $value)
{
    $filters->{$item} = $value;
}
$class = 'RptGradesAndAbsenceRoster';
$module = 'academic';
/**
* Load global defines for the basic module
*/
$business = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('basic');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}
$constants = $business->getModuleValues($module);
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}
$MIOLO->getClass($module, $class);
$report = new $class($filters);
?>

