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
 * Class created on 21/03/2009
 *
 * \b Organization: \n
 * iSolution - Solucoes em TI \n
 * The iSolution Team
 *
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 **/
$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:process:generationInLot:printScolarshipDescriptionInLot';
$navbar->addOption(_M('Print scolarship description in lot', $module), $module, $home, null, array('function'=>'resetStack'));

$ui = $MIOLO->getUI();

$frmScolarshipDescriptionInLot = $ui->getForm($module,'FrmScolarshipDescriptionInLot', $data);
$frmScolarshipDescriptionInLot->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content       = $frmScolarshipDescriptionInLot;

$theme->clearContent($content);
$theme->insertContent($content);

?>
