<?php

/**
 * Basic document type handler.
 * Contains the menus to access document type submenus
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
 * Class created on 05/09/2005
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
//$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

$home = 'main:person:phones';
$navbar->addOption(_M('Phones', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Phones', $home, 'phones-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmDocumentSearch = $ui->getForm($module,'FrmPhysicalPersonPhonesSearch', $data);
    $frmDocumentSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmDocumentSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, BAS_NEW_PHONE, true, true);
        break;
        case 'update':
                $MIOLO->checkAccess($module, BAS_NEW_PHONE, true, true);
        break;
        case 'delete':
            $MIOLO->checkAccess($module, BAS_DELETE, true, true);
        break;
    }
          
    $frmDocument = $ui->getForm($module, 'FrmPhysicalPersonPhones');

    $content = $frmDocument;
}

if ( $theme->page->generateMethod != 'generateAJAX' )
{
    $theme->clearContent($content);
    $theme->insertContent($content);
}

?>
