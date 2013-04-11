<?php

/**
 * Sagu2 diagrams documentation handler.
 * Contains all diagram documentations links
 *
 * @author Daniel Afonso Heisler [daniel@solis.coop.br]
 *
 * @version $Id$
 *
 * \b Maintainers: \n
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 * Alexandre Heitor Schmidt [alexsmith@solis.coop.br]
 * Daniel Afonso Heisler [daniel@solis.coop.br]
 * Eduardo Beal Miglioransa [eduardo@solis.coop.br]
 * Jamiel Spezia [jamiel@solis.coop.br]
 * William Prigol Lopes [william@solis.coop.br]
 *
 * @since
 * Class created on 20/10/2006
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
$MIOLO->checkAccess("basic", BAS_ACCESS, true, true);

$home = 'main:documentation:administrator:diagram';
$navbar->addOption(_M('Diagrams', $module), $module, $home);

$ui               = $MIOLO->getUI();
$btnClose         = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));
$icon             = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
$pnlDocumentation = new MActionPanel('pnlDocumentation', _M('Diagrams', $module), null, $btnClose, $icon);
$pnlDocumentation->setIconType('small');
//$pnlDocumentation->setControlSize(MPANEL_DEFAULT_WIDTH, MPANEL_DEFAULT_HEIGHT);
$pnlDocumentation->setControlSize('400px', MPANEL_DEFAULT_HEIGHT);

if ( $handle = opendir(DOCUMENTATION_PATH . '/diagrams/') )
{
    while ( false !== ( $file = readdir($handle) ) )
    {
        if ( strtolower(substr($file, -4)) == '.dia' )
        {
            $menuItem[] = array(str_replace('_',' ', str_replace('-',' ', substr($file, 0, strlen($file)-4))), 'dia-16x16.png', "main:documentation:administrator:downloadDiagram", null, array('file' => $file));
        }
    }
}
closedir($handle);

if ( count($menuItem) > 0 )
{
    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlDocumentation->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2], $m[3], $m[4]);
    }
}

$theme->clearContent();
$theme->insertContent($pnlDocumentation);

?>
