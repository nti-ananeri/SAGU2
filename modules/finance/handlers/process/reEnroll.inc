<?php

/**
 * Academic enroll handler.
 * Contains the menus to access enroll process
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
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
 * Class created on 29/09/2005
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
$MIOLO->checkAccess($module, ACD_ENROLL_UPDATE, true, true);

$home = 'main:process:reEnroll';

$navbar->addOption(_M('Re-enroll', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
$function = MIOLO::_request('function');
//access::insert('Enroll', $home, 'enrollPersonData-16x16.png');
$data->home = $home;
$ui = $MIOLO->getUI();
$pageNumber = MIOLO::_request('pageNumber');
if ( $pageNumber == null )
{
    $form = 'FrmReEnroll';
}
else if ( $pageNumber == 1 )
{
    $form = 'FrmEnrollServicesUpdatePerson';
}
else if ( $pageNumber == 2 )
{
    $form = 'FrmGenerateInvoices';
}
$content = $ui->getForm($module, $form, $data);

$theme->clearContent($content);
$theme->insertContent($content);
?>
