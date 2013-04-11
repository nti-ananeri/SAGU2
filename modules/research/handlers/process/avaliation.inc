<?php
/**
 * Basic main handler.
 * Contains the selectiveProcess menus to access submenus
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
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

/**
 * Load global defines for the basic module
 */
$business  = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('basic');
foreach ( $constants as $cnt )
{
    define($cnt[0],$cnt[1]);
}

/**
 * Load global defines for the selectiveProcess module
 */
$business  = $MIOLO->getBusiness('basic','BusConfig');
$constants = $business->getModuleValues('selectiveProcess');
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    }
}

/*$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}
*/
$home = 'main:process:avaliation';
$navbar->addOption(_M('Avaliation', $module), $module, $home, null, array('function'=>'resetStack'));

//MIOLO2 menu
//include_once($MIOLO->GetConf('home.modules') .'/main_menu.inc');
include_once($MIOLO->GetConf('home.modules') .'/sagu2/handlers/menu.inc');
$module = 'research';
$ui = $MIOLO->getUI();

if ( !$MIOLO->invokeHandler($module,$context->shiftAction()) )
{
    $btnClose = $MIOLO->getActionURL('sagu2','main');

    $a = new Separator();
    if ( !MIOLO::_request('formId','GET') )
    {
	    $FrmResearch= $ui->getForm($module,'FrmQuestionAnswersFirst');
    }
    else
    {
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

        //Checa se a pessoa tem permissão para responder esse questionário
        $business = $MIOLO->getBusiness('research', 'BusFormSetting');
        $res      = $business->isFormAvaliable(MIOLO::_request('formId','GET'), $personData->personId);

        if ( $res == true )
        {
            $FrmResearch = $ui->getForm($module,'FrmQuestionAnswers', $personData);
        }
        else
        {
            $FrmResearch = $ui->getForm($module,'FrmDenied');
        }
    }
    $FrmResearch->setClose($btnClose);
    $theme->clearContent();
    $theme->insertContent($FrmResearch);
}
?>
