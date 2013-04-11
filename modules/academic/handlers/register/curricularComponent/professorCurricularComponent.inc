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
 * Class created on 18/12/2006
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
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$home = 'main:register:curricularComponent:professorCurricularComponent';
$navbar->addOption(_M('Professor curricular component', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Professor curricular component', $home, 'professorCurricularComponent-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmProfessorCurricularComponentSearch = $ui->getForm($module,'FrmProfessorCurricularComponentSearch', $data);
    $frmProfessorCurricularComponentSearch->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));

    $content = $frmProfessorCurricularComponentSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, ACD_PROFESSOR_CURRICULAR_COMPONENT, true, true);
        break;
        case 'update':
            $MIOLO->checkAccess($module, ACD_PROFESSOR_CURRICULAR_COMPONENT, true, true);
        break;
        case 'delete':
            $MIOLO->checkAccess($module, ACD_DELETE, true, true);
        break;
    }
          
    $frmProfessorCurricularComponent = $ui->getForm( $module, 'FrmProfessorCurricularComponent' );

    $content = $frmProfessorCurricularComponent;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
