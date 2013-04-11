<?php
/**
*
* @author Giovani Murilo Dantas Correa [gmurilo@isolution.inf.br]
*
* $version: $Id$
*
* \b Maintainers \n
* Daniel Afonso Heisler [daniel@isolution.inf.br]
*
* @since
* Class created on 24/09/2008
*
* \b Organization: \n
* iSolution - Soluções de Internet \n
* The iSolution TEAM
*
* \b CopyLeft: \n
* CopyLeft (L) 2007 iSolution - Soluções de Internet \n
*
* \b License \n
* Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
*
* \b History \n
* See history in CVS repository: http://isolution.inf.br   
*
**/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);
$home = 'main:document:letterOfRecovery';
$navbar->addOption(_M('Letter of recovery', $module), $module, $home);
$ui = $MIOLO->getUI();

$frmLetterOfRecovery = $ui->getForm($module, 'FrmLetterOfRecovery', $data);
$content = $frmLetterOfRecovery;

$theme->clearContent($content);
$theme->insertContent($content);
?>
