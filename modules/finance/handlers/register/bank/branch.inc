<?php

/**
 * Finance branch handler.
 * Contains the menus to access country registers
 *
 * @author Rosemberg Almeida dos Santos [rosbrg@gmail.com]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 *
 * @since
 * Class created on 30/10/2007
 *
 * \b Organization: \n
 * UNISULBAHIA FACULDADES INTEGRADAS  \n
 * The SAGU2 Development Team
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

$home = 'main:register:bank:branch';
$navbar->addOption(_M('Branch', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Branch', $home, 'branch-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmBranchSearch = $ui->getForm($module,'FrmBranchSearch', $data);
    $frmBranchSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmBranchSearch;
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
          
    $frmBranch = $ui->getForm( $module, 'FrmBranch' );

    $content = $frmBranch;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
