<?php

/**
 * Academic enroll handler.
 * Contains the menus to access enroll process
 *
 * @author Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
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
 * Class created on 29/09/2005
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

$home = 'main:process:enroll';

$navbar->addOption(_M('Enroll', $module), $module, $home);

$MIOLO->getClass('basic', 'access');

$data->home = $home;

$ui = $MIOLO->getUI();

$mioloUserName = trim($MIOLO->getLogin()->id);
$busPerson     = $MIOLO->getBusiness('basic', 'BusPerson');

//testar se a pessoa que est� logada � um funcion�rio
if ( $MIOLO->checkAccess($module, ACD_ENROLL, false, true) )
{
    $content = $ui->getForm($module, 'FrmEnrollNew', $data);
    access::insert('Enroll', $home, 'enroll-16x16.png');
}
//abre um formul�rio para login do aluno (SERVICES)
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

if ( SAGU::authenticate($personData->personId, $personData->password) )
{
    $data->home     = $home;
    $data->personId = $personData->personId;
    $content = $ui->getForm('academic', 'FrmEnrollPerson', $data);
    $content->setClose($MIOLO->getActionURL('services',substr($home, 0, strrpos($home, ':'))));
}

$theme->clearContent($content);
$theme->insertContent($content);

?>