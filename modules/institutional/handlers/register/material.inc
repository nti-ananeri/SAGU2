<?php

/**
 * Material handler.
 * Contains the menus to access material registers
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
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
 * Class created on 23/09/2005
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
$MIOLO->checkAccess($module, INS_ACCESS, true, true);

$home = 'main:register:material';
$navbar->addOption(_M('Material', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Material', $home, 'material-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmMaterialSearch = $ui->getForm($module,'FrmMaterialSearch', $data);
    $frmMaterialSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmMaterialSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, INS_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, INS_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, INS_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, INS_DELETE, true, true);
        break;
    }
          
    $frmMaterial = $ui->getForm( $module, 'FrmMaterial' );

    $content = $frmMaterial;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
