<?php

/**
 * Basic center handler.
 * Contains the menus to access center processs
 *
 * @author Leovan Tavares da Silva [leovan@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Leovan Tavares da Silva [leovan@solis.coop.br]
 *
 * @since
 * Class created on 03/05/2006
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

$home = 'main:process:curricularComponentUnblock:curricularComponentOutOfCurriculumUnblock';
$navbar->addOption(_M('Curricular component out of curriculum unblock', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Curricular component out of curriculum unblock', $home, 'curricularComponentOutOfCurriculumUnblock-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmConditionUnblockSearch = $ui->getForm($module,'FrmCurricularComponentOutOfCurriculumUnblockSearch', $data);
    $frmConditionUnblockSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmConditionUnblockSearch;
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
          
    $frmConditionUnblock = $ui->getForm( $module, 'FrmCurricularComponentOutOfCurriculumUnblock', $data );

    $content = $frmConditionUnblock;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
