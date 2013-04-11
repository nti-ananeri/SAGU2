<?php

/**
 * Selective process inscription handler.
 * Contains the menus to access inscription options
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
 * Class created on 05/07/2006
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

$home = 'main:process:inscription';
$navbar->addOption(_M('Inscription', $module), $module, $home);

if ( $MIOLO->checkAccess($module, SPR_ACCESS, false, true) )
{
    $MIOLO->getClass('basic', 'access');
    access::insert('Inscription', $home, 'inscription-16x16.png');
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


$home = 'main:process:inscription';

$navbar->clear();

$function        = MIOLO::_request('function');
$page            = MIOLO::_request('page');

$inscriptionData = unserialize(urldecode(stripslashes(MIOLO::_request('inscriptionData'))));

$ui = $MIOLO->getUI();

if ( $page == 12 )
{
    $frmInscription = $ui->getForm( $module, 'FrmReprintTermReserve', $inscriptionData );
}

if ( $page == 11 )
{
    $frmInscription = $ui->getForm( $module, 'FrmReprintInscriptionVoucher', $inscriptionData );
}
if ( $page == 10 )
{
    $frmInscription = $ui->getForm( $module, 'FrmReprintInvoice', $inscriptionData );
}
if ( $page == 9 )
{
    $frmInscription = $ui->getForm( $module, 'FrmOkInscription', $inscriptionData );
}
if ( $page == 8 ) //Ãção essa que salva a inscrição!!
{
    $frmInscription = $ui->getForm( $module, 'FrmSocialEconomicInscription', $inscriptionData );
}
elseif ( $page == 7 ) //ENEM inscription
{
    $frmInscription = $ui->getForm( $module, 'FrmOtherSelectiveProcessInscription', $inscriptionData );
}
elseif ( $page == 6 )   //Option selective process
{
    $frmInscription = $ui->getForm( $module, 'FrmOptionsInscription', $inscriptionData );
}
elseif ( $page == 5 ) //Personal register informations
{
    //Tela para inscrição das pessoas que não estão inscritas
    $frmInscription = $ui->getForm( $module, 'FrmPersonInscription', $inscriptionData );
}
elseif ( $page == 4 ) //Se ESTIVER a pessoa cadastrada
{
    $frmInscription = $ui->getForm( $module, 'FrmPhysicalPersonRegistered', $inscriptionData );
}
elseif ( $page == 3 ) //Se NÃO ESTIVER a pessoa cadastrada
{
    $frmInscription = $ui->getForm( $module, 'FrmInformationsInscription', $inscriptionData );
}
elseif ( $page == 2 )  //Document verify
{
    $frmInscription = $ui->getForm( $module, 'FrmDocumentInscription', $inscriptionData );
}
elseif ( strlen($page) == 0 || $page == 1 ) //Begin page
{
    $frmInscription = $ui->getForm( $module, 'FrmInit', $inscriptionData );
}

$content = $frmInscription;

$theme->clearContent($content);
$theme->insertContent($content);


?>
