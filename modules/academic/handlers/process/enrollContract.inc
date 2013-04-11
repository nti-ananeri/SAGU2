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
 * Class created on 13/10/2005
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

$home = 'main:process:enroll';

$navbar->addOption(_M('Enroll', $module), $module, $home);

//testar se a pessoa que está logada é um funcionário
if ( $MIOLO->checkAccess($module, ACD_ENROLL, false, true) )
{
    $MIOLO->getClass('basic', 'access');
    access::insert('Enroll', $home, 'enroll-16x16.png');

}

$data->home = $home;

$ui = $MIOLO->getUI();

$content = $ui->getForm($module, 'FrmEnrollContract', $data);

$theme->clearContent($content);
$theme->insertContent($content);

?>
