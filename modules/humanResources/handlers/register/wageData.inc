<?php

/**
 * Wage data  handler.
 * Contains the menus to access wageData registers
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 14/03/2006
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
$MIOLO->checkAccess($module, HRS_ACCESS, true, true);

$home = 'main:register:wageData';
$navbar->addOption(_M('Wage data', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Wage data', $home, 'wageData-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmWageDataSearch = $ui->getForm($module,'FrmWageDataSearch', $data);
    $frmWageDataSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmWageDataSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, HRS_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, HRS_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, HRS_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, HRS_DELETE, true, true);
        break;
    }
          
    $frmWageData = $ui->getForm( $module, 'FrmWageData' );

    $content = $frmWageData;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
