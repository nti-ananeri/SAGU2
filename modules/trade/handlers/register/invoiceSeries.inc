<?php

/**
 * Basic invoice series handler.
 * Contains the menus to access invoice series registers
 *
 * @author Rosemberg Almeida dos Santos [rosbrg@gmail.com]
 * @version $Id$
 *
 * \b Maintainers: \n
 * Rosemberg Almeida dos Santos [rosbrg@gmail.com]
 * Daniel Afonso Heisler [daniel.heisler@gmail.com]
 *
 * @since
 * Class created on 11/11/2008
 *
 * \b Organization: \n
 * Isolution [http://www.isolution.inf.br/]
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )

 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, TRD_ACCESS, true, true);

$home = 'main:register:invoiceSeries';
$navbar->addOption(_M('Invoice series', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Invoice series', $home, 'invoiceseries-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmInvoiceSeriesSearch = $ui->getForm($module,'FrmInvoiceSeriesSearch', $data);
    $frmInvoiceSeriesSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmInvoiceSeriesSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, TRD_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, TRD_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, TRD_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, TRD_DELETE, true, true);
        break;
    }
          
    $frmInvoiceSeries = $ui->getForm( $module, 'FrmInvoiceSeries' );

    $content = $frmInvoiceSeries;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
