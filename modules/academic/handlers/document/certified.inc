<?php

/**
 * Academic document certified handler.
 * Contains the menus to access register submenus
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
 * Armando Taffarel Neto [taffarel@solis.coop.br]
 *
 * @since
 * Class created on 25/05/2006
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
$MIOLO->checkAccess($module, ACD_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:document:certified';
$navbar->addOption(_M('Certified', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'document/certified/'.$context->shiftAction()) )
{

    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImageTheme($MIOLO->getTheme()->id, 'folder-16x16.png');
    $pnlAcademic = new MActionPanel('pnlAcademic', _M('Certified', $module), null, $btnClose, $icon);
    $pnlAcademic->setIconType('small');
    $pnlAcademic->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array( 
                       array (_M('Course enroll', $module),                'certifiedDoc-16x16.png', "$home:courseEnroll"),
                       array (_M('Curricular component enroll', $module),   'certifiedDoc-16x16.png', "$home:curricularComponentEnroll"),
                       array (_M('Period curricular components', $module),  'certifiedDoc-16x16.png', "$home:periodCurricularComponent"),
                       array (_M('General curricular components', $module), 'certifiedDoc-16x16.png', "$home:generalCurricularComponent"),
                       array (_M('COREN declaration', $module),             'certifiedDoc-16x16.png', "$home:corenDeclaration"),
//                        array (_M('COREN certified', $module),               'certifiedDoc-16x16.png', "$home:corenCertified"),
                       array (_M('Professor certified', $module),           'certifiedDoc-16x16.png', "$home:professorCertified"),
                       array (_M('Semester certified', $module),            'certifiedDoc-16x16.png', "$home:semesterCertified"),
                       array (_M('Link certified', $module),                'certifiedDoc-16x16.png', "$home:linkCertified"),
                       array (_M('Journey aid', $module),                   'certifiedDoc-16x16.png', "$home:journeyAid"),
                       array (_M('Sub-Judicial', $module),                  'certifiedDoc-16x16.png', "$home:subJudicial")
                     );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
       $pnlAcademic->addAction($m[0], $ui->getImage($module,$m[1]), $module, $m[2], $m[3], $m[4]);
    }

    $theme->clearContent();
    $theme->insertContent($pnlAcademic);

}

?>
