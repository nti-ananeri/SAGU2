<?php
/**
 * Pupil frequency handler.
 * Used to allow the professor to register the frequencies for the specified group
 *
 * @author Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 10/09/2007
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

$home = 'main:professor:supervisedTrainingNew';
$navbar->addOption(_M('Professor curricular components', 'services'), 'services', substr($home, 0, strrpos($home, ':')+1) . 'curricularComponentsNew', null, array('periodId' => MIOLO::_request('periodId')));
$navbar->addOption(_M('Set supervised training', 'academic'), 'services', $home, null, array('function' => 'resetStack'));

$ui = $MIOLO->getUI();

$mioloUserName = trim($MIOLO->getLogin()->id);
$busPerson     = $MIOLO->getBusiness('basic', 'BusPerson');

//se for um usuário do sistema logado
if ( strlen($mioloUserName) >  0 )
{
    $personData = $busPerson->getPersonByMioloUserName($mioloUserName);
}
else //caso for um aluno
{
    $session              = $MIOLO->session;
    $personData->personId = $session->getValue('loginUid');
    $personData->password = $session->getValue('loginPasswd');

    if ( ! SAGU::authenticate($personData->personId, $personData->password) )
    {
        $content = $ui->getForm('services', 'FrmLogin');
        $content->setClose($MIOLO->getActionURL('services', substr($home, 0, strrpos($home, ':'))));
        $theme->clearContent();
        $theme->insertContent($content);

    }
    else
    {
        $personData = $busPerson->getPerson($personData->personId);
    }
}

if ( SAGU::authenticate($personData->personId, $personData->password) )
{
    $ui           = $MIOLO->getUI();
    $frmFrequency = $ui->getForm('services', 'FrmSetSupervisedTrainingNew');
    $frmFrequency->setClose($MIOLO->getActionURL('services',substr($home, 0, strrpos($home, ':'))));

    if ( $theme->page->generateMethod != 'generateAJAX' )
    {
        $theme->clearContent();
        $theme->insertContent($frmFrequency);
    }
}

?>
