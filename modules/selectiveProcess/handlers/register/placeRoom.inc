<?php
/**
 * Selective process place room handler.
 * Contains the menus to access placeRoom registers
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
 * Class created on 15/09/2005
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

$home = 'main:register:placeRoom';
$navbar->addOption(_M('Place room', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Place room', $home, 'placeRoom-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');
$ui       = $MIOLO->getUI();

if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmSectorSearch = $ui->getForm($module, 'FrmPlaceRoomSearch', $data);
    $frmSectorSearch->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));

    $content = $frmSectorSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, SPR_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, SPR_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, SPR_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, SPR_DELETE, true, true);
        break;
    }
          
    $frmSector = $ui->getForm( $module, 'FrmPlaceRoom' );

    $content = $frmSector;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
