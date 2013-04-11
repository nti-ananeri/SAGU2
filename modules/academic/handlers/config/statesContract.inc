<?php

/**
 * Academic states contract handler.
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
 * Class created on 26/08/2005
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
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$home = 'main:config:statesContract';
$navbar->addOption(_M('State contract', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('State contract', $home, 'statesContract-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmStatesContractSearch = $ui->getForm($module, 'FrmStatesContractSearch', $data);
    $frmStatesContractSearch->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));

    $content = $frmStatesContractSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, ACD_INSERT, true, true);
        break;
        case 'update':
            $MIOLO->checkAccess($module, ACD_UPDATE, true, true);
        break;
        case 'delete':
            $MIOLO->checkAccess($module, ACD_DELETE, true, true);
        break;
    }
          
    $frmStatesContract = $ui->getForm( $module, 'FrmStatesContract' );

    $content = $frmStatesContract;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
