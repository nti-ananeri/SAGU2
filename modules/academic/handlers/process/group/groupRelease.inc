<?php

/**
 * Group handler.
 * Contains the menus to access group registers
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
 * Class created on 22/09/2005
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
$MIOLO->checkAccess($module, ACD_UPDATE, true, true);

$home = 'main:process:group:groupRelease';
$navbar->addOption(_M('Group releases', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Group releases', $home, 'groupReleaseProcess-16x16.png');

$ui = $MIOLO->getUI();

$frmGroupReleases = $ui->getForm( $module, 'FrmGroupRelease' );
$theme->clearContent($frmGroupReleases);
$theme->insertContent($frmGroupReleases);

?>

