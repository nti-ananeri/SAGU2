<?php

/**
 * Basic legal person handler.
 * Contains the menus to access person registers
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
 * Class created on 25/08/2005
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
$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

$home = 'main:person:person:legalPerson';
$navbar->addOption(_M('Legal person', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Legal person', $home, 'legalPerson-16x16.png');
$data->home = $home;

$function   = MIOLO::_request('function');
$page       = MIOLO::_request('page');
$personData = unserialize(urldecode(stripslashes(MIOLO::_request('personData'))));

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmPersonSearch = $ui->getForm($module,'FrmLegalPersonSearch', $data);
    $frmPersonSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmPersonSearch;
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

    if ( $page == 2 )
    {
        $frmPerson = $ui->getForm( $module, 'FrmLegalPerson', $personData );
    }
    elseif ( strlen($page) == 0 || $page == 1 )
    {
        $frmPerson = $ui->getForm( $module, 'FrmPerson', $personData );
    }

    $content = $frmPerson;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
