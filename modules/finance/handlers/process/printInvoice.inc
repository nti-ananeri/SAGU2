<?php

/**
 * Basic payrollDiscount handler.
 * Contains the menus to access payrollDiscount registers
 *
 * @author Eduardo Beal Miglioransa [eduardo@solis.coop.br]
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
 * Class created on 12/12/2005
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

$home = 'main:process:printInvoice';
$navbar->addOption(_M('Print invoice', $module), $module, $home);

$session     = $MIOLO->session;
$loginUid    = $session->getValue('loginUid');
$loginPasswd = $session->getValue('loginPasswd');

if ( $MIOLO->checkAccess($module, FIN_ACCESS, false) )
{
    $MIOLO->getClass('basic', 'access');
    access::insert('Print invoice', $home, 'printInvoice-16x16.png');
}
elseif ( ! SAGU::authenticate($loginUid, $loginPasswd) )
{
    $MIOLO->checkAccess($module, FIN_ACCESS,false);
}


$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
switch ( $function )
{
	case 'insert':
		$MIOLO->checkAccess($module, FIN_INSERT, true, true);
		break;
	case 'update':
		$MIOLO->checkAccess($module, FIN_UPDATE, true, true);
		break;
	case 'delete':
		$MIOLO->checkAccess($module, FIN_DELETE, true, true);
		break;
}
$frmPrintInvoice = $ui->getForm( $module, 'FrmPrintInvoice', $data );
$content = $frmPrintInvoice;

$theme->clearContent($content);
$theme->insertContent($content);

?>
