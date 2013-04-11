<?php

/**
 * Control copy reports handler.
 *
 * @author Rafael Diutra [rdutra@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * Rafael Dutra [rdutra@solis.coop.br]
 * Rafael Luís Spengler [rafael@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 23/08/2006
 *
 * \b Organization: \n
 * SOLIS - Cooperativa de Solucoes Livres \n
 * The SAGU2 Development Team
 *
 * \b CopyLeft: \n
 * CopyLeft (L) 2006 SOLIS - Cooperativa de Solucoes Livres \n
 *
 * \b License: \n
 * Licensed under GPL (for further details read the COPYING file or http://www.gnu.org/copyleft/gpl.html )
 *
 * \b History: \n
 * See history in CVS repository: http://sagu.solis.coop.br
 *
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, CCP_ACCESS, true, true);

$home = 'main:report:payrolldiscount';
$navbar->addOption(_M('Pay Roll Discount', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Pay Roll Discount', $home, 'payrolldiscount-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

$frmPayRollDiscountReport = $ui->getForm($module,'FrmPayRollDiscountReport', $data);
$frmPayRollDiscountReport->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));
$content = $frmPayRollDiscountReport;

$theme->clearContent($content);
$theme->insertContent($content);

?>
