<?php

/**
 * Selective process register handler.
 * Contains the menus to access register submenus
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
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

$home = 'main:register';
$navbar->addOption(_M('Register', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'register/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon                = $ui->getImage($module,'register-16x16.png');
    $pnlSelectiveProcess = new MActionPanel('pnlSelectiveProcess', _M('Register', $module), null, $btnClose, $icon);
    $pnlSelectiveProcess->setIconType('small');
    $pnlSelectiveProcess->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array(_M('Exam',$module), 'exam-16x16.png', "$home:exam"),
                       array(_M('Place',$module), 'place-16x16.png', "$home:place"),
                       array(_M('Language',$module), 'language-16x16.png', "$home:language"),
                       array(_M('Selective process type',$module), 'selectiveProcessType-16x16.png', "$home:selectiveProcessType"),
                       array(_M('Selective process',$module), 'selectiveProcess2-16x16.png', "$home:selectiveProcess"),
                       array(_M('Exam occurrence',$module), 'examOccurrence-16x16.png', "$home:examOccurrence"),
                       array(_M('Place occurrence',$module), 'placeOccurrence-16x16.png', "$home:placeOccurrence"),
                       array(_M('Language occurrence',$module), 'languageOccurrence-16x16.png', "$home:languageOccurrence"),
                       array(_M('Selective process occurrence',$module), 'selectiveProcessOccurrence-16x16.png', "$home:selectiveProcessOccurrence"),
                       array(_M('Place room',$module), 'placeRoom-16x16.png', "$home:placeRoom"),
                       array(_M('Vacancy occurrence',$module), 'courseOccurrence-16x16.png', "$home:courseOccurrence"),
                       array(_M('Course exam balance',$module), 'courseExamBalance-16x16.png', "$home:courseExamBalance"),
                       array(_M('Sattle of matter',$module), 'sattleOfMatter-16x16.png', "$home:sattleOfMatter"),
                       array(_M('Other sattle of matter',$module), 'otherSattleOfMatter-16x16.png', "$home:otherSattleOfMatter"),
                       array(_M('Inscription',$module), 'inscription-16x16.png', "$home:inscription"),
                       array(_M('Vacancy',$module), 'courseVacant-16x16.png', "$home:courseVacant"),
                       array(_M('Answer sheet',$module), 'answerSheet-16x16.png', "$home:answerSheet"),
                       array(_M('Inscription setting',$module), 'inscriptionSetting-16x16.png', "$home:inscriptionSetting"),
                       array(_M('Note', $module), 'note-16x16.png', "$home:note")
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
