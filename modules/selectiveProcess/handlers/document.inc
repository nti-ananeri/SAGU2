<?php
/**
 * Selective process register handler.
 * Contains the menus to access register submenus
 *
 * @author Hélio H. R. Guimarães [helio@solis.coop.br]
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
 * Class created on 29/06/2006
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
$action = $MIOLO->getCurrentAction();
switch($action)
{
	case 'main:document:inscriptionSheet':
		if(!MIOLO::_request('inscriptionIdS'))		$MIOLO->checkAccess($module, SPR_ACCESS, true, true);
 		$MIOLO->checkAccess($module, SPR_ACCESS, false, false);
		break;
	default:
		$MIOLO->checkAccess($module, SPR_ACCESS, true, true);
		break;
}

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:document';
$navbar->addOption(_M('Document', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'document/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon                = $ui->getImage($module,'document-16x16.png');
    $pnlSelectiveProcess = new MActionPanel('pnlSelectiveProcess', _M('Document', $module), null, $btnClose, $icon);
    $pnlSelectiveProcess->setIconType('small');
    $pnlSelectiveProcess->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                        array(_M('Writting',$module),            'writting-16x16.png',             "$home:writting"),
                        array(_M('Objective exam',$module),      'objectiveExam-16x16.png',        "$home:objectiveExam"),
                        array(_M('Performance bulletin',$module),'performanceBulletin-16x16.png',  "$home:performanceBulletin"),
                        array(_M('Inscription sheet',$module),   'inscriptionSheet-16x16.png',     "$home:inscriptionSheet"),
                        array(_M('Exam Act',$module),            'examAct-16x16.png',              "$home:examAct"),
                        array(_M('Inscription list',$module),    'inscriptionList-16x16.png',      "$home:inscriptionList"),
                        array(_M('List candidate notes by exam',$module),'listCandidateNotes-16x16.png',   "$home:listCandidateNotes"),
                        array(_M('List of the total note of candidates',$module), 'orderlyListOfNotes-16x16.png', "$home:orderlyListOfNotes"),
                        //array(_M('List of the total note of candidates',$module), 'listOfNotes-16x16.png', "$home:listOfNotes")
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
