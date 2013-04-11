<?php
/**
 * Employee services handler.
 * Used to access the employee services
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 06/09/2007
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

$home = 'main:employee';
$navbar->addOption(_M('Employee services', 'services'), 'services', $home, null, array('function' => 'resetStack'));

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
    $session = $MIOLO->session;
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

if ( ! $busPerson->isPersonEmployee($personData->personId) )
{
    $MIOLO->error(_M('You must be an employee to access this content.', 'services'));
}
elseif ( ! $MIOLO->invokeHandler('services', 'employee/' . $context->shiftAction()) )
{
    $btnClose = $MIOLO->getActionURL('sagu2', 'main');
    $mioloUserName = trim($MIOLO->getLogin()->id);

    if ( is_null($personData) )
    {
        $MIOLO->error(_M('Couldn\'t get person data.', 'services'));
    }
    else
    {
        $pnlEmployee = new MActionPanel('pnlEmployee', _M('Employee','services'), NULL, $btnClose, $MIOLO->getUI()->getImage('services', 'employee-16x16.png'));
        $pnlEmployee->setControlSize('100px', '70px');
/*
        unset($menuItem);
        $menuItem[] = array(_M('Personal data', 'services'),         'personalData-32x32.png',         'services', "$home:personalData");
        $menuItem[] = array(_M('Evaluation definition', 'services'), 'evaluationDefinition-32x32.png', 'services', "$home:evaluationDefinition");
        $menuItem[] = array(_M('Printed material', 'services'),      'printedMaterial-32x32.png',      'services', "$home:printedMaterial");
        $menuItem[] = array(_M('External links', 'services'),        'externalLinks-32x32.png',        'services', "$home:externalLinks");
        $menuItem[] = array(_M('Schedule', 'services'),              'schedule-32x32.png',             'services', "$home:schedule");
        $menuItem[] = array(_M('Curricular components', 'services'), 'curricularComponents-32x32.png', 'services', "$home:curricularComponents");
*/
        $menuItem[] = array(_M('Messages', 'services'), 'message-32x32.png',          'services', "$home:message");
        $menuItem[] = array(_M('Change password', 'services'),  'changePassword-32x32.png',  'services', "$home:changePassword");

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $pnlEmployee->addAction($m[0], $MIOLO->getUI()->getImage($m[2], $m[1]), $m[2], $m[3]);
        }

        //adiciona ao painel os questionários
        if ( MODULE_RESEARCH_INSTALLED == 'YES' )
        {
            $business = $MIOLO->getBusiness('research', 'BusFormSetting');
            $forms    = $business->getPersonFormSetting($personData->personId, 'E');

            if ( count($forms)>0 )
            {
                foreach ( $forms as $form )
                {
                    $pnlEmployee->addAction('<u>' . _M('Research', 'research') . ':</u> ' . $form[1], $MIOLO->getUI()->getImage('research', 'report-32x32.png'), 'research', 'main:process:avaliation', null, array('formId' => $form[0]));
                }
            }
        }

        if ( $mioloUserName )
        {
            $pnlEmployee->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), $MIOLO->mad, "logout");
        }
        else
        {
            $pnlEmployee->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), 'services', 'logout');
        }

        $theme->appendContent($pnlEmployee);

        //Imprime a quantidade de mensagens não lidas
        $fil->toPersonId   = $personData->personId;
        $fil->isMarked     = DB_TRUE;
        $fil->toPersonType = 'E';
        $busMessage        = $MIOLO->getBusiness('basic', 'BusMessage');
        $messages          = $busMessage->searchMessage($fil);

        if ( count($messages)>0 )
        {
            $txt .= "<p align='justify'>" . _M('You have @1 message(s) marked as not readed.', 'services', count($messages));
            $theme->appendContent(new MText('txt', '<b>' . $txt . '</b>'));
        }

        $sep = new MSeparator();
        $theme->appendContent($sep);
    }
}

?>
