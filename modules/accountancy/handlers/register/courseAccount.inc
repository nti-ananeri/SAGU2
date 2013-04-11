<?php

/**
 * Course account handler.
 * Contains the menus to access course account registers
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 26/12/2005
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
$MIOLO->checkAccess($module, ACC_ACCESS, true, true);

$home = 'main:register:courseAccount';
$navbar->addOption(_M('Define a course account scheme and cost center', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Define a course account scheme and cost center', $home, 'courseAccount-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmCourseAccountSearch = $ui->getForm($module,'FrmCourseAccountSearch', $data);
    $frmCourseAccountSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmCourseAccountSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, ACC_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, ACC_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, ACC_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, ACC_DELETE, true, true);
        break;
    }
          
    $frmCourseAccount = $ui->getForm( $module, 'FrmCourseAccount' );

    $content = $frmCourseAccount;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
