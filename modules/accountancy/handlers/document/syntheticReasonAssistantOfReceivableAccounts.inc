<?php

/**
 * Account scheme handler.
 * Contains the menus to access synthetic reason of future exercise results
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 07/06/2006
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
$MIOLO->checkAccess($module, ACC_ACCESS, true, true);

$home = 'main:document:syntheticReasonAssistantOfReceivableAccounts';
$navbar->addOption(_M('Synthetic reason assistant of receivable accounts', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Synthetic reason assistant of receivable accounts', $home, 'syntheticReasonAssistantOfReceivableAccounts-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
$MIOLO->checkAccess($module, ACC_INSERT, true, true);
          
$frmSyntheticReasonAssistantOfReceivableAccounts = $ui->getForm( $module, 'FrmSyntheticReasonAssistantOfReceivableAccounts', $data );

$content = $frmSyntheticReasonAssistantOfReceivableAccounts;


$theme->clearContent($content);
$theme->insertContent($content);

?>
