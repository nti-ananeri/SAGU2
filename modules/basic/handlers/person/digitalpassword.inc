<?php
/**
 * Basic register handler.
 * Contains the menus to access register submenus
 *
 * @author Giovani Murilo Dantas Corrêa  [gmurilo@isolution.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Giovani Murilo Dantas Corrêa [gmurilo@isolution.inf.br]
 * Daniel Afonso Heisler [daniel@isolution.inf.br]
 *
 * @since
 * Class created on 24/12/2007
 *
 * \b Organization: \n
 * iSolution - Soluções em TI \n
 * The iSolution Development Team
 *
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 *
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

$home = 'main:person:digitalpassword';
$navbar->addOption(_M('Digital password', 'services'), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Digital password', $home, 'digitalpassword-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmDigitalPasswordSearch = $ui->getForm($module,'FrmDigitalPasswordAssignedSearch', $data);
    $frmDigitalPasswordSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmDigitalPasswordSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, BAS_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, BAS_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, BAS_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, BAS_DELETE, true, true);
        break;
    }
          
    $frmDigitalPassword = $ui->getForm($module, 'FrmDigitalPasswordAssigned');

    $content = $frmDigitalPassword;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
