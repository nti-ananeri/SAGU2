<?php
/**
 * Professor services handler.
 * Used to access the professor services
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
 * Class created on 05/09/2007
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

$home = 'main:professor';
$navbar->addOption(_M('Professor services', 'services'), 'services', $home, null, array('function' => 'resetStack'));

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

if ( ! $busPerson->isPersonProfessor($personData->personId) )
{
    $MIOLO->error(_M('You must be a professor to access this content.', 'services'));
}
elseif ( ! $MIOLO->invokeHandler('services', 'professor/' . $context->shiftAction()) )
{
        //Pega browser 
        if ( strstr($_SERVER['HTTP_USER_AGENT'], "Opera 6") ) 
        {
            $user_browser = "Opera 6"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Opera 7") ) 
        {
            $user_browser = "Opera 7"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Opera") ) 
        {
            $user_browser = "Opera";  
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Konqueror") ) 
        {
            $user_browser = "Konqueror"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Netscape/7") ) 
        {
            $user_browser = "Netscape 7"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Netscape6") ) 
        {
            $user_browser = "Netscape 6";  
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Netscape4") ) 
        {
            $user_browser = "Netscape 4"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Netscape3")) 
        {
            $user_browser = "Netscape 3"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Lynx")) 
        {
            $user_browser = "Lynx";  
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Links")) 
        {
            $user_browser = "Links"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "OmniWeb")) 
        {
            $user_browser = "OmniWeb"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "WebTV")) 
        {
            $user_browser = "WebTV";  
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Avant Browser")) 
        {
            $user_browser = "Avant Browser"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "MyIE2")) 
        {
            $user_browser = "MyIE2"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Galeon")) 
        {
            $user_browser = "Galeon";  
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "MSIE 8")) 
        {
            $user_browser = "Internet Explorer 8"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "MSIE 6")) 
        {
            $user_browser = "Internet Explorer 6"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "MSIE 5")) 
        {
            $user_browser = "Internet Explorer 5"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "MSIE 4")) 
        {
            $user_browser = "Internet Explorer 4"; 
        } 
        elseif ( strstr($_SERVER['HTTP_USER_AGENT'], "Gecko")) 
        {
            $user_browser = "Mozilla Firefox"; 
        } 
        else 
        {
            $user_browser = "Outro"; 
        } 

    $btnClose      = $MIOLO->getActionURL('sagu2', 'main');
    $mioloUserName = trim($MIOLO->getLogin()->id);

    if ( is_null($personData) )
    {
        $MIOLO->error(_M('Couldn\'t get person data.', 'services'));
    }
    else
    {
        $msg1   = _M('Dear user', 'services').', '; 
        $msg2   = _M('We recommend using @1 for browsing this site.', 'services', '<b><i><a href="http://pt-br.www.mozilla.com/pt-BR/firefox/" target="_blank">Mozilla Firefox</a></i></b>'); 
        $msg3   = _M('For more information, call @1', 'services', $legalPerson->phone);
        $msg4   = _M('You are using @1 browser.', 'services', '<b>' . $user_browser . '</b>');

        $pnlProfessor = new MActionPanel('pnlProfessor', _M('Professor','services'), NULL, $btnClose, $MIOLO->getUI()->getImage('services', 'professor-16x16.png'));
        $pnlProfessor->setControlSize('100px', '70px');

        unset($menuItem);
        //$menuItem[] = array(_M('Personal data', 'services'),         'personalData-32x32.png',         'services', "$home:personalData");
        //$menuItem[] = array(_M('Evaluation definition', 'services'), 'evaluationDefinition-32x32.png', 'services', "$home:evaluationDefinition");
        //$menuItem[] = array(_M('External links', 'services'),        'externalLinks-32x32.png',        'services', "$home:externalLinks");
        //$menuItem[] = array(_M('Schedule', 'services'),              'schedule-32x32.png',             'services', "$home:schedule");
        $menuItem[] = array(_M('Printed material', 'services'),      'printedMaterial-32x32.png',      'services', "$home:printedMaterial");
        $menuItem[] = array(_M('Curricular components', 'services'), 'curricularComponents-32x32.png', 'services', "$home:curricularComponentsNew");
        $menuItem[] = array(_M('Messages', 'services'),          'message-32x32.png',          'services', "$home:message");
        $menuItem[] = array(_M('Change password', 'services'),   'changePassword-32x32.png',  'services', "$home:changePassword");
        $menuItem[] = array(_M('Manual', 'services'),   'manual-32x32.png',  'services', "$home:downloadDocument");

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        if ( $user_browser == "Mozilla Firefox" )
        {
            foreach ( $sortMenuItem as $m )
            {
                $pnlProfessor->addAction($m[0], $MIOLO->getUI()->getImage($m[2], $m[1]), $m[2], $m[3]);
            }


        //adiciona ao painel os questionários
            if ( MODULE_RESEARCH_INSTALLED == 'YES' )
            {
                $business = $MIOLO->getBusiness('research', 'BusFormSetting');
                $forms    = $business->getPersonFormSetting($personData->personId, 'P');

                if ( count($forms)>0 )
                {
                    foreach ( $forms as $form )
                    {
                        $pnlProfessor->addAction('<u>' . _M('Research', 'research') . ':</u> ' . $form[1], $MIOLO->getUI()->getImage('research', 'report-32x32.png'), 'research', 'main:process:avaliation', null, array('formId' => $form[0]));
                    }
                }
            }
        }
        else
        {
            $pnlProfessor->addAction(_M('Change password', 'services'), $MIOLO->getUi()->getImage('services','changePassword-32x32.png'), 'services', "$home:changePassword");
            $pnlProfessor->addAction(_M('Manual', 'services'),    $MIOLO->getUi()->getImage('services','manual-32x32.png'),  'services', "$home:downloadDocument");

        }
        if ( $mioloUserName )
        {
            $pnlProfessor->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), $MIOLO->mad, "logout");
        }
        else
        {
            $pnlProfessor->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), 'services', 'logout');
        }

        $theme->appendContent($pnlProfessor);


        //Imprime a quantidade de mensagens não lidas
        $fil->toPersonId   = $personData->personId;
        $fil->isMarked     = DB_TRUE;
        $fil->toPersonType = 'P';
        $busMessage        = $MIOLO->getBusiness('basic', 'BusMessage');
        $messages          = $busMessage->searchMessage($fil);

        if ( count($messages)>0 )
        {
            $txt .= "<p align='justify'>" . _M('You have @1 message(s) marked as not readed.', 'services', count($messages));
            $theme->appendContent(new MText('txt', '<b>' . $txt . '</b>'));
        }

        $sep = new MSeparator();
        $theme->appendContent($sep);

        //mensagens dos funcionários para os professores
        $businessCompany   = $MIOLO->getBusiness('basic', 'BusCompany');
        $company           = $businessCompany->getCompany(DEFAULT_COMPANY_CONF);
        $fil->toPersonId   = $company->personId;
        $fil->fromPersonId = $company->personId;
        $fil->toPersonType = 'P';
        $fil->date = date(MASK_DATE_PHP);

        $business = $MIOLO->getBusiness('basic', 'BusMessage');
        $data     = $business->searchMessage($fil);
        
        if ( count($data) > 0 )
        {
            foreach ( $data as $row )
            {
                $messageId = $row[0];
                $title     = $row[5];
                $message[] = new Mtext('txt' . $messageId, $row[6]);
                $sep       = new MBaseGroup('info' . $messageId, $title, $message);
                $theme->appendContent($sep);
                unset($message);
            }
        }
    }
}

?>
