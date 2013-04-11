<?php

/**
 * Basic center handler.
 * Contains the menus to access center registers
 *
 * @author William Prigol Lopes [william@solis.coop.br]
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
 * Class created on 08/12/2005
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
if ( !$MIOLO->checkAccess($module, ACD_REPORT, false, true ) )
{
    $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
}

$home = 'main:report:missingDocumentsReport';
$navbar->addOption(ucfirst(_M('Documentos pendentes', $module)), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Missing documents report', $home, 'missingDocumentsReport-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frm = $ui->getForm($module,'FrmMissingDocumentsReport',$data);
$frm->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content = $frm;

$theme->clearContent($content);
$theme->insertContent($content);

?>
