<?php
/**
 * Pupil services handler.
 * Used to access the pupil services
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

$home = 'main:pupil';
$navbar->addOption(_M('Pupil services', 'services'), 'services', $home, null, array('function' => 'resetStack'));

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

if ( ! $busPerson->isPersonStudent($personData->personId) )
{
    $MIOLO->error(_M('You must be a pupil to access this content.', 'services'));
}
elseif ( ! $MIOLO->invokeHandler('services', 'pupil/' . $context->shiftAction()) )
{
    $btnClose = $MIOLO->getActionURL('sagu2', 'main');
    $mioloUserName = trim($MIOLO->getLogin()->id);

    if ( is_null($personData) )
    {
        $MIOLO->error(_M('Couldn\'t get person data.', 'services'));
    }
    else
    {
        $pnlPupil = new MActionPanel('pnlPupil', _M('Pupil','services'), NULL, $btnClose, $MIOLO->getUI()->getImage('services', 'pupil-16x16.png'));
        $pnlPupil->setControlSize('100px', '70px');

        unset($menuItem);
        
        //verifica se o aluno respondeu o questionário
        if ( MODULE_RESEARCH_INSTALLED == 'YES' )
        {
            $business = $MIOLO->getBusiness('research', 'BusFormSetting');
            $forms    = $business->getPersonFormSetting($personData->personId, 'S');

            if ( count($forms)>0 )
            {
                foreach ( $forms as $form )
                {
                    $setting = $business->getFormSettingByFormId($form[0]);
                    if ( $setting->isInstitutionalEvaluation == DB_TRUE )
                    {
                        $key = true;
                    }
                }
            }
        }
        $busEnroll  = $MIOLO->getBusiness('services', 'BusEnroll');
        $activeContractsEnrollDate = $busEnroll->getPeriodEnrollDate($personData);
         
        if ( $key != true )
        {
            //$menuItem[] = array(_M('Personal data', 'services'),          'personalData-32x32.png',          'services', "$home:personalData");
            //$menuItem[] = array(_M('Process consultation', 'services'),   'processConsultation-32x32.png',   'services', "$home:processConsultation");
            //$menuItem[] = array(_M('Missing documents', 'services'),      'missingDocuments-32x32.png',      'services', "$home:missingDocuments");
            $menuItem[] = array(_M('Frequencies', 'services'),  'frequency-32x32.png',  'services', "$home:frequency");
            //$menuItem[] = array(_M('Academic consultation', 'services'),  'academicConsultation-32x32.png',  'services', "$home:academicConsultation");
            $menuItem[] = array(_M('Notes', 'academic'),  'degree-32x32.png',  'services', "$home:degree");
            $menuItem[] = array(_M('Financial consultation', 'services'), 'financialConsultation-32x32.png', 'services', "$home:financialConsultation");
            if( count($activeContractsEnrollDate) > 0 )
            {
                $menuItem[] = array(_M('Re-enroll', 'academic'),                 'enrollServices-32x32.png',                'services', "$home:enroll");
            }
            //$menuItem[] = array(_M('Enroll adjust', 'services'),          'enrollAdjust-32x32.png',          'services', "$home:enrollAdjust");
            $menuItem[] = array(_M('Messages', 'services'),          'message-32x32.png',          'services', "$home:message");
            $menuItem[] = array(_M('Change password', 'services'),  'changePassword-32x32.png',  'services', "$home:changePassword");

            $sortMenuItem = SAGU::arraySort($menuItem, 0);
            foreach ( $sortMenuItem as $m )
            {
                $pnlPupil->addAction($m[0], $MIOLO->getUI()->getImage($m[2], $m[1]), $m[2], $m[3]);
            } 
        }

        //adiciona ao painel os questionários
        if ( MODULE_RESEARCH_INSTALLED == 'YES' )
        {
            $business = $MIOLO->getBusiness('research', 'BusFormSetting');
            $forms    = $business->getPersonFormSetting($personData->personId, 'S');

            if ( count($forms)>0 )
            {
                foreach ( $forms as $form )
                {
                    $pnlPupil->addAction('<u>' . _M('Research', 'research') . ':</u> ' . $form[1], $MIOLO->getUI()->getImage('research', 'report-32x32.png'), 'research', 'main:process:avaliation', null, array('formId' => $form[0]));
                }
            }
        }

        if ( $mioloUserName )
        {
            $pnlPupil->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), $MIOLO->mad, "logout");
        }
        else
        {
            $pnlPupil->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), 'services', 'logout');
        }

/*
        if ( MODULE_FINANCE_INSTALLED == 'YES' )
        {
            $busReceivableInvoice = $MIOLO->getBusiness('finance', 'BusReceivableInvoice');
            $balance              = $busReceivableInvoice->calculateTotalPersonOpenValueByDate($personData->personId, date(MASK_DATE_PHP));

            if ( (float)$balance > (float)0 )
            {
                $sex = $busPerson->getPhysicalPersonSex($personData->personId);
                if ( $sex == 'M' )
                {
                    $txt = "<p>Caro aluno $personData->name.</p>";
                }
                elseif ( $sex == 'F' )
                {
                    $txt = "<p>Cara aluna $personData->name.</p>";
                }
                else
                {
                    $txt = "<p>Caro(a) aluno(a) $personData->name.</p>";
                }
                $txt .= "<p align='justify'>Durante o seu login foi identificada inconsistência referente à confirmação de pagamento de mensalidade.</p>";
                $txt .= "<p align='justify'>Por gentileza compareça a tesouraria com o(s) comprovante(s) para regularização da(s) pendência(s) localizada(s).</p>";
                $theme->appendContent(new MText('txt', '<b>' . $txt . '</b>'));
            }
        }
*/
        $theme->appendContent($pnlPupil);

        //Imprime a quantidade de mensagens não lidas
        $fil->toPersonId   = $personData->personId;
        $fil->isMarked     = DB_TRUE;
        $fil->toPersonType = 'S';
        $busMessage        = $MIOLO->getBusiness('basic', 'BusMessage');
        $messages          = $busMessage->searchMessage($fil);

        if ( count($messages)>0 )
        {
            $txt .= "<p align='justify'>" . _M('You have @1 message(s) marked as not readed.', 'services', count($messages));
            $theme->appendContent(new MText('txt', '<b>' . $txt . '</b>'));
        }

        $sep = new MSeparator();
        $theme->appendContent($sep);
        
        //mensagens dos funcionários para os alunos
        $businessCompany   = $MIOLO->getBusiness('basic', 'BusCompany');
        $company           = $businessCompany->getCompany(DEFAULT_COMPANY_CONF);
        $fil->toPersonId   = $company->personId;
        $fil->fromPersonId = $company->personId;
        $fil->toPersonType = 'S';
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
