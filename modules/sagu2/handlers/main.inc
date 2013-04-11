<?php

/**
 * Sagu2 main handler.
 * Contains the basic menus to access submenus
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
 * Class created on 09/08/2006
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

if ( ! $module )
{
    $module = 'sagu2';
}

if (($sa = $context->shiftAction()) != NULL )
{
    $a = $sa;
}
elseif ($module != 'sagu2')
{
    $a = 'main';
}

if ( $MIOLO->checkLogin() )
{
    $ui = $MIOLO->getUI();
    
    $theme->clearContent();

    $handled = $MIOLO->invokeHandler($module,$a);

    //MIOLO2 menu
    //include_once($MIOLO->getConf('home.modules') .'/main_menu.inc');
    include_once($MIOLO->getConf('home.modules') .'/sagu2/handlers/menu.inc');

    if ( ! $handled )
    {
        $sagu2Panel = new MActionPanel('pnlSagu2','SAGU 2','', $close, $ui->getImage($module,'sagu2-16x16.png'));

        $nModules = 0; // numer of modules the user have permission to access
        if ( $MIOLO->checkAccess('academic', ACD_ACCESS, false, false) ||  $MIOLO->checkAccess('academic', ACD_PROCESS, false, false) || $MIOLO->checkAccess('academic', ACD_DOCUMENT, false, false) || $MIOLO->checkAccess('academic', ACD_REPORT, false, false) || $MIOLO->checkAccess('academic', ACD_REGISTER, false, false) )
        {
            $sagu2Panel->addAction(_M('Academic','academic'), $ui->getImage('academic','academic-32x32.png'), 'academic', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('basic', BAS_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Basic','basic'), $ui->getImage('basic','basic-32x32.png'), 'basic', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('trade', TRD_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Trade','trade'), $ui->getImage('trade','trade-32x32.png'), 'trade', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('accountsPayable', PAY_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Accounts payable','accountsPayable'), $ui->getImage('accountsPayable','accountsPayable-32x32.png'), 'accountsPayable', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('accountancy', ACC_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Accountancy','accountancy'), $ui->getImage('accountancy','accountancy-32x32.png'), 'accountancy', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('controlCopies', CCP_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Control copies', 'controlCopies'), $ui->getImage('controlCopies','controlCopies-32x32.png'), 'controlCopies', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('finance', FIN_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Finance','finance'), $ui->getImage('finance','finance-32x32.png'), 'finance', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('institutional', INS_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Institutional','institutional'), $ui->getImage('institutional','institutional-32x32.png'), 'institutional', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('selectiveProcess', SPR_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Selective process','selectiveProcess'),$ui->getImage('selectiveProcess','selectiveProcess-32x32.png'),'selectiveProcess','main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('research', RSH_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Research', 'research'), $ui->getImage('research','research-32x32.png'), 'research', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }
        if ( $MIOLO->checkAccess('humanResources', HRS_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Human resources', 'humanResources'), $ui->getImage('humanResources','humanResources-32x32.png'), 'humanResources', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }

        if ( $MIOLO->checkAccess('ponto', PNT_ACCESS, false, false) )
        {
            $sagu2Panel->addAction(_M('Ponto','ponto'), $ui->getImage('ponto','ponto-32x32.png'), 'ponto', 'main', null, array('function'=>'resetStack'));
            $nModules++;
        }

        if ( $nModules == 0 ) // user has no access to any module, so take it to the services module
        {
            $MIOLO->invokeHandler('services', 'main');
        }
        else
        {
            $MIOLO->getClass('basic','sagu');

            $mioloUserName = trim($MIOLO->getLogin()->id);
            $busPerson     = $MIOLO->getBusiness('basic', 'BusPerson');

            //se for um usuário do sistema logado
            if ( strlen($mioloUserName) >  0 )
            {
                $personData = $busPerson->getPersonByMioloUserName($mioloUserName);
            }

            if ( $personData->mioloUserName )
            {
                $sagu2Panel->addAction( _M('Services', 'services'), $ui->getImage('services','services-32x32.png'), 'services', 'main', null, array('function' => 'resetStack'));
            }

            $theme->insertContent($sagu2Panel);

            /**
             * mais visitados
             **/
            $login       = $MIOLO->getLogin();
            $data->login = $login->id;

            //bookmark
            $business = $MIOLO->getBusiness('basic', 'BusAccess');
            if ( MIOLO::_request('event') == 'resetBookmark' )
            {
                $business->deleteAccess($data->login, NULL, true);
            }
            else
            {
                $data->isBookmark = true;
                $linksBookmark  = $business->searchAccess($data);
            }

            //visited
            $business = $MIOLO->getBusiness('basic', 'BusAccess');
            if ( MIOLO::_request('event') == 'reset' )
            {
                $business->deleteAccess($data->login);
            }
            else
            {
                $data->isBookmark = false;
                $links = $business->searchAccess($data);
            }

            if ( count($linksBookmark)>0 )
            {
                $pnlBookmark = new MActionPanel('pnlLink', _M('Bookmarks','basic'), NULL, $close, $ui->getImage($module,'bookmark-16x16.png'));
                $pnlBookmark->setIconType('small');
                $pnlBookmark->setControlSize(BOOKMARK_PANEL_WIDTH, BOOKMARK_PANEL_HEIGHT);

                $a       = new Separator();
                $pnlBookmark->addAction(_M('Clear', 'basic'), $ui->getImage('basic', 'stop-16x16.gif'), $module, $home, null, array('event' => 'resetBookmark') );
                foreach ( $linksBookmark as $link )
                {
                    $pnlBookmark->addAction(_M($link[1], $link[1]) . '::' . _M($link[2], $link[1]), $ui->getImage($link[1], $link[3]), $link[1], $link[4]);
                }
                $theme->appendContent($a);
                $theme->appendContent($pnlBookmark);
            }

            if ( count($links)>0 )
            {
                $pnlLink = new MActionPanel('pnlLink', _M('More visited','basic'), NULL, $close, $ui->getImage($module,'moreVisited-16x16.png'));
                $pnlLink->setIconType('small');
                $pnlLink->setControlSize(BOOKMARK_PANEL_WIDTH, BOOKMARK_PANEL_HEIGHT);

                $a       = new Separator();
                $pnlLink->addAction(_M('Clear', 'basic'), $ui->getImage('basic', 'stop-16x16.gif'), $module, $home, null, array('event' => 'reset') );
                foreach ( $links as $link )
                {
                    $pnlLink->addAction(_M($link[1], $link[1]) . '::' . _M($link[2], $link[1]) . '&nbsp;(' . $link[5] . ')', $ui->getImage($link[1], $link[3]), $link[1], $link[4]);
                }
                $theme->appendContent($a);
                $theme->appendContent($pnlLink);
            }
        }
    }
}
else
{
    $ui = $MIOLO->getUI();
    $content =  $ui->getForm('admin', $MIOLO->getConf('options.authmd5') ? 'frmLoginMD5' : 'frmLogin');
    $theme->setContent($content);
}

?>
