<?php

/**
 * Basic week day handler.
 * Contains the menus to access Vacation registers
 *
 * @author Giovani Murilo D. Correa [gmurilo@isolution.inf.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Daniel Afonso Heisler [daniel@isolution.inf.br]
 *
 * @since
 * Class created on 01/02/2009
 *
 **/

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);
$MIOLO->checkAccess($module, PNT_ACCESS, true, true);

$home = 'main:register:referencePeriod';
$navbar->addOption(_M('Reference period', $module), $module, $home);

$MIOLO->getClass('basic', 'access');
access::insert('Reference period', $home, 'referencePeriod-16x16.png');
$data->home = $home;

$function = MIOLO::_request('function');

$ui = $MIOLO->getUI();
if ( (strlen($function) == 0) || ($function == 'search') )
{
    $content = $ui->getForm( $module,'FrmReferencePeriodSearch');
}
else
{
    switch ( $function )
    {
        case 'insert':
            $MIOLO->checkAccess($module, PNT_INSERT, true, true);
            break;
        case 'update':
            if (strlen(MIOLO::_request('event')) > 0)
            {
                $MIOLO->checkAccess($module, PNT_UPDATE, true, true);
            }
            else
            {
                $MIOLO->checkAccess($module, PNT_ACCESS, true, true);
            }
            break;
        case 'delete':
            $MIOLO->checkAccess($module, PNT_DELETE, true, true);
            break;
    }
          
    $content = $ui->getForm( $module, 'FrmReferencePeriod' );
}
$theme->clearContent();
$theme->insertContent($content);

?>
