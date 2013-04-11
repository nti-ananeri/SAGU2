<?php
/**
 * Selective process handler.
 * Contains the menus to access exam registers
 *
 * @author Hélio H. R. Guimarães [helio@solis.coop.br]
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
 * Class created on 12/06/2006
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

$home = 'main:document:inscriptionSheet';
$navbar->addOption(_M('Inscription sheet', $module), $module, $home);
if($MIOLO->checkAccess($module, SPR_ACCESS, false, false))
{
	$MIOLO->getClass('basic', 'access');
	access::insert('Inscription sheet', $home, 'inscriptionSheet-16x16.png');
}
$data->home = $home;

$function = MIOLO::_request('function');
$ui       = $MIOLO->getUI();

switch($function)
{
	case 'insert':
		$MIOLO->checkAccess($module, SPR_INSERT, true, true);
		break;
}

$frmInscriptionSheet = $ui->getForm( $module, 'FrmInscriptionSheet', $data );

$content = $frmInscriptionSheet;

$theme->clearContent($content);
$theme->insertContent($content);

?>
