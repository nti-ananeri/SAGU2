<?php

/**
 * Finance document handler.
 * Contains the menus to access geography submenus
 *
 * @author Eduardo Beal Miglioransa [eduardo@solis.coop.br]
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
 * Class created on 16/12/2005
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
$MIOLO->checkAccess($module, FIN_ACCESS, true, true);

$function = MIOLO::_request('function');
if ( $function == 'resetStack' )
{
    SAGU::resetStack();
}

$home = 'main:document';
$navbar->addOption(_M('Document', $module), $module, $home, null, array('function'=>'resetStack'));

if ( !$MIOLO->invokeHandler($module,'document/'.$context->shiftAction()) )
{
    $ui       = $MIOLO->getUI();
    $btnClose = $MIOLO->getActionURL($module,substr($home,0,strrpos($home,':')));

    $icon        = $ui->getImage($module,'document-16x16.png');
    $pnlDocument = new MActionPanel('pnlDocument', _M('Document', $module), NULL, $btnClose, $icon);
    $pnlDocument->setIconType('small');
    $pnlDocument->setControlSize(MPANEL_DEFAULT_WIDTH,MPANEL_DEFAULT_HEIGHT);

    $menuItem = array(

                      array(_M('Defaulter', $module),                       'folder-16x16.png',                     "$home:defaulter"),
                      array(_M('Demonstrative', $module),  'folder-16x16.png',                     "$home:demonstrative"),
                      array(_M('Autenticate invoice', $module),  'autenticateInvoice-16x16.png',                     "$home:autenticateInvoice"),
                           
                      array(_M('payment voucher generic',$module),          'paymentVoucherGeneric-16x16.png',         "$home:paymentVoucherGeneric"),
                      array(_M('Payroll discount',$module),  'payrollDiscountDocument-16x16.png',      "$home:payrollDiscount"),
                      array(_M('Internal invoice',$module),  'internalInvoice-16x16.png',      "$home:internalInvoice"),
                      array(_M('Financial balance',$module),  'financialBalance-16x16.png',      "$home:financialBalance"),
                      array(_M('Agreement term',$module),  'agreementTerm-16x16.png',      "$home:agreementTerm"),
                      array(_M('Letter of recovery',$module),  'letterOfRecovery-16x16.png',      "$home:letterOfRecovery"),
                      array(_M('Debt confession', $module), 'debtConfession-16x16.png', "$home:debtConfession"),
                      array(_M('Income tax report',$module),  'letterOfRecovery-16x16.png',      "$home:incomeTax")
                      );

    $sortMenuItem = SAGU::arraySort($menuItem, 0);
    foreach ( $sortMenuItem as $m )
    {
        if ( $m[1] == 'folder-16x16.png' )
        {
            $pnlDocument->addAction($m[0], $ui->getImageTheme($MIOLO->getTheme()->id, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
        else
        {
            $pnlDocument->addAction($m[0], $ui->getImage($module, $m[1]), $module, $m[2], $m[3], $m[4]);
        }
    }

    $theme->clearContent();
    $theme->insertContent($pnlDocument);
}

?>
