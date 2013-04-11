<?php

/**
 *
 * @author Hélio Henrique Rodrigues Guimarães [helio@solis.coop.br]
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
 * Class created on 01/12/2006
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

$home = 'main:report:listEnrollFromCurricularComponent';
$navbar->addOption(_M('List curricular component from enrolled pupils', $module), $module, $home);

$data->home = $home;

$function = MIOLO::_request('function');
$ui       = $MIOLO->getUI();

$frmEnrollFromCurricularComponent = $ui->getForm($module,'FrmEnrollFromCurricularComponent', $data);
$frmEnrollFromCurricularComponent->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

$content = $frmEnrollFromCurricularComponent;

$theme->clearContent($content);
$theme->insertContent($content);

?>
