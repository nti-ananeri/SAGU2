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
 * Class created on 12/03/2009
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

$home = 'main:document:schoolYield';
$navbar->addOption(_M('School yield', $module), $module, $home, null, array('function'=>'resetStack'));

$ui = $MIOLO->getUI();

$frmBoletim = $ui->getForm($module,'FrmSchoolYield', $data);
$frmBoletim->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content       = $frmBoletim;

$theme->clearContent($content);
$theme->insertContent($content);

?>
