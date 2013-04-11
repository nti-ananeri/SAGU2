<?php

/**
 * Basic physical person professor handler.
 * Contains the menus to access country registers
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
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
 * Class created on 12/09/2005
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
$MIOLO->checkAccess($module, BAS_ACCESS, true, true);

$home = 'main:person:person:physicalPersonProfessor';
$navbar->addOption(_M('Professor', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Professor', $home, 'physicalPersonProfessor-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmPhysicalPersonProfessorSearch = $ui->getForm($module,'FrmPhysicalPersonProfessorSearch', $data);
    $frmPhysicalPersonProfessorSearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmPhysicalPersonProfessorSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, BAS_NEW_PROFESSOR, true, true);
        break;
        case 'update':
            $MIOLO->checkAccess($module, BAS_UPDATE, true, true);
        break;
        case 'delete':
            $MIOLO->checkAccess($module, BAS_DELETE, true, true);
        break;
    }
          
    $frmPhysicalPersonProfessor = $ui->getForm( $module, 'FrmPhysicalPersonProfessor' );

    $content = $frmPhysicalPersonProfessor;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
