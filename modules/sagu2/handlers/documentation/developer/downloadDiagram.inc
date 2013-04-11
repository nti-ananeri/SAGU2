<?php

/**
 * Sagu2 diagrams documentation handler.
 * Constains script to download diagrams
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

$home = 'main:documentation:developer:downloadDiagram';
$navbar->addOption(_M('Download', $module), $module, $home);

$ui   = $MIOLO->getUI();
$file = MIOLO::_request('file');

//testa se o arquivo existe
if ( file_exists(DOCUMENTATION_PATH . '/diagrams/' . $file) )
{
    //testa tentativa de hackear, passando outros diretórios e se é um arquivo do dia
    if ( !( strpos($file, "/") > 0 ) && !( strpos($file, "..") > 0 ) && ( strpos($file, "dia") > 0 ) )
    {
        if ( $parse = file_get_contents('compress.zlib://' . DOCUMENTATION_PATH . '/diagrams/' . $file) )
        {
            header("Cache-Control: public, must-revalidate");
            header("Pragma: hack");
            header("Content-Type: " . 'dia/diagram');
            header("Content-Length: " .(string)(strlen($parse)) );
            header('Content-Disposition: attachment; filename="' . $file . '"');
            header("Content-Transfer-Encoding: binary\n");
            print $parse;
        }
    }
    else
    {
        //mensagem de erro de tentativa de acesso indevido
    }
}
else
{
    //mensgem de erro de arquivo inexistente
}

?>
