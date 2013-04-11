<?php

/**
 * Sagu2 coding standart documentation handler.
 * Constains script to download the coding standart document
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
 * Class created on 22/10/2006
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

$home = 'main:documentation:developer:miolo2';
$navbar->addOption(_M('Coding standart', $module), $module, $home);

$ui   = $MIOLO->getUI();
$file = MIOLO::_request('file');

//testa se o arquivo existe
if ( file_exists(DOCUMENTATION_PATH . '/miolo2_overview.pdf') )
{
    header("Cache-Control: public, must-revalidate");
    header("Content-Type: " . 'pdf');
    header("Content-Length: " .(string)(filesize(DOCUMENTATION_PATH . '/miolo2_overview.pdf')) );
    header('Content-Disposition: attachment; filename="miolo2_overview.pdf"');
    header("Content-Transfer-Encoding: binary\n");
    readfile(DOCUMENTATION_PATH . '/miolo2_overview.pdf');
}
else
{
    //mensgem de erro de arquivo inexistente
}

?>
