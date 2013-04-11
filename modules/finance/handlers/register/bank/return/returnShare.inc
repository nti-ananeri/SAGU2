<?php

/**
 * Finance bank return share segment handler.
 *
 * @author Giovani Murilo Dantas Correa [gmurilo@gmail.com]
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
 * Class created on 09/10/2007
 *
 * \b Organization: \n
 * iSolution - Soluções de Internet \n
 * The iSolution TEAM
 *
 * \b CopyLeft: \n
 * CopyLeft (L) 2007 iSolution - Soluções de Internet \n
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

$home = 'main:register:bank:return:return';
$navbar->addOption('Configurações', $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('BankReturnShareSegment', $home, 'bank-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmBankSearch = $ui->getForm($module,'FrmBankReturnShareSegmentSearch', $data);
    $frmBankSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmBankSearch;
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
          
    $frmBank = $ui->getForm( $module, 'FrmBankReturnShareSegment' );

    $content = $frmBank;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
