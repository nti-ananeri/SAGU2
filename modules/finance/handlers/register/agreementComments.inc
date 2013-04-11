<?php

/**
 *
 * This file handles the agreement comments register and modifications (this is a part 
 * of diverse consultation and will not be enabled to acess as a menu option, but it's
 * here because is a register/edit on your essence. ;)
 *
 * @author William Prigol Lopes [william@solis.coop.br]
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
 * Class created on 22/12/2005
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

$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

$home = 'main:register:agreementComments';
$navbar->addOption(_M('Agreement comments', $module), $module, $home);

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();

switch ( $function )
{
    case 'insert':
        $MIOLO->checkAccess($module, FIN_INSERT, true, true);
    break;
    case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
            $MIOLO->checkAccess($module, FIN_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, FIN_ACCESS, true, true);
            }
    break;
    case 'delete':
        $MIOLO->checkAccess($module, FIN_DELETE, true, true);
    break;
}

$frmAgreementComments = $ui->getForm($module, 'FrmAgreementComments');
$content              = $frmAgreementComments;
$theme->clearContent($content);
$theme->insertContent($content);
?>
