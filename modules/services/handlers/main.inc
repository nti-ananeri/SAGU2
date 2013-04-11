<?php
/**
 * Services handler.
 * Make options available according to user profile
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

$MIOLO->trace('file:' . $_SERVER['SCRIPT_NAME']);


$business  = $MIOLO->getBusiness('basic','BusConfig');
/**
 * Load global defines for the services module
 */
$constants = $business->getModuleValues('service');
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    }
}
/**
 * Load global defines for the basic module
 */
$constants = $business->getModuleValues('basic');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}

/**
 * Load global defines for the academic module
 */
$constants = $business->getModuleValues('academic');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}

/**
 * Load global defines for the finance module
 */
$constants = $business->getModuleValues('finance');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}

$home   = 'main';

$MIOLO->getClass('basic', 'access');
$MIOLO->uses('classes/sagu.class','basic');

//MIOLO2 menu
include_once($MIOLO->GetConf('home.modules') .'/sagu2/handlers/menu.inc');

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

$navbar->addOption(_M('Services from', 'services') . ' <b><u><i>' . $personData->name . '</i></u></b>', 'services', $home, null, array('function' => 'resetStack'));

if ( is_null($personData) && strlen($mioloUserName) >  0 )
{
    $MIOLO->error(_M('Couldn\'t get person data.', 'services'));
}
elseif ( strlen($personData->personId) == 0 )
{
}
elseif ( ! $MIOLO->invokeHandler('services', $context->shiftAction()) )
{
    $btnClose = $MIOLO->getActionURL('sagu2', 'main');
    $pnlServices = new MActionPanel('pnlServices', _M('Services','services'), NULL, $btnClose, $ui->getImage('services', 'services-16x16.png'));
    $pnlServices->setControlSize('120px', '85px');

    unset($menuItem);
    if ( $busPerson->isPersonProfessor($personData->personId) ) // is professor
    {
        $menuItem[] = array(_M('Professor services', 'services'), 'professor-48x48.png', 'services', "$home:professor");
        $services[] = 'professor';
    }
    if ( $busPerson->isPersonStudent($personData->personId) ) // is pupil
    {
        $menuItem[] = array(_M('Pupil services', 'services'), 'pupil-48x48.png', 'services', "$home:pupil");
        $services[] = 'pupil';
    }
    if ( $busPerson->isPersonEmployee($personData->personId) ) // is employee
    {
        $menuItem[] = array(_M('Employee services', 'services'), 'employee-48x48.png', 'services', "$home:employee");
        $services[] = 'employee';
    }
    if ( $busPerson->isPersonLegal($personData->personId) ) // is legal
    {
        $menuItem[] = array(_M('Legal person services', 'services'), 'legalPerson-48x48.png', 'services', "$home:legalPerson");
        $services[] = 'legalPerson';
    }

    // if user has the right to access only one service, access it directly
    if ( count($services) == 1 )
    {
        $MIOLO->invokeHandler('services', $services[0]);
    }
    elseif ( count($services) == 0 )
    {
        $MIOLO->error(_M('You are not authorized to access this content.', 'services'));
    }
    else
    {
        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $pnlServices->addAction($m[0], $ui->getImage($m[2], $m[1]), $m[2], $m[3]);
        }

        if ( $mioloUserName )
        {
            $pnlServices->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-48x48.png'), $MIOLO->mad, "logout");
        }
        else
        {
            $pnlServices->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-48x48.png'), 'services', 'logout');
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
        $theme->appendContent($pnlServices);

        //Imprime a quantidade de mensagens não lidas
        $fil->toPersonId = $personData->personId;
        $fil->isMarked   = DB_TRUE;
        $busMessage      = $MIOLO->getBusiness('basic', 'BusMessage');
        $messages        = $busMessage->searchMessage($fil);

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
