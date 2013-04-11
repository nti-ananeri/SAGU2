<?php

/**
 * Basic main handler.
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
 * Class created on 01/08/2005
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
if ( count($constants)>0 )
{
    foreach ( $constants as $cnt )
    {
        define($cnt[0],$cnt[1]);
    }
}

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main';
$navbar->addOption(_M('Basic', $module), $module, $home, null, array('function'=>'resetStack'));

//MIOLO2 menu
//include_once($MIOLO->GetConf('home.modules') .'/main_menu.inc');
include_once($MIOLO->GetConf('home.modules') .'/sagu2/handlers/menu.inc');

$ui = $MIOLO->getUI();

if ( ! $MIOLO->invokeHandler($module,$context->shiftAction()) )
{
    $MIOLO->checkAccess($module, BAS_ACCESS, true, true);

    $btnClose = $MIOLO->getActionURL('sagu2','main');
    $pnlBasic = new MActionPanel('pnlBasic', _M('Basic',$module), NULL, $btnClose, $ui->getImage($module,'basic-16x16.png'));

    $menuItem = array(
                       array(_M('Geography',$module), 'geography-32x32.png', "$home:geography"),
                       array(_M('Company',$module),   'company-32x32.png',   "$home:company"),
                       array(_M('Time',$module),      'time-32x32.png',      "$home:time"),
                       array(_M('Person',$module),    'person-32x32.png',    "$home:person")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlBasic->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2], null, array('function'=>'resetStack'));
    }

    $pnlBasic->addGroupAction($module, BAS_ADMIN, _M('Config', $module), $ui->getImage($module, 'config-32x32.png'), $module, "$home:config", null, array('function'=>'resetStack'));

    $theme->clearContent();
    $theme->insertContent($pnlBasic);

    /**
     * mais visitados e favoritos
     **/
    $login       = $MIOLO->getLogin();
    $data->login = $login->id;
    $business    = $MIOLO->getBusiness('basic','BusAccess');

    //bookmark
    if ( MIOLO::_request('event') == 'resetBookmark' )
    {
        $business->deleteAccess($data->login, NULL, true);
    }
    else
    {
        $data->isBookmark = true;
        $linksBookmark    = $business->searchAccess($data);
    }

    //visited
    $data->moduleAccess = $module;
    if ( MIOLO::_request('event') == 'reset' )
    {
        $business->deleteAccess($data->login, $data->moduleAccess);
    }
    else
    {
        $data->isBookmark = false;
        $links            = $business->searchAccess($data);
    }

    if ( count($linksBookmark)>0 )
    {
        $pnlBookmark = new MActionPanel('pnlLink', _M('Bookmarks','basic'), NULL, $close, $ui->GetImage($module,'bookmark-16x16.png'));
        $pnlBookmark->setIconType('small');
        $pnlBookmark->setControlSize(BOOKMARK_PANEL_WIDTH, BOOKMARK_PANEL_HEIGHT);

        $a       = new Separator();
        $pnlBookmark->AddAction(_M('Clear', 'basic'), $ui->getImage('basic', 'stop-16x16.gif'), $module, $home, null, array('event' => 'resetBookmark') );
        foreach ( $linksBookmark as $link )
        {
            $pnlBookmark->addAction(_M($link[1], $link[1]) . '::' . _M($link[2], $link[1]), $ui->getImage($link[1], $link[3]), $link[1], $link[4]);
        }
        $theme->AppendContent($a);
        $theme->AppendContent($pnlBookmark);
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
            $pnlLink->AddAction(_M($link[2], $link[1]) . '&nbsp;(' . $link[5] . ')', $ui->getImage($link[1], $link[3]), $link[1], $link[4]);
        }
        $theme->appendContent($a);
        $theme->appendContent($pnlLink);
    }
}

?>
