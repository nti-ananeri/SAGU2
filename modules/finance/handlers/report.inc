<?php

/**
 * Finance report handler.
 * Contains the menus to access geography submenus
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 16/12/2005
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
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

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

    $icon        = $ui->getImage($module,'report-16x16.png');
    $pnlReport = new MActionPanel('pnlReport', _M('Report', $module), NULL, $btnClose, $icon);
    $pnlReport->setIconType('small');
    $pnlReport->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
//                       array(_M('Income forecast', $module), 'incomeForecastReport-16x16.png', "$home:incomeForecast"),
//            array(_M('Friendly agreement', $module), 'folder-16x16.png', "$home:friendlyAgreement"),
//                       array(_M('Summarized history', $module), 'summarizedHistory-16x16.png', "$home:summarizedHistory"),
                       array(_M('Complete history', $module), 'completeHistory-16x16.png', "$home:completeHistory"),
//                       array(_M('Enroll tax', $module), 'enrollTaxReport-16x16.png', "$home:enrollTaxReport"),
                       array(_M('Close counter', $module), 'closeCounter-16x16.png', "$home:closeCounter"),
                       array(_M('Monthly income', $module), 'monthlyIncome-16x16.png', "$home:monthlyIncome"),
//                       array(_M('Monthly income per course', $module), 'monthlyIncome-16x16.png', "$home:monthlyIncomePerCourse"),
                       array(_M('Income estimates', $module), 'incomeEstimates-16x16.png', "$home:incomeEstimates"),
//                       array(_M('Monthly defaulter', $module), 'monthlyDefaulter-16x16.png', "$home:monthlyDefaulter"),
//                       array(_M('Monthly income per cost center', $module), 'monthlyIncomePerCostCenter-16x16.png', "$home:monthlyIncomePerCostCenter"),
                       array(_M('Return relation', $module), 'returnRelation-16x16.png', "$home:returnRelation"), 
                       array(_M('Commission report', $module), 'commissionReport-16x16.png', "$home:commissionReport"),
                       array(_M('Agreements report', $module), 'agreementsReport-16x16.png', "$home:agreementsReport"),
                       array(_M('Incentive', $module), 'incentiveReport-16x16.png', "$home:incentiveReport")
                       );
    $menuItem[] = array(_M('Income report', $module), 'incomeReport-16x16.png', "$home:incomeReport");
    $menuItem[] = array(_M('Income report', $module).' (Excel)', 'excel-16x16.png', "$home:incomeReportExcel");
    $menuItem[] = array(_M('Relatorio de Receita Customizavel', $module), 'incomeReport-16x16.png', "$home:incomeReport2");
    $menuItem[] = array(_M('Inadimplentes por Intervalo', $module), 'incomeReport-16x16.png', "$home:defaulterReportForDate");
    $acAdmin = $MIOLO->checkAccess($module, FIN_ADMIN, false, false);
    if ( $acAdmin )
    {
        $menuItem[] = array(_M('Customizable entry report', $module), 'monthlyDefaulter-16x16.png', "$home:customizableEntryReport");
    }
    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlReport->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlReport->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }
    $theme->clearContent();
    $theme->insertContent($pnlReport);
}

?>
