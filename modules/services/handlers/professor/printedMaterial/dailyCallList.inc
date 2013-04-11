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
$module = 'services';
/**
* Load global defines for the basic module
*/

$filters->describeDays = true;
$class = 'RptDailyCallList';

$MIOLO->getClass($module,$class);
$report = new $class($filters);
?>

