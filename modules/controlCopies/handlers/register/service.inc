<?php

/**
 *
 * @author Rafael Dutra  [rdutra@solis.coop.br]
 *
 * $version: $Id$
 *
 * \b Maintainers \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 * 
 * @since
 * Class created on 28/07/2006
 *
 * \b @organization \n
 * SOLIS - Cooperativa de Soluções Livres \n
 * The Sagu2 development team
 *
 * \b Copyleft \n
 * Copyleft (L) 2005 - SOLIS - Cooperativa de Soluções Livres \n
 *
 * \b License \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 * \b History \n
 * See history in CVS repository: http://sagu.solis.coop.br   
 *
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, CCP_ACCESS, true, true);

$theme->clearContent($content);

$home = 'main:register:service';
$navbar->addOption(_M('Service', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Service', $home, 'service-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

if (( $function == '') || ($function == 'search'))
{
    $frmCopiesSearch = $MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':')));
    $frmCopiesSearch = $ui->getForm($module,'FrmServiceSearch', $data);
    $content   = $frmCopiesSearch;
}
elseif (($function == 'insert') || ($function == 'update') || ($function == 'delete'))
{
    $frmCopies = $MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':')));
    $frmCopies = $ui->getForm($module,'FrmService', $data);
    $content   = $frmCopies;
}

$theme->SetContent($content);
?>
