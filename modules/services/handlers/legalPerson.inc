<?php
/**
 * LegalPerson services handler.
 * Used to access the legalPerson services
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

$home = 'main:legalPerson';
$navbar->addOption(_M('Legal person services', 'services'), 'services', $home, null, array('function' => 'resetStack'));

$busPerson = $MIOLO->getBusiness('basic', 'BusPerson');
$personData = $busPerson->getPersonByMioloUserName(trim($MIOLO->getLogin()->id));

if ( ! $busPerson->isPersonLegal($personData->personId) )
{
    $MIOLO->error(_M('You must be a legal person to access this content.', 'services'));
}
elseif ( ! $MIOLO->invokeHandler('services', 'legalPerson/' . $context->shiftAction()) )
{
    $btnClose = $MIOLO->getActionURL('sagu2', 'main');
    $mioloUserName = trim($MIOLO->getLogin()->id);

    $busPerson = $MIOLO->getBusiness('basic', 'BusPerson');
    $personData = $busPerson->getPersonByMioloUserName($mioloUserName);

    if ( is_null($personData) )
    {
        $MIOLO->error(_M('Couldn\'t get person data.', 'services'));
    }
    else
    {
        $pnlLegalPerson = new MActionPanel('pnlLegalPerson', _M('Legal person','services'), NULL, $btnClose, $MIOLO->getUI()->getImage('services', 'legalPerson-16x16.png'));
        $pnlLegalPerson->setControlSize('100px', '70px');

        unset($menuItem);
/*
        $menuItem[] = array(_M('Personal data', 'services'),         'personalData-32x32.png',         'services', "$home:personalData");
        $menuItem[] = array(_M('Evaluation definition', 'services'), 'evaluationDefinition-32x32.png', 'services', "$home:evaluationDefinition");
        $menuItem[] = array(_M('Printed material', 'services'),      'printedMaterial-32x32.png',      'services', "$home:printedMaterial");
        $menuItem[] = array(_M('External links', 'services'),        'externalLinks-32x32.png',        'services', "$home:externalLinks");
        $menuItem[] = array(_M('Schedule', 'services'),              'schedule-32x32.png',             'services', "$home:schedule");
        $menuItem[] = array(_M('Curricular components', 'services'), 'curricularComponents-32x32.png', 'services', "$home:curricularComponents");
*/
        $menuItem[] = array(_M('Change password', 'services'),  'changePassword-32x32.png',  'services', "$home:changePassword");

        $sortMenuItem = SAGU::arraySort($menuItem, 0);
        foreach ( $sortMenuItem as $m )
        {
            $pnlLegalPerson->addAction($m[0], $MIOLO->getUI()->getImage($m[2], $m[1]), $m[2], $m[3]);
        }

        if ( $mioloUserName )
        {
            $pnlLegalPerson->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), $MIOLO->mad, "logout");
        }
        else
        {
            $pnlLegalPerson->addAction(_M('Logout', 'services'), $ui->getImage('services', 'logout-32x32.png'), 'services', 'logout');
        }

        $theme->appendContent($pnlLegalPerson);

        //Imprime a quantidade de mensagens não lidas
        $fil->toPersonId   = $personData->personId;
        $fil->isMarked     = DB_TRUE;
        $fil->toPersonType = 'L';
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
