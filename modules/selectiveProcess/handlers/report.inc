<?php
/**
 * Selective reports handler.
 * Contains the menus to access reports submenus
 *
 * @author Jamiel Spezia [jamiel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * Rafael Luís Spengler [rafael@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 17/08/2005
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
$MIOLO->checkAccess($module, SPR_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:report';
$navbar->addOption(_M('Report', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'report/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon                = $ui->getImage($module,'report-16x16.png');
    $pnlSelectiveProcess = new MActionPanel('pnlSelectiveProcess', _M('Report', $module), null, $btnClose, $icon);
    $pnlSelectiveProcess->setIconType('small');
    $pnlSelectiveProcess->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                        array(_M('Inscription',$module), 'inscriptionReport-16x16.png', "$home:inscription"),
                        array(_M('Complementary information', $module), 'complementaryInformation-16x16.png', "$home:complementaryInformation"),
                        array(_M('List of freshmen for course',$module), 'freshmenListReport-16x16.png', "$home:freshmenListReport"),
                        array(_M('Other listings',$module), 'otherListings-16x16.png', "$home:otherListings"),
                        array(_M('Candidates/cities/schools',$module), 'candidatesCitiesSchools-16x16.png', "$home:candidatesCitiesSchools"), 
                        array(_M('Pupils and school\'s performance bulletin',$module), 'pupilsAndSchoolsPerformanceBulletin-16x16.png', "$home:pupilsAndSchoolsPerformanceBulletin"),
                        array(_M('Selective process results',$module), 'selectiveProcessResults-16x16.png', "$home:selectiveProcessResults"),
                        array(_M('Statistic',$module), 'statistic-16x16.png', "$home:statistic")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlSelectiveProcess->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlSelectiveProcess->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }


    $theme->clearContent();
    $theme->insertContent($pnlSelectiveProcess);
}

?>
