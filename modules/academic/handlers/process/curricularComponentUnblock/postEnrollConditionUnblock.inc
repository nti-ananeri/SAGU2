<?php

/**
 * Basic center handler.
 * Contains the menus to access center processs
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
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
$MIOLO->checkAccess($module, ACD_INSERT, true, true);

$home = 'main:process:curricularComponentUnblock:postEnrollConditionUnblock';
$navbar->addOption(_M('Post enroll condition unblock', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Post enroll condition unblock', $home, 'postEnrollConditionUnblock-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmPostEnrollConditionUnblockSearch = $ui->getForm($module,'FrmPostEnrollConditionUnblockSearch', $data);
    $frmPostEnrollConditionUnblockSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmPostEnrollConditionUnblockSearch;
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
          
    $frmPostEnrollConditionUnblock = $ui->getForm( $module, 'FrmPostEnrollConditionUnblockSearch', $data );

    $content = $frmPostEnrollConditionUnblock;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
