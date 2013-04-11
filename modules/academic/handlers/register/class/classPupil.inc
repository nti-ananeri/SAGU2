<?php

/**
 * Basic professorCurricularComponent handler.
 * Contains the menus to access professorCurricularComponent registers
 *
 * @author Bruno Madeiro da Silva [bmsilva@uncisal.edu.br]
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
 * Class created on 19/12/2006
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
if ( !$MIOLO->checkAccess($module, ACD_CLASS, false, true ) )
{
    $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
}

$home = 'main:register:class:classPupil';
$navbar->addOption(_M('Class pupil', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Class pupil', $home, 'classPupil-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmClassPupilSearch = $ui->getForm($module,'FrmClassPupilSearch', $data);
    $frmClassPupilSearch->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));

    $content = $frmClassPupilSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, ACD_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, ACD_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, ACD_DELETE, true, true);
        break;
    }

    $frmClassPupil = $ui->getForm( $module, 'FrmClassPupil' );

    $content = $frmClassPupil;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
