<?php
/**
 * Selective process handler.
 * Contains the menus to access exam registers
 *
 * @author Jamiel Spezia [jamiel@solis.coop.br]
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
 * Class created on 22/08/2005
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
$MIOLO->checkAccess($module, SPR_ACCESS, true, true);

$home = 'main:process:uploadCsvFileSubscriptionRegister';
$navbar->addOption(_M('Upload csv file - subscription register', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Upload csv file - subscription register', $home, 'uploadCsvFileSubscriptionRegister-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');
$ui       = $MIOLO->getUI();


$MIOLO->checkAccess($module, SPR_INSERT, true, true);

$frmSector = $ui->getForm( $module, 'FrmUploadCsvFileSubscriptionRegister', $data );

$content = $frmSector;

$theme->clearContent($content);
$theme->insertContent($content);

?>
