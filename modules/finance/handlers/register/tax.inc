<?php

/**
 * Basic link handler.
     * Contains the menus to access tax registers
     *
     * @author Rudi Uhrig Neto [rudi@solis.coop.br]
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
     * Class created on 20/12/2005
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
    $MIOLO->checkAccess($module, FIN_ACCESS, true, true);

    $home = 'main:register:tax';
    $navbar->addOption(_M('Tax', $module), $module, $home);

    $MIOLO->getClass('basic', 'access');
access::insert('Tax', $home, 'tax-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmTaxSearch = $ui->getForm($module,'FrmTaxSearch', $data);
    $frmTaxSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmTaxSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, FIN_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, FIN_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, FIN_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, FIN_DELETE, true, true);
        break;
    }
          
    $frmTax = $ui->getForm( $module, 'FrmTax' );

    $content = $frmTax;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
