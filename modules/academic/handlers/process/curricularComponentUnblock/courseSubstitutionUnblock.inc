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

$home = 'main:process:curricularComponentUnblock:courseSubstitutionUnblock';
$navbar->addOption(_M('Course substitution unblock', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Course substitution unblock', $home, 'courseSubstitutionUnblock-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

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
  
$frmCourseSubstitutionUnblock = $ui->getForm( $module, 'FrmCourseSubstitutionUnblock', $data );

$content = $frmCourseSubstitutionUnblock;

$theme->clearContent($content);
$theme->insertContent($content);

?>
