<?php

/**
 * Exam occurrence handler.
 * Contains the menus to access exam occurrence registers
 *
 * @author Jamiel Spezia [jamiel@solis.coop.br]
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
 * Class created on 14/09/2005
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
$MIOLO->checkAccess($module, CCP_ACCESS, true, true);

$home = 'main:register:copy';
$navbar->addOption(_M('Copies', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Copies', $home, 'copy-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmCopySearch = $ui->getForm($module,'FrmCopySearch', $data);
    $frmCopySearch->setClose($MIOLO->getActionURL($module,substr($home, 0, strrpos($home, ':'))));

    $content = $frmCopySearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, CCP_INSERT, true, true);
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, CCP_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, CCP_ACCESS, true, true);
            }
        break;
        case 'delete':
            $MIOLO->checkAccess($module, CCP_DELETE, true, true);
        break;
    }
          
    $frmCopy = $ui->getForm($module, 'FrmCopy');

    $content = $frmCopy;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
