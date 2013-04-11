<?php
/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author Eduardo Beal Miglioransa [eduardo@solis.coop.br] edmigli
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 *
 * @since
 * Class created on 26/08/2005
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
 */
$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);

$home = 'main:document:autenticateInvoice';
$navbar->addOption(_M('Autenticate', $module).' '._M('Invoice',$module), $module, $home);

$session     = $MIOLO->session;
$loginUid    = $session->getValue('loginUid');
$loginPasswd = $session->getValue('loginPasswd');

if ( $MIOLO->checkAccess($module, FIN_ACCESS, false, true) )
{
    $MIOLO->getClass('basic', 'access');
    access::insert('Autenticate invoice', $home, 'autenticateInvoice-16x16.png');
}
elseif ( ! SAGU::authenticate($loginUid, $loginPasswd) )
{
    $MIOLO->checkAccess($module, FIN_ACCESS, true, true);
}


$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
$frmAutenticateInvoice = $ui->getForm( $module, 'FrmAutenticateInvoice', $data );

$content = $frmAutenticateInvoice;
$theme->clearContent($content);
$theme->insertContent($content);


?>
