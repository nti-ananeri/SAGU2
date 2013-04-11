<?php

/**
 * Basic scheduleLearningPeriod handler.
 * Contains the menus to access scheduleLearningPeriod registers
 *
 * @author Rafael Luís Spengler [rafael@solis.coop.br]
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
 * Class created on 26/10/2005
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
if ( !$MIOLO->checkAccess($module, ACD_ACCESS, false, false ) )
{
    if ( !$MIOLO->checkAccess($module, ACD_SCHEDULE_LEARNING_PERIOD, false, false) )
    {
        $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
    }
}

$home = 'main:register:scheduleLearningPeriod';
$navbar->addOption(_M('Schedule learning period', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Schedule learning period', $home, 'scheduleLearningPeriod-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $frmScheduleLearningPeriodSearch = $ui->getForm($module,'FrmScheduleLearningPeriodSearch', $data);
    $frmScheduleLearningPeriodSearch->setClose($MIOLO->getActionURL($module, substr($home, 0, strrpos($home, ':'))));

    $content = $frmScheduleLearningPeriodSearch;
}
else
{
    switch ( $function )
    {
        case 'insert':
            if ( !($MIOLO->checkAccess($module, ACD_INSERT, false, false) || $MIOLO->checkAccess($module, ACD_SCHEDULE_LEARNING_PERIOD, false, false) ) )
            {
                $MIOLO->checkAccess($module, ACD_INSERT, true, true);
            }
        break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                if ( !($MIOLO->checkAccess($module, ACD_UPDATE, false, false) || $MIOLO->checkAccess($module, ACD_SCHEDULE_LEARNING_PERIOD, false, false) ) )
                {
                    $MIOLO->checkAccess($module, ACD_UPDATE, true, true);
                }
            }
            else
            {
                $MIOLO->checkAccess($module, ACD_ACCESS, true, true);
            }
        break;
        case 'delete':
            if ( !($MIOLO->checkAccess($module, ACD_DELETE, false, false) || $MIOLO->checkAccess($module, ACD_SCHEDULE_LEARNING_PERIOD, false, false) ) )
            {
                $MIOLO->checkAccess($module, ACD_DELETE, true, true);
            }
        break;
    }
          
    $frmScheduleLearningPeriod = $ui->getForm( $module, 'FrmScheduleLearningPeriod' );

    $content = $frmScheduleLearningPeriod;
}

$theme->clearContent($content);
$theme->insertContent($content);

?>
