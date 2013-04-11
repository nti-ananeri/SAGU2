<?php

/**
 * Academic certified enroll document handler.
 * Contains the menus to access center registers
 *
 * @author Hélio H. R. Guimarães [helio@solis.coop.br] 
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
 * Class created on 09/10/2006
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

$home = 'main:document:diploma:boxLabel';
$navbar->addOption(_M('Box label', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Box label', $home, 'boxLabel-16x16.png');
$data->home = $home;

$ui = $MIOLO->getUI();

$frmBoxLabel = $ui->getForm($module,'FrmBoxLabel', $data);
$frmBoxLabel->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content     = $frmBoxLabel;

$theme->clearContent($content);
$theme->insertContent($content);

?>
